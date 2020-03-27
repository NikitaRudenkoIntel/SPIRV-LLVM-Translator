//===- CMExport.cpp - dll interface for SPIRV implementation -*- C++ -*----===//
//
//                     The LLVM/SPIR-V Translator
//
//===----------------------------------------------------------------------===//
//
// This file implements dll interface of SPIRV translator
//
//===----------------------------------------------------------------------===//

#include <algorithm>
#include <iostream>
#include <memory>
#include <utility>

#include "CMExport.h"
#include "LLVMSPIRVLib.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "SPIRVInternal.h"

int spirv_read_verify_module(char *pIn, size_t InSz, char **ppOut, size_t *pOutSz, char **ppErr, size_t *pErrSz) {
  LLVMContext Context;
  StringRef SpirvInput = StringRef(pIn, InSz);
  std::istringstream IS(SpirvInput);
  std::string ErrMsg;

  std::unique_ptr<llvm::Module> M;
  {
    llvm::Module *SpirM;
    bool ok = llvm::readSpirv(Context, IS, SpirM, ErrMsg);
    if (!ok) {
      llvm::errs() << "spirv_read_verify: readSpirv failed\n";
      return 0;
    }

    ok = llvm::verifyModule(*SpirM);
    if (ok) {
      llvm::errs() << "spirv_read_verify: verify Module failed\n";
      return 0;
    }

    M.reset(SpirM);
  }

  llvm::SmallVector<char, 16> CloneBuffer;
  llvm::raw_svector_ostream CloneOstream(CloneBuffer);
  WriteBitcodeToFile(*M, CloneOstream);

  assert(CloneBuffer.size() > 0);

  *pOutSz = CloneBuffer.size();
  *ppOut = static_cast<char *>(::operator new(*pOutSz));
  std::copy(CloneBuffer.begin(), CloneBuffer.end(), *ppOut);

  llvm::MemoryBufferRef BufferRef(llvm::StringRef(*ppOut, *pOutSz), "Deserialized SPIRV Module");
  auto ExpModule = llvm::parseBitcodeFile(BufferRef, Context);

  if (!ExpModule) {
    auto E = ExpModule.takeError();
    llvm::errs() << "Can not parse Module back just after serializing: " << E << "\n";
    return 0;
  }

  if (!ErrMsg.empty()) {
    *pErrSz = ErrMsg.size();
    *ppErr = static_cast<char *>(::operator new(*pErrSz));
    std::copy(ErrMsg.begin(), ErrMsg.end(), *ppErr);
  }

  return 1;
}


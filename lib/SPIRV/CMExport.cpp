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

int spirv_read_verify_module(const char *pIn, size_t InSz,
                             void (*OutSaver)(const char *pOut, size_t OutSize, void *OutUserData),
                             void *OutUserData,
                             void (*ErrSaver)(const char *pErrMsg, void *ErrUserData),
                             void *ErrUserData) {
  LLVMContext Context;
  StringRef SpirvInput = StringRef(pIn, InSz);
  std::istringstream IS(SpirvInput);

  std::unique_ptr<llvm::Module> M;
  {
    llvm::Module *SpirM;
    std::string ErrMsg;
    // This returns true on success...
    bool Status = llvm::readSpirv(Context, IS, SpirM, ErrMsg);
    if (!Status) {
      std::ostringstream OSS;
      OSS << "spirv_read_verify: readSpirv failed: " << ErrMsg;
      ErrSaver(OSS.str().c_str(), ErrUserData);
      return -1;
    }

    Status = llvm::verifyModule(*SpirM);
    if (Status) {
      ErrSaver("spirv_read_verify: verify Module failed", ErrUserData);
      return -1;
    }

    M.reset(SpirM);
  }

  llvm::SmallVector<char, 16> CloneBuffer;
  llvm::raw_svector_ostream CloneOstream(CloneBuffer);
  WriteBitcodeToFile(*M, CloneOstream);

  assert(CloneBuffer.size() > 0);

  OutSaver(CloneBuffer.data(), CloneBuffer.size(), OutUserData);
  return 0;
}


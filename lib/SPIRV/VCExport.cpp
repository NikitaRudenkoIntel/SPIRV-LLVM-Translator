//===- VCExport.cpp - dll interface for SPIRV implementation -*- C++ -*----===//
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

#include "LLVMSPIRVLib.h"
#include "SPIRVInternal.h"
#include "VCExport.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/MemoryBuffer.h"

SPIRV::TranslatorOpts GetTranslatorOpts() {
  std::map<std::string, ExtensionID> ExtensionNamesMap;
#define _STRINGIFY(X) #X
#define STRINGIFY(X) _STRINGIFY(X)
#define EXT(X) ExtensionNamesMap[STRINGIFY(X)] = ExtensionID::X;
#include "LLVMSPIRVExtensions.inc"
#undef EXT
#undef STRINGIFY
#undef _STRINGIFY

  SPIRV::TranslatorOpts::ExtensionsStatusMap ExtensionsStatus;
  // Set the initial state:
  //  - during SPIR-V consumption, assume that any known extension is allowed.
  //  - during SPIR-V generation, assume that any known extension is disallowed.
  //  - during conversion to/from SPIR-V text representation, assume that any
  //    known extension is allowed.
  for (const auto &It : ExtensionNamesMap)
    ExtensionsStatus[It.second] = true;
  SPIRV::TranslatorOpts Opts(VersionNumber::MaximumVersion, ExtensionsStatus);
  Opts.setFPContractMode(SPIRV::FPContractMode::On);
  Opts.setDesiredBIsRepresentation(SPIRV::BIsRepresentation::SPIRVFriendlyIR);
  return Opts;
}

int spirv_read_verify_module(
    const char *pIn, size_t InSz,
    void (*OutSaver)(const char *pOut, size_t OutSize, void *OutUserData),
    void *OutUserData, void (*ErrSaver)(const char *pErrMsg, void *ErrUserData),
    void *ErrUserData) {
  LLVMContext Context;
  StringRef SpirvInput = StringRef(pIn, InSz);
  std::istringstream IS(SpirvInput.str());

  std::unique_ptr<llvm::Module> M;
  {
    llvm::Module *SpirM;
    std::string ErrMsg;
    auto Opts = GetTranslatorOpts();
    // This returns true on success...
    bool Status = llvm::readSpirv(Context, Opts, IS, SpirM, ErrMsg);
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

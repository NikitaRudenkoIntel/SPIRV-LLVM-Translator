//===- CMUtil.h    -   CM Utilities declarations -*- C++ -*-===//
//
//                     The LLVM/SPIR-V Translator
//
//
//
//===----------------------------------------------------------------------===//
//
// This file implements translation of CM float control bits
//
//===----------------------------------------------------------------------===//

#ifndef SPIRV_CMUTIL_H
#define SPIRV_CMUTIL_H

#include "SPIRVUtil.h"
#include "spirv.hpp"
#include "llvm/IR/Module.h"

namespace CMUtil {

///////////////////////////////////////////////////////////////////////////////
//
// Types
//
///////////////////////////////////////////////////////////////////////////////

enum CmRoundMode {
  RTE, // Round to nearest or even
  RTP, // Round towards +ve inf
  RTN, // Round towards -ve inf
  RTZ, // Round towards zero
};
enum CmDenormMode {
  FlushToZero,
  Preserve,
};
enum CmFloatMode {
  IEEE, // Single precision float IEEE mode
  ALT,  // Single precision float ALT mode
};
enum CmFloatType {
  Double,
  Float,
  Half,
};
CmRoundMode getRoundMode(unsigned FloatControl) noexcept;
CmDenormMode getDenormPreserve(unsigned FloatControl,
                               CmFloatType FloatType) noexcept;
CmFloatMode getFloatMode(unsigned FloatControl) noexcept;
unsigned getCMFloatControl(CmRoundMode RoundMode) noexcept;
unsigned getCMFloatControl(CmFloatMode FloatMode) noexcept;
unsigned getCMFloatControl(CmDenormMode DenormMode,
                           CmFloatType FloatType) noexcept;

typedef SPIRV::SPIRVMap<CmRoundMode, spv::ExecutionMode> CMRoundModeExecModeMap;
typedef SPIRV::SPIRVMap<CmFloatMode, spv::ExecutionMode> CMFloatModeExecModeMap;
typedef SPIRV::SPIRVMap<CmDenormMode, spv::ExecutionMode>
    CMDenormModeExecModeMap;
typedef SPIRV::SPIRVMap<CmFloatType, unsigned> CMFloatTypeSizeMap;

enum KernelMDOp {
  FunctionRef,  // Reference to Function
  Name,         // Kernel name
  ArgKinds,     // Reference to metadata node containing kernel arg kinds
  SLMSize,      // SLM-size in bytes
  ArgOffsets,   //- Kernel argument offsets
  ArgIOKinds,   //- Reference to metadata node containing kernel argument
                // input/output kinds
  ArgTypeDescs, // Kernel argument type descriptors
  NBarrierCnt,  // Named barrier count
  BarrierCnt    // Barrier count
};

///////////////////////////////////////////////////////////////////////////////
//
// Functions
//
///////////////////////////////////////////////////////////////////////////////

bool isSourceLanguageCM(llvm::Module *M);

} // namespace CMUtil

///////////////////////////////////////////////////////////////////////////////
//
// Constants
//
///////////////////////////////////////////////////////////////////////////////

namespace kCMMetadata {
const static char GenXKernels[] = "genx.kernels";
const static char GenXByteOffset[] = "genx_byte_offset";
const static char GenXVolatile[] = "genx_volatile";
const static char CMGenXMain[] = "CMGenxMain";
const static char CMStackCall[] = "CMStackCall";
const static char CMFloatControl[] = "CMFloatControl";
const static char OCLRuntime[] = "oclrt";
} // namespace kCMMetadata

///////////////////////////////////////////////////////////////////////////////
//
// Map definitions
//
///////////////////////////////////////////////////////////////////////////////

namespace SPIRV {
template <>
inline void SPIRVMap<CMUtil::CmRoundMode, spv::ExecutionMode>::init() {
  add(CMUtil::RTE, spv::ExecutionModeRoundingModeRTE);
  add(CMUtil::RTZ, spv::ExecutionModeRoundingModeRTZ);
  add(CMUtil::RTP, spv::ExecutionModeRoundingModeRTPINTEL);
  add(CMUtil::RTN, spv::ExecutionModeRoundingModeRTNINTEL);
}
template <>
inline void SPIRVMap<CMUtil::CmDenormMode, spv::ExecutionMode>::init() {
  add(CMUtil::FlushToZero, spv::ExecutionModeDenormFlushToZero);
  add(CMUtil::Preserve, spv::ExecutionModeDenormPreserve);
}
template <>
inline void SPIRVMap<CMUtil::CmFloatMode, spv::ExecutionMode>::init() {
  add(CMUtil::IEEE, spv::ExecutionModeFloatingPointModeIEEEINTEL);
  add(CMUtil::ALT, spv::ExecutionModeFloatingPointModeALTINTEL);
}
template <> inline void SPIRVMap<CMUtil::CmFloatType, unsigned>::init() {
  add(CMUtil::Double, 64);
  add(CMUtil::Float, 32);
  add(CMUtil::Half, 16);
}
} // namespace SPIRV

#endif // SPIRV_CMUTIL_H

//===- CMUtil.h - Converts CM float control bits -*- C++ -*-===//
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

#include "SPIRVInternal.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/Path.h"

#include <functional>
#include <tuple>
#include <type_traits>
#include <utility>
using namespace SPIRV;
using namespace llvm;
using namespace spv;

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

#ifdef __INTEL_EMBARGO__
typedef SPIRVMap<CmRoundMode, spv::ExecutionMode> CMRoundModeExecModeMap;
typedef SPIRVMap<CmFloatMode, spv::ExecutionMode> CMFloatModeExecModeMap;
typedef SPIRVMap<CmDenormMode, spv::ExecutionMode> CMDenormModeExecModeMap;
#endif // __INTEL_EMBARGO__
typedef SPIRVMap<CmFloatType, unsigned> CMFloatTypeSizeMap;

} // namespace CMUtil

///////////////////////////////////////////////////////////////////////////////
//
// Map definitions
//
///////////////////////////////////////////////////////////////////////////////

using namespace CMUtil;
namespace SPIRV {
#ifdef __INTEL_EMBARGO__
template <> inline void SPIRVMap<CmRoundMode, spv::ExecutionMode>::init() {
  add(RTE, ExecutionModeRoundingModeRTE);
  add(RTZ, ExecutionModeRoundingModeRTZ);
  add(RTP, ExecutionModeRoundingModeRTPINTEL);
  add(RTN, ExecutionModeRoundingModeRTNINTEL);
}
template <> inline void SPIRVMap<CmDenormMode, spv::ExecutionMode>::init() {
  add(FlushToZero, ExecutionModeDenormFlushToZero);
  add(Preserve, ExecutionModeDenormPreserve);
}
template <> inline void SPIRVMap<CmFloatMode, spv::ExecutionMode>::init() {
  add(IEEE, ExecutionModeFloatingPointModeIEEEINTEL);
  add(ALT, ExecutionModeFloatingPointModeALTINTEL);
}
#endif // __INTEL_EMBARGO__
template <> inline void SPIRVMap<CmFloatType, unsigned>::init() {
  add(Double, 64);
  add(Float, 32);
  add(Half, 16);
}
} // namespace SPIRV

#endif // SPIRV_CMUTIL_H

//===- CMUtil.cpp -    CM Utilities implementation -*- C++ -*-===//
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

#include "CMUtil.h"
#include "SPIRVInternal.h"
#include "llvm/IR/Metadata.h"
using namespace CMUtil;
using namespace SPIRV;

enum CmFloatControl {
  CM_RTE = 0,      // Round to nearest or even
  CM_RTP = 1 << 4, // Round towards +ve inf
  CM_RTN = 2 << 4, // Round towards -ve inf
  CM_RTZ = 3 << 4, // Round towards zero

  CM_DENORM_FTZ = 0,            // Denorm mode flush to zero
  CM_DENORM_D_ALLOW = 1 << 6,   // Denorm mode double allow
  CM_DENORM_F_ALLOW = 1 << 7,   // Denorm mode float allow
  CM_DENORM_HF_ALLOW = 1 << 10, // Denorm mode half allow

  CM_FLOAT_MODE_IEEE = 0, // Single precision float IEEE mode
  CM_FLOAT_MODE_ALT = 1   // Single precision float ALT mode
};

enum CmFloatControlMask {
  CM_ROUND_MASK = (CM_RTE | CM_RTP | CM_RTN | CM_RTZ),
  CM_FLOAT_MASK = (CM_FLOAT_MODE_IEEE | CM_FLOAT_MODE_ALT)
};

typedef SPIRVMap<CmRoundMode, CmFloatControl> CMRoundModeControlBitMap;
typedef SPIRVMap<CmFloatMode, CmFloatControl> CMFloatModeControlBitMap;
typedef SPIRVMap<CmFloatType, CmFloatControl> CMFloatTypeDenormMaskMap;
template <> inline void SPIRVMap<CmRoundMode, CmFloatControl>::init() {
  add(RTE, CM_RTE);
  add(RTP, CM_RTP);
  add(RTN, CM_RTN);
  add(RTZ, CM_RTZ);
}
template <> inline void SPIRVMap<CmFloatMode, CmFloatControl>::init() {
  add(IEEE, CM_FLOAT_MODE_IEEE);
  add(ALT, CM_FLOAT_MODE_ALT);
}
template <> inline void SPIRVMap<CmFloatType, CmFloatControl>::init() {
  add(Double, CM_DENORM_D_ALLOW);
  add(Float, CM_DENORM_F_ALLOW);
  add(Half, CM_DENORM_HF_ALLOW);
}

namespace CMUtil {

CmRoundMode getRoundMode(unsigned FloatControl) noexcept {
  return CMRoundModeControlBitMap::rmap(
      CmFloatControl(CM_ROUND_MASK & FloatControl));
}

CmDenormMode getDenormPreserve(unsigned FloatControl,
                               CmFloatType FloatType) noexcept {
  CmFloatControl DenormMask =
      CMFloatTypeDenormMaskMap::map(FloatType); // 1 Bit mask
  return (DenormMask == (DenormMask & FloatControl)) ? Preserve : FlushToZero;
}

CmFloatMode getFloatMode(unsigned FloatControl) noexcept {
    return CMFloatModeControlBitMap::rmap(
        CmFloatControl(CM_FLOAT_MASK & FloatControl));
}

unsigned getCMFloatControl(CmRoundMode RoundMode) noexcept {
  return CMRoundModeControlBitMap::map(RoundMode);
}
unsigned getCMFloatControl(CmFloatMode FloatMode) noexcept {
  return CMFloatModeControlBitMap::map(FloatMode);
}
unsigned getCMFloatControl(CmDenormMode DenormMode,
                           CmFloatType FloatType) noexcept {
  if (DenormMode == Preserve)
    return CMFloatTypeDenormMaskMap::map(FloatType);
  return CM_DENORM_FTZ;
}

bool isSourceLanguageCM(llvm::Module *M) {
  llvm::NamedMDNode *NamedMD = M->getNamedMetadata(kCMMetadata::GenXKernels);
  if (!NamedMD)
    return false;
  return true;
}

} // namespace CMUtil

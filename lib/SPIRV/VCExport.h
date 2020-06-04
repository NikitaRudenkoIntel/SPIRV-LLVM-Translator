//===- VCExport.h - Adding possibility to build spirv as a dll -*- C++ -*-===//
//
//                     The LLVM/SPIR-V Translator
//
//===----------------------------------------------------------------------===//
//
// This file is kind of a temporal solution
// We need to live in separate DLL while IGC default SPIRV is not ready
//
//===----------------------------------------------------------------------===//

#ifndef SPIRV_VCEXPORT_H
#define SPIRV_VCEXPORT_H

#ifdef _WIN32
#define __EXPORT__ __declspec(dllexport)
#else
#define __EXPORT__ __attribute__((visibility("default")))
#endif

// Returns zero on success.
extern "C" __EXPORT__ int spirv_read_verify_module(
    const char *pIn, size_t InSz,
    void (*OutSaver)(const char *pOut, size_t OutSize, void *OutUserData),
    void *OutUserData, void (*ErrSaver)(const char *pErrMsg, void *ErrUserData),
    void *ErrUserData);

#endif // SPIRV_VCEXPORT_H

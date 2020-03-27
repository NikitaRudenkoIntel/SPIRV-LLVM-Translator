//===- CMExport.h - Adding possibility to build spirv as a dll -*- C++ -*-===//
//
//                     The LLVM/SPIR-V Translator
//
//===----------------------------------------------------------------------===//
//
// This file is kind of a temporal solution
// We need to live in separate DLL while IGC default SPIRV is not ready
//
//===----------------------------------------------------------------------===//

#ifndef SPIRV_CMEXPORT_H
#define SPIRV_CMEXPORT_H

#ifdef _WIN32
  #define __EXPORT__ __declspec(dllexport)
#else
  #define __EXPORT__ __attribute__((visibility("default")))
#endif

// zero result means failure
extern "C" __EXPORT__ int spirv_read_verify_module(char *pin, size_t insz, char **ppout, size_t *poutsz, char **pperr, size_t *perrsz);

#endif // SPIRV_CMEXPORT_H

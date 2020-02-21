//===-- GenXKernelMDOps.h - Kernel information support ----------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//  Copyright  (C) 2015 Intel Corporation. All rights reserved.
//
// The information and source code contained herein is the exclusive
// property of Intel Corporation and may not be disclosed, examined
// or reproduced in whole or in part without explicit written authorization
// from the company.
//
//===----------------------------------------------------------------------===//
//
// This file defines operand numbers to work with kernel metadata.
//
//===----------------------------------------------------------------------===//

#ifndef GENX_KERNEL_MDOPS_H
#define GENX_KERNEL_MDOPS_H

namespace llvm {
namespace genx {
enum KernelMDOp {
  FunctionRef,  // Reference to Function
  Name,         // Kernel name
  ArgKinds,     // Reference to metadata node containing kernel arg kinds
  SLMSize,      // SLM-size in bytes
  ArgOffsets,   // Kernel argument offsets
  ArgIOKinds,   // Reference to metadata node containing kernel argument
                // input/output kinds
  ArgTypeDescs, // Kernel argument type descriptors
  NBarrierCnt,  // Named barrier count
  BarrierCnt    // Barrier count
};
} // namespace genx
} // namespace llvm

#endif
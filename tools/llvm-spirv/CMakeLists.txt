set(LLVM_LINK_COMPONENTS
  SPIRVLib
  Analysis
  BitReader
  BitWriter
  Core
  Support
  TransformUtils
)

add_llvm_tool(llvm-spirv-vc
  llvm-spirv.cpp
  # llvm_setup_rpath messes with the rpath making llvm-spirv not executable from the build directory
  NO_INSTALL_RPATH
)

target_include_directories(llvm-spirv-vc
  PRIVATE
    ${LLVM_INCLUDE_DIRS}
    ${LLVM_SPIRV_INCLUDE_DIRS}
)

set(SPIRV_SOURCES
  CMExport.cpp
  LLVMToSPIRVDbgTran.cpp
  Mangler/FunctionDescriptor.cpp
  Mangler/Mangler.cpp
  Mangler/ManglingUtils.cpp
  Mangler/ParameterType.cpp
  OCL20ToSPIRV.cpp
  OCL21ToSPIRV.cpp
  OCLTypeToSPIRV.cpp
  OCLUtil.cpp
  CMUtil.cpp
  SPIRVLowerBool.cpp
  SPIRVLowerConstExpr.cpp
  SPIRVLowerMemmove.cpp
  SPIRVLowerOCLBlocks.cpp
  SPIRVLowerSPIRBlocks.cpp
  SPIRVReader.cpp
  SPIRVRegularizeLLVM.cpp
  SPIRVToLLVMDbgTran.cpp
  SPIRVToOCL.cpp
  SPIRVToOCL12.cpp
  SPIRVToOCL20.cpp
  SPIRVUtil.cpp
  SPIRVWriter.cpp
  SPIRVWriterPass.cpp
  PreprocessMetadata.cpp
  libSPIRV/SPIRVBasicBlock.cpp
  libSPIRV/SPIRVDebug.cpp
  libSPIRV/SPIRVDecorate.cpp
  libSPIRV/SPIRVEntry.cpp
  libSPIRV/SPIRVFunction.cpp
  libSPIRV/SPIRVInstruction.cpp
  libSPIRV/SPIRVModule.cpp
  libSPIRV/SPIRVStream.cpp
  libSPIRV/SPIRVType.cpp
  libSPIRV/SPIRVValue.cpp
)

add_llvm_library(LLVMSPIRVLib
  ${SPIRV_SOURCES}
  LINK_COMPONENTS
    Analysis
    BitWriter
    Core
    Support
    TransformUtils
  DEPENDS
    intrinsics_gen
)

# --- mock: add_llvm_library(SPIRVDLL MODULE ---
# unfortunately this do not work for llvm build system as is so some magic below

add_library(SPIRVDLL MODULE
  ${SPIRV_SOURCES}
)

llvm_update_compile_flags(SPIRVDLL)

add_dependencies(SPIRVDLL intrinsics_gen LLVMAnalysis LLVMBitWriter LLVMCore LLVMSupport LLVMTransformUtils)
target_link_libraries(SPIRVDLL LLVMAnalysis LLVMBitWriter LLVMCore LLVMSupport LLVMTransformUtils)

if(NOT WIN32)
  target_link_options(SPIRVDLL PRIVATE -Bsymbolic)
endif()

install(TARGETS SPIRVDLL
        EXPORT LLVMExports
        LIBRARY DESTINATION lib
        COMPONENT SPIRVDLL)

if(WIN32)
  install(FILES $<TARGET_PDB_FILE:SPIRVDLL>
          CONFIGURATIONS Debug RelWithDebInfo Release
          DESTINATION lib)
endif()

add_llvm_install_targets(install-SPIRVDLL
                         DEPENDS SPIRVDLL
                         COMPONENT SPIRVDLL)

set_property(GLOBAL APPEND PROPERTY LLVM_EXPORTS SPIRVDLL)


if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC" AND CMAKE_BUILD_TYPE MATCHES "Release")
   target_compile_options(SPIRVDLL PRIVATE /Zi)

   # Tell linker to include symbol data
    set_target_properties(SPIRVDLL PROPERTIES
        LINK_FLAGS "/INCREMENTAL:NO /DEBUG /OPT:REF /OPT:ICF"
    )

    # Set file name & location
    set_target_properties(SPIRVDLL PROPERTIES
        COMPILE_PDB_NAME SPIRVDLL
        COMPILE_PDB_OUTPUT_DIR ${CMAKE_BINARY_DIR}
    )
endif()

# --- end mock ---

target_include_directories(LLVMSPIRVLib
  PRIVATE
    ${LLVM_INCLUDE_DIRS}
    ${LLVM_SPIRV_INCLUDE_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/libSPIRV
    ${CMAKE_CURRENT_SOURCE_DIR}/Mangler
)

target_include_directories(SPIRVDLL
  PRIVATE
    ${LLVM_INCLUDE_DIRS}
    ${LLVM_SPIRV_INCLUDE_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/libSPIRV
    ${CMAKE_CURRENT_SOURCE_DIR}/Mangler
)

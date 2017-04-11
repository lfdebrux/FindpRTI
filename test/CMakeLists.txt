cmake_minimum_required(VERSION 3.0)
project(TestFindpRTI VERSION 1.0.0 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/..")

set(CMAKE_INSTALL_PATH "${CMAKE_INSTALL_PREFIX}/lib")

# ==============================================================================
# Print input variables used by FindpRTI.cmake

message("CMAKE_SYSTEM_NAME = '${CMAKE_SYSTEM_NAME}'")
message("CMAKE_BUILD_TYPE  = '${CMAKE_BUILD_TYPE}'")

message("User Input Variables:")
message("pRTI_ROOT_DIR     = '${pRTI_ROOT_DIR}'")
message("pRTI_INCLUDE_DIR  = '${pRTI_INCLUDE_DIR}'")
message("pRTI_LIBRARY      = '${pRTI_LIBRARY}'")
message("pRTI_time_LIBRARY = '${pRTI_time_LIBRARY}'")

message("Environment Varaibles used by FindpRTI:")
message("pRTI_INSTALL_DIR  = '$ENV{pRTI_INSTALL_DIR}'")
message("PITCH_HOME             = '$ENV{PITCH_HOME}'")
message("LIBRARY_PATH           = '$ENV{LIBRARY_PATH}'")

message("System Variables used by FindpRTI:")
message("CMAKE_SYSTEM_NAME      = ${CMAKE_SYSTEM_NAME}")
message("CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")

find_package(pRTI)

# ==============================================================================
# Print output variables from FindpRTI.cmake

message("FindpRTI Result Variables:")
message("pRTI_FOUND        = '${pRTI_FOUND}'")
foreach(_comp ${pRTI_SEARCH_COMPONENTS})
	message("pRTI_${_comp}_FOUND = '${pRTI_${_comp}_FOUND}'")
endforeach()
foreach(_comp ${pRTI_SEARCH_COMPONENTS})
	message("pRTI_${_comp}_LIBRARY = '${pRTI_${_comp}_LIBRARY}'")
endforeach()
foreach(_comp ${pRTI_JAVA_COMPONENTS})
	message("pRTI_${_comp}_FOUND = '${pRTI_${_comp}_FOUND}'")
endforeach()
foreach(_comp ${pRTI_JAVA_COMPONENTS})
	message("pRTI_${_comp}_LIBRARY = '${pRTI_${_comp}_LIBRARY}'")
endforeach()

message("FindpRTI Output Variables:")
message("pRTI_INCLUDE_DIRS = '${pRTI_INCLUDE_DIRS}'")
message("pRTI_LIBRARIES    = '${pRTI_LIBRARIES}'")
message("pRTI_DEFINITIONS  = '${pRTI_DEFINITIONS}'")

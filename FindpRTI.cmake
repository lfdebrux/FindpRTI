include(FindPackageHandleStandardArgs)

if(NOT pRTI_FOUND)

  ##################################
  # Set the pRTI search directories
  ##################################

  # Define search paths based on user input and environment variables
  set(pRTI_SEARCH_DIR ${pRTI_ROOT_DIR} $ENV{pRTI_INSTALL_DIR} $ENV{PITCH_HOME})

  # Define the search directories based on the current platform
  if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(pRTI_DEFAULT_SEARCH_DIR "/opt/prti1516e")

    # TODO: Check compiler version to see the suffix should be gcc34 or
    #       gcc41. For now, assume that the compiler is more recent than
    #       gcc 4.1.x or later.
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
      set(pRTI_LIB_PATH_SUFFIX "lib/gcc41_64")
      set(pRTI_SEARCH_COMPONENTS fedtime1516e64 rti1516e64)
      set(pRTI_JRE_PATH_SUFFIX "jre/lib/amd64" "jre/lib/amd64/native_threads" "jre/lib/amd64/server")
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^i.86$")
      set(pRTI_LIB_PATH_SUFFIX "lib/gcc41")
      set(pRTI_SEARCH_COMPONENTS fedtime1516e rti1516e)
      set(pRTI_JRE_PATH_SUFFIX "jre/lib/i386" "jre/lib/i386/native_threads" "jre/lib/i386/client")
    endif()
  endif()

  ##################################
  # Find the pRTI include dir
  ##################################

  find_path(pRTI_INCLUDE_DIRS RTI/RTI1516.h
    HINTS ${pRTI_INCLUDE_DIR} ${pRTI_SEARCH_DIR}
    PATHS ${pRTI_DEFAULT_SEARCH_DIR}
    PATH_SUFFIXES include)

  ##################################
  # Find the libraries
  ##################################

  # Find each component
  foreach(_comp ${pRTI_SEARCH_COMPONENTS})
    # if(";${prti_FIND_COMPONENTS};" MATCHES ";${_comp};")

      # Search for the libraries
      find_library(pRTI_${_comp}_LIBRARY ${_comp}
        HINTS ${pRTI_LIBRARY} ${pRTI_SEARCH_DIR}
        PATH ${pRTI_DEFAULT_SEARCH_DIR} ENV LIBRARY_PATH
        PATH_SUFFIXES ${pRTI_LIB_PATH_SUFFIX})

      if(pRTI_${_comp}_LIBRARY)
        list(APPEND pRTI_LIBRARIES "${pRTI_${_comp}_LIBRARY}")
      endif()

      if(pRTI_${_comp}_LIBRARY AND EXISTS "${pRTI_${_comp}_LIBRARY}")
        set(pRTI_${_comp}_FOUND TRUE)
      else()
        set(pRTI_${_comp}_FOUND FALSE)
      endif()

      mark_as_advanced(pRTI_${_comp}_LIBRARY)

    # endif()
  endforeach()

  ##################################
  # Use JRE distributed with Pitch
  ##################################

  set(pRTI_JAVA_COMPONENTS java jvm verify)

  foreach(_comp ${pRTI_JAVA_COMPONENTS})

    find_library(pRTI_${_comp}_LIBRARY ${_comp}
      HINTS ${pRTI_LIBRARY} ${pRTI_SEARCH_DIR}
      PATH ${pRTI_DEFAULT_SEARCH_DIR} ENV LIBRARY_PATH
      PATH_SUFFIXES ${pRTI_JRE_PATH_SUFFIX})

    if(pRTI_${_comp}_LIBRARY)
      list(APPEND pRTI_LIBRARIES "${pRTI_${_comp}_LIBRARY}")
    endif()

    if(pRTI_${_comp}_LIBRARY AND EXISTS "${pRTI_${_comp}_LIBRARY}")
      set(pRTI_${_comp}_FOUND TRUE)
    else()
      set(pRTI_${_comp}_FOUND FALSE)
    endif()

    mark_as_advanced(pRTI_${_comp}_LIBRARY)

  endforeach()

  ##################################
  # Set compile flags and libraries
  ##################################

  set(pRTI_DEFINITIONS _GLIBCXX_USE_CXX11_ABI=0) # there may be a better way to do this

  # set(pRTI_LIBRARIES "${pRTI_LIBRARIES}")

  find_package_handle_standard_args(pRTI
      REQUIRED_VARS pRTI_INCLUDE_DIRS pRTI_LIBRARIES)
      # HANDLE_COMPONENTS)

  mark_as_advanced(pRTI_INCLUDE_DIRS pRTI_LIBRARIES)

  unset(pRTI_LIB_PATH_SUFFIX)
  unset(pRTI_DEFAULT_SEARCH_DIR)

endif()

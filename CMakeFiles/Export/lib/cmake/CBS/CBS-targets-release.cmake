#----------------------------------------------------------------
# Generated CMake target import file for configuration "RELEASE".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "CBS::CBS" for configuration "RELEASE"
set_property(TARGET CBS::CBS APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(CBS::CBS PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libCBS.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS CBS::CBS )
list(APPEND _IMPORT_CHECK_FILES_FOR_CBS::CBS "${_IMPORT_PREFIX}/lib/libCBS.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

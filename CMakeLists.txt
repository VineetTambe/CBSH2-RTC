project(cbs)

cmake_minimum_required(VERSION 3.8)

IF(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE "RELEASE")
ENDIF()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

set(version 0.1.0)

include_directories("inc")
file(GLOB SOURCES "src/*.cpp")
add_executable(cbs ${SOURCES})

# Find Boost
find_package(Boost REQUIRED COMPONENTS program_options system filesystem)
include_directories( ${Boost_INCLUDE_DIRS} )
target_link_libraries(cbs ${Boost_LIBRARIES})

# Add the library target
add_library(CBS ${SOURCES})

# Set include directories for library users
target_include_directories(CBS
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Specify any additional dependencies
target_link_libraries(CBS
    PUBLIC
        ${Boost_LIBRARIES}
)

# Specify installation rules
include(GNUInstallDirs)
install(TARGETS CBS
        EXPORT CBSTargets
        # LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        # ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        # RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR} # include
)

# Export CMake config
install(EXPORT CBSTargets
    FILE "CBSTargets.cmake"
    NAMESPACE CBS::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/CBS
)

include(CMakePackageConfigHelpers)

# generate the version file for the config file
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/CBSConfigVersion.cmake"
    VERSION "${version}"
    COMPATIBILITY AnyNewerVersion
)
# create config file
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/CBSConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/CBSConfig.cmake"
    INSTALL_DESTINATION cmake
)

# generate the export targets for the build tree
export(EXPORT "CBSTargets"
    FILE "${CMAKE_CURRENT_BINARY_DIR}/CBSTargets.cmake"
    NAMESPACE ${namespace}::
)

# install config files
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/CBSConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/CBSConfigVersion.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/CBSTargets.cmake"
    DESTINATION cmake
)

# Install command
# install(TARGETS cbs DESTINATION bin)

# https://decovar.dev/blog/2021/03/08/cmake-cpp-library/
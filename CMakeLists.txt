# 0.) Create Source and CMakeFiles.txt
# 1.) mkdir build
# 2.) cd build
# 3.) cmake ..  - Generating the Build Files / Configure the Project
# 4.) cmake --build .
# 5.) ./Executable

cmake_minimum_required(VERSION 3.16)

project(
    CppProjectTemplate
    VERSION 1.0.0
    LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_CXX_EXTENSIONS        OFF)

option(ENABLE_TESTING "Enable a Unit Testing Build" ON)

option(ENABLE_WARNINGS "Enable warnings" ON)
option(ENABLE_WARNINGS_AS_ERRORS "Enable warnings as errors" ON)

option(ENABLE_SANITIZER_ADDR "Enable ..." ON)
option(ENABLE_SANITIZER_UNDEF "Enable ..." ON)

option(ENABLE_LTO "Enable ..." ON)

option(USE_CPM "Whether to use CPM" OFF)
option(USE_CONAN "Whether to use Conan" OFF)
option(USE_VCPKG "Whether to use VCPKG" ON)

set(LIBRARY_NAME Library)
set(EXECUTABLE_NAME Executable)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include(AddGitSubmodule)
include(Docs)

if(ENABLE_SANITIZER_ADDR OR ENABLE_SANITIZER_UNDEF)
    include(Sanitizers)
    add_sanitizer_flag()
endif()

if(ENABLE_WARNINGS)
    include(Warnings)
endif()

if(ENABLE_LTO)
    include(LTO)
endif()

if(USE_CPM)
    message(STATUS "Using CPM")
    include(CPM)
    cpmaddpackage("gh:nlohmann/json#v3.11.2")
    cpmaddpackage("gh:fmtlib/fmt#9.1.0")
    cpmaddpackage("gh:gabime/spdlog#v1.11.0")
    cpmaddpackage("gh:jarro2783/cxxopts#v3.1.1")
    if(ENABLE_TESTING)
        cpmaddpackage("gh:catchorg/Catch2#v3.5.3")
    endif()
elseif(USE_CONAN)
    message(STATUS "Using Conan")
    include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)
    find_package(nlohmann_json REQUIRED)
    find_package(fmt REQUIRED)
    find_package(spdlog REQUIRED)
    find_package(cxxopts REQUIRED)
    find_package(Catch2 REQUIRED)
elseif(USE_VCPKG)
    message(STATUS "Using VCPKG")
    include(${PROJECT_SOURCE_DIR}/external/vcpkg/scripts/buildsystems/vcpkg.cmake)
    find_package(nlohmann_json REQUIRED)
    find_package(fmt REQUIRED)
    find_package(spdlog REQUIRED)
    find_package(cxxopts REQUIRED)
    find_package(Catch2 REQUIRED)
else()
    message(STATUS "Using FetchContent")
    include(FetchContent)
    FetchContent_Declare(
        nlohmann_json
        GIT_REPOSITORY https://github.com/nlohmann/json
        GIT_TAG v3.11.2
        GIT_SHALLOW TRUE
    )
    FetchContent_MakeAvailable(nlohmann_json)

    FetchContent_Declare(
        fmt
        GIT_REPOSITORY https://github.com/fmtlib/fmt
        GIT_TAG 9.1.0
        GIT_SHALLOW TRUE
    )
    FetchContent_MakeAvailable(fmt)

    FetchContent_Declare(
        spdlog
        GIT_REPOSITORY https://github.com/gabime/spdlog
        GIT_TAG v1.11.0
        GIT_SHALLOW TRUE
    )
    FetchContent_MakeAvailable(spdlog)

    FetchContent_Declare(
        cxxopts
        GIT_REPOSITORY https://github.com/jarro2783/cxxopts
        GIT_TAG v3.1.1
        GIT_SHALLOW TRUE
    )
    FetchContent_MakeAvailable(cxxopts)

    if(ENABLE_TESTING)
        FetchContent_Declare(
            Catch2
            GIT_REPOSITORY https://github.com/catchorg/Catch2
            GIT_TAG v3.5.3
            GIT_SHALLOW TRUE
        )
        FetchContent_MakeAvailable(Catch2)
    endif()
endif()
list(APPEND CMAKE_MODULE_PATH ${Catch2_SOURCE_DIR}/extras)
#add_git_submodule(external/json)

add_subdirectory(cfg)
add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(app)
if(ENABLE_TESTING)
    include(CTest)
    enable_testing()
    add_subdirectory(tests)
endif()

target_compile_definitions(${LIBRARY_NAME} PUBLIC PRINTER_ACTIVE)

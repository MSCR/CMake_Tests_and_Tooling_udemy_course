function(target_set_warnings TARGET ENABLE AS_ERRORS)
    if(NOT ${ENABLED})
        message(STATUS "Warnings disable for: ${TARGET}")
        return()
    endif()

    set(MSVC_COMPILER
        /W4
        /permissive-)

    set(CLANG_COMPILER
        -Wall
        -Wextra
        -Wpedantic)

    set(GCC_COMPILER ${CLANG_COMPILER})

    if(${ENABLE_AS_ERRORS})
        set(MSVC_COMPILER ${MSVC_COMPILER} /WX)
        set(CLANG_COMPILER ${CLANG_COMPILER} -Werror)
        set(GCC_COMPILER ${GCC_COMPILER} -Werror)
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(WARNINGS ${MSVC_COMPILER})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "CLANG")
        set(WARNINGS ${CLANG_COMPILER})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(WARNINGS ${GCC_COMPILER})
    endif()

    target_compile_options(${TARGET} PRIVATE ${WARNINGS})
    message(STATUS ${WARNINGS})

endfunction(target_set_warnings)

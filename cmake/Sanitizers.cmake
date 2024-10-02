function(add_sanitizer_flag)

    if(NOT ${ENABLE_SANITIZER_ADDR} AND NOT ${ENABLE_SANITIZER_UNDEF})
        message(STATUS "Sanitizers deactivate")
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "CLANG" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        add_compile_options("-fno-omit-frame-pointer")
        add_link_options("-fno-omit-frame-pointer")

        if(${ENABLE_SANITIZER_ADDR})
            add_compile_options("-fsanitize=address")
            add_link_options("-fsanitize=address")
        endif()

        if(${ENABLE_SANITIZER_UNDEF})
            add_compile_options("-fsanitize=undefined")
            add_link_options("-fsanitize=undefined")
        endif()
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        if(${ENABLE_SANITIZER_ADDR})
            add_compile_options("/fsanitize=address")
        endif()

        if(${ENABLE_SANITIZER_UNDEF})
            message(STATUS "Undefined sanitizer not impl. for MSVC")
        endif()
    else()
        message(ERROR "Compiler not supported for Sanitizers")
    endif()

endfunction(add_sanitizer_flag)

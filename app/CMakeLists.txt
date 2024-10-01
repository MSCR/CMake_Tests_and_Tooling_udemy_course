set(EXECUTABLE_FILES
    main.cc)

add_executable(${EXECUTABLE_NAME}
    ${EXECUTABLE_FILES})
target_link_libraries(${EXECUTABLE_NAME} PUBLIC
    ${LIBRARY_NAME}
    nlohmann_json)

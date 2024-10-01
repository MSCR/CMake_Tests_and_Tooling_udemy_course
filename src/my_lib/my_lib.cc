#include <iostream>

#include <cxxopts.hpp>
#include <fmt/format.h>
#include <spdlog/spdlog.h>
#include <nlohmann/json.hpp>

#include "my_lib.h"


/**
 * @brief Prints out hello world and test the JSON Lib.
 *
 */
void print_hello_world()
{
    std::cout << "Hello World!!" << std::endl ;

    std::cout << "JSON Lib Version:"
        << NLOHMANN_JSON_VERSION_MAJOR << "."
        << NLOHMANN_JSON_VERSION_MINOR << "."
        << NLOHMANN_JSON_VERSION_PATCH << std::endl;

    std::cout << "FMT Lib Version:"
        << FMT_VERSION << std::endl;

    std::cout << "CXXOPTS Lib Version:"
        << CXXOPTS__VERSION_MAJOR << "."
        << CXXOPTS__VERSION_MINOR << "."
        << CXXOPTS__VERSION_PATCH << std::endl;

    std::cout << "SPDLOG Lib Version:"
        << SPDLOG_VER_MAJOR << "."
        << SPDLOG_VER_MINOR << "."
        << SPDLOG_VER_PATCH << std::endl;

}

unsigned int factorial(unsigned int number)
{
    return number <= 1 ? number : factorial(number-1)*number;
}

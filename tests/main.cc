//#define CATCH_CONFIG_MAIN // This tells Catch to provide a main() - only
#include <catch2/catch_test_macros.hpp>

#include "my_lib.h"

TEST_CASE( "Factorials are computed", "[factorial]")
{
    REQUIRE( factorial(0) == 1 );
    REQUIRE( factorial(1) == 1 );
    REQUIRE( factorial(2) == 2 );
    REQUIRE( factorial(3) == 6 );
    REQUIRE( factorial(10) == 3628800 );
}

TEST_CASE( "Logs are computed", "[log]")
{
    REQUIRE( factorial(0) == 1 );
    REQUIRE( factorial(1) == 1 );
    REQUIRE( factorial(2) == 2 );
    REQUIRE( factorial(3) == 6 );
    REQUIRE( factorial(10) == 3628800 );
}

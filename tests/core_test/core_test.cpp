#include "core/core.hpp"

#include <gtest/gtest.h>

TEST(FactorialTest, handles_zero_input)
{
    EXPECT_EQ(core::factorial(0), 1);
}

TEST(FactorialTest, handles_non_zero_input)
{
    EXPECT_EQ(core::factorial(1), 1);
    EXPECT_EQ(core::factorial(2), 2);
    EXPECT_EQ(core::factorial(3), 6);
    EXPECT_EQ(core::factorial(8), 40320);
}

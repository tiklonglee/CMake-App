#include "core/core.hpp"

#include <cstdint>
#include <iostream>
#include <string_view>

#include "core_local.hpp"
#include "configure_files/version.hpp"

namespace core
{

auto helloworld() -> void
{
    std::cout << "Hello World " << current_time() << '\n'
              << "Git sha: " << cfg::git_sha << " timestamp: " << cfg::timestamp << '\n';
}

auto factorial(uint32_t number) noexcept -> uint32_t  // NOLINT(misc-no-recursion)
{
    return number <= 1 ? 1 : factorial(number - 1) * number;
}

}  // namespace core

#include "core/core.hpp"

#include <iostream>

#include "core_local.hpp"

namespace core
{

auto helloworld() -> void
{
    std::cout << "Hello World " << current_time() << '\n';
}

}  // namespace core

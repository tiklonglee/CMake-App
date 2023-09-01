#include "core_local.hpp"

#include <ctime>
#include <chrono>

namespace core
{

auto current_time() noexcept -> std::time_t
{
    const auto current_time = std::chrono::system_clock::now();
    const auto current_time_t = std::chrono::system_clock::to_time_t(current_time);
    return current_time_t;
}

}  // namespace core

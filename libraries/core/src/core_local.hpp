#pragma once

#include <ctime>

namespace core
{

[[nodiscard]] auto current_time() noexcept -> std::time_t;

}  // namespace core

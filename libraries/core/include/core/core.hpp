#pragma once

#include "core/core_export.hpp"

#include <cstdint>

namespace core
{

CORE_EXPORT auto helloworld() -> void;

[[nodiscard]] CORE_EXPORT auto factorial(uint32_t number) noexcept -> uint32_t;

}  // namespace core

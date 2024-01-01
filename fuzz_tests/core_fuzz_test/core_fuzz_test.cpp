#include "core/core.hpp"

#include <cstddef>
#include <cstdint>
#include <iterator>

extern "C" auto LLVMFuzzerTestOneInput(const uint8_t* data, size_t size) -> int
{
    for (auto offset = size_t(0); offset < size; ++offset)
    {
        [[maybe_unused]] const auto value = core::factorial(*std::next(data, static_cast<long>(offset)));
    }
    return 0;
}

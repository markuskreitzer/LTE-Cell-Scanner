# AGENTS.md - LTE-Cell-Scanner Development Guidelines

## Build Commands
- **Build project**: `mkdir build && cd build && cmake .. && make`
- **Build with specific hardware**:
  - RTL-SDR (default): `cmake -DUSE_RTLSDR=1 ..`
  - HackRF: `cmake -DUSE_HACKRF=1 ..`
  - BladeRF: `cmake -DUSE_BLADERF=1 ..`
  - Disable OpenCL: `cmake -DUSE_OPENCL=0 ..`
- **Clean build**: `make clean` in build directory
- **Install**: `make install` (installs to system bin directory)

## Test Commands
- **Run all tests**: `make test` (from build directory)
- **Run single test**: Tests are currently commented out in CMakeLists.txt
  - Uncomment test blocks in `test/CMakeLists.txt` to enable
  - Individual test files exist: `test_peak_search.cpp`, `test_sss_detect.cpp`, `test_tfg.cpp`, `test_xcorr_pss.cpp`
- **Full system test**: `CellSearch -s 739000000 -l -d test/` (currently commented out)

## Code Style Guidelines

### Language & Standards
- **C++ Standard**: C++11 (`-std=c++11` flag)
- **Primary libraries**: ITPP (IT++), Boost, FFTW, LAPACK, OpenMP
- **Optional libraries**: OpenCL, RTL-SDR, HackRF, BladeRF

### Imports & Headers
- **Include order**: Standard library → Third-party libraries → Project headers
- **Header guards**: Use `HAVE_<FILENAME>_H` format (e.g., `#ifndef HAVE_LTE_LIB_H`)
- **Conditional compilation**: Use `#ifdef HAVE_<LIBRARY>` for optional dependencies
- **Namespaces**: Use `using namespace std;` and `using namespace itpp;` in implementation files

### Formatting
- **Indentation**: Spaces (not tabs), 2 spaces per level
- **Line length**: No strict limit, but keep reasonable (<120 chars)
- **Braces**: Opening brace on same line, closing brace on new line
- **Function parameters**: Use `const` references where possible (`const uint32 & param`)
- **Class members**: Public methods first, then private members

### Naming Conventions
- **Functions**: `snake_case` (e.g., `lte_pn`, `lte_conv_encode`)
- **Classes**: `PascalCase` (e.g., `PSS_fd`, `RS_DL`)
- **Variables**: `snake_case` (e.g., `n_id_cell`, `fc_requested`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `NORMAL`, `EXTENDED`)
- **Files**: `snake_case` with `.cpp` and `.h` extensions

### Types
- **ITPP types**: Use `itpp::bvec`, `itpp::cvec`, `itpp::mat`, `itpp::cmat` for vectors/matrices
- **Standard types**: `uint8`, `uint16`, `uint32`, `int8`, `int16`, `int32` for fixed-width integers
- **Complex numbers**: `std::complex<double>` or ITPP complex types
- **Boolean**: `bool` type, avoid `int` for boolean values

### Error Handling
- **Return codes**: Use `int` return types with 0 for success, negative for errors
- **Error output**: Use `cerr` for error messages, `cout` for normal output
- **Validation**: Check for invalid values (e.g., `NAN`, negative indices)
- **Exception handling**: Minimal use of exceptions, prefer return codes

### Documentation
- **Comments**: Use `//` for single-line comments, `/* */` for multi-line
- **Function comments**: Describe purpose, parameters, and return values
- **Class comments**: Document class purpose and key methods
- **File headers**: Include copyright and license information

### Best Practices
- **Memory management**: Avoid raw pointers, use ITPP containers and smart pointers
- **Performance**: Use `const` references, avoid unnecessary copies
- **Threading**: Use Boost thread library for multi-threading
- **Debugging**: Valgrind integration available (`#include <valgrind/callgrind.h>`)
- **OpenCL**: Kernel files (`.cl`) should be in same directory as executables or `$PATH`

### Project Structure
- **Headers**: `include/` directory for public headers
- **Sources**: `src/` directory for implementation files
- **Tests**: `test/` directory for test files
- **Documentation**: `doc/` directory for project documentation
- **Build files**: `cmake/` directory for CMake modules
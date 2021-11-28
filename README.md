# uwaterloo-testing-system
A testing system for use in UWaterloo C++ assignments

## Motivation
I spent a lot of time creating test suites and running `./executable < test_input_xyz.in > test_output_xyz.out` and then running `diff` commands with expected outputs. It was a pain to do and often resulted in more mistakes due to the huge amount of manual processing I was doing.

I read the book 'The Pragmatic Programmer' and it laid out an important lesson in programming: automate everything that you can to save time, prevent mistakes and help you debug faster. In the spirit of continuous learning, I learned a little bit of Makefile scripting to create a barebones testing suite that I can use for assignments that generate executables (however, it is written for C++ assignments).

## How do I use it?
1. Copy or clone the Makefile to your repository. It should reside in the top-level of your project directory
2. Change the `OBJECTS` and `EXEC` variables to match the objects generated from your program and your desired executable name respectively
3. Run `make` to compile your executable
4. Run `make generate_test_suite` to create a test suite
5. Create your test input files in `tests/input/` with a `.in` suffix appended
6. Create your test expected output files in `tests/expected_output/` with a `.cmp` suffix appended. Make sure the stem name of the file matches the corresponding input file!
7. Run `make all_tests` to run through all `tests/input` files
8. Outputs of your program will be in `tests/output/` with the same file stem

# C++ specific flags

# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = -std=c++14 -MMD

# Objects generated from .cpp files. Typically, any `.cc/.cpp` file will have an associated `.o` file
OBJECTS = 

# Dependency files: every `.o` file will have it's own `.d` file
DEPENDS = ${OBJECTS:.o=.d}

# Name of the executable file (please specify)
EXEC = 

# Main target for compilation
${EXEC} : ${OBJECTS}
	${CXX} ${CXXFLAGS} ${OBJECTS} -o ${EXEC}

# Run `make clean` for removing all dependency and object files
clean:
	rm -rf ${DEPENDS} ${OBJECTS}

# Everything below is related to testing

# The following targets are not linked to any file in the directory
.PHONY: generate_test_suite test tests/input/%.test all_tests

# Generate the `tests` directory structure.
generate_test_suite:
	mkdir tests
	mkdir tests/input
	mkdir tests/output
	mkdir tests/expected_output

# Defines all test cases to run, assuming that test cases have `.in` suffix and in `tests/input`
ALL_TEST_FILES = $(addsuffix .test, $(basename $(wildcard tests/input/*.in)))

# When calling test, it will run through all tests defined below
test: ${ALL_TEST_FILES}

# Programatically define test cases and dumps output of program into `tests/output/___.out`
tests/input/%.test : tests/input/%.in tests/expected_output/%.cmp ${EXEC}
	@./${EXEC} < $< 2>&1 | tee tests/output/$*.out |\
	 	diff -q $(word 2, $?) - > /dev/null  ||\
		(echo "Test $@ failed" && exit 1)

# Call this command to run through all tests
all_tests : test
	@echo "Success, all tests passed"

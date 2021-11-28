CXX = g++
CXXFLAGS = -std=c++14 -MMD
OBJECTS = encode.o
DEPENDS = ${OBJECTS:.o=.d}
EXEC = encode
EXEC_FILE = ./encode

${EXEC} : ${OBJECTS}
	${CXX} ${CXXFLAGS} ${OBJECTS} -o ${EXEC}

clean:
	rm -rf ${DEPENDS} ${OBJECTS}

# Everything below is related to testing

# Generate the test suites.
generate_test_suite:
	mkdir tests
	mkdir tests/input
	mkdir tests/output
	mkdir tests/expected_output

# Defines all test cases to run, assuming that test cases have `.in` suffix and in `tests/input`
all-tests := $(addsuffix .test, $(basename $(wildcard tests/input/*.in)))

# All of these targets do not have any files associated with them
.PHONY : test all_tests tests/input/%.test

# When calling test, it will run through all tests defined below
test: ${all-tests}

# Programatically define test cases and dumps output of program into `tests/output/___.out`
tests/input/%.test : tests/input/%.in tests/input/%.cmp ${EXEC}
	@${EXEC_FILE} < $< 2>&1 | tee tests/output/$*.out |\
	 	diff -q $(word 2, $?) - > /dev/null  ||\
		(echo "Test $@ failed" && exit 1)

# Call this command to run through all tests
all_tests : test
	@echo "Success, all tests passed"

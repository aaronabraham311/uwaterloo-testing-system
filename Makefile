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

# Generate the test suites. DO NOT USE THIS RIGHT NOW
generate_test_suite:
	mkdir tests
	mkdir tests/input
	mkdir tests/output
	mkdir tests/expected_output

# Defines all test cases to run, assuming that test cases have .in suffix
# Also assumes that test cases are defined in base level directory
all-tests := $(addsuffix .test, $(basename $(wildcard *.in)))

# All of these targets do not have any files associated with them
.PHONY : test all %.test

# When calling test, it will run through all tests defined below
test: ${all-tests}

# Programatically define test cases
# TODO: can we somehow use the `generate_test_suit` directory structure rather than requiring base level definitions?
%.test : %.in %.cmp ${EXEC}
	@${EXEC_FILE} < $< 2>&1 | diff -q $(word 2, $?) - > /dev/null  ||\
                (echo "Test $@ failed" && exit 1)

# Call this command to run through all tests
all_tests : test
	@echo "Success, all tests passed"

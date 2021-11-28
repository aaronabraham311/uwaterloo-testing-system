CXX = g++
CXXFLAGS = -std=c++14 -MMD
OBJECTS =
DEPENDS = ${OBJECTS:.o=.d}
EXEC =

${EXEC} : ${OBJECTS}
        ${CXX} ${CXXFLAGS} ${OBJECTS} -o ${EXEC}

clean:
        rm -rf ${DEPENDS} ${OBJECTS}

# Everything below is related to testing
# Generate the test suites
generate_test_suite:
        mkdir tests
        mkdir tests/input
        mkdir tests/output
        mkdir tests/expected_output

# Defines all test cases to run, assuming that test cases have .in suffix
all-tests := $(addsuffix .test, $(basename $(wildcard *.in)))

test:
        @echo ${all-tests}

# Programatically define test cases
%.test : %.in %.cmp ${EXEC}
        @${EXEC} < $< 2>&1 | diff -q $(word 2, $?) > /dev/null  ||\
                (echo "Test $@ failed" && exit 1)

all : test
        @echo "Success, all tests passed"
        


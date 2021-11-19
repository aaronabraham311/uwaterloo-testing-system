CXX = g++
CXXFLAGS = -std=c++14 -MMD
OBJECTS =
DEPENDS = ${OBJECTS:.o=.d}
EXEC =

${EXEC} : ${OBJECTS}
        ${CXX} ${CXXFLAGS} ${OBJECTS} -o ${EXEC}

clean:
        rm -rf ${DEPENDS} ${OBJECTS}

generate_test_suite:
        mkdir tests
        mkdir tests/input
        mkdir tests/output
        mkdir tests/expected_output

test:
        for x in tests/input/input*.in; do\
                $(subst input,output,$$x);\
        done

#!/bin/bash

# Test helper script for jprops
#
# Kishan Thomas <kishan.thomas@gmail.com>

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Import jprops from parent folder
export PYTHONPATH="../:$PYTHONPATH"

# Use Java and get all the properties ordered by key from test.properties
javac Test.java
java Test > java.props.out
# Use Python jprops and get all the properties ordered by key from test.properties
#python test.py > python.props.out
python test.py > python.props.out

JAVA_COUNT=$( expr $(wc -l java.props.out|awk '{ print $1}') - 2 )
PYTHON_COUNT=$( expr $(wc -l python.props.out|awk '{ print $1}') - 2 )

# Check both Java and Python jprops found the same number of properties from the same test.properties
echo "Java found $JAVA_COUNT properties, Python jprops found $PYTHON_COUNT properties from test.properties"

if [ $JAVA_COUNT != $PYTHON_COUNT ]
then
  diff java.props.out python.props.out
  echo -e "${RED}Test Fail: The properties counted by Java $JAVA_COUNT, does not math the count from Python jprops $PYTHON_COUNT${NC}"
  exit 1
else
  echo -e "${GREEN}Test Pass: The properties count $PYTHON_COUNT match the expected count $JAVA_COUNT ${NC}"
fi

# Both outputs are ordered by key and formatted in matching format (json)
# So a simple diff can find if they both match TODO: Use a json tool for matching
if diff java.props.out python.props.out; then
  echo -e "${GREEN}Test Pass: All $JAVA_COUNT properties match${NC}"
else
  echo -e "${RED}Test Fail: Not all $JAVA_COUNT properties match${NC}"
  exit 1
fi

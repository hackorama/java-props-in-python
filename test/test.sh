#!/bin/bash 

# Test helper script for jprops
#
# Kishan Thomas <kishan.thomas@gmail.com>

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Import jprops from parent folder
export PYTHONPATH="../:$PYTHONPATH"

# The expected properties 
PROPERTY_COUNT=$(wc -l test.properties|awk '{ print $1}')

# Use Java and get all the properties ordered by key from test.properties
javac Test.java
java Test > java.props.out
# Use Python jprops and get all the properties ordered by key from test.properties
python test.py > python.props.out

JAVA_COUNT=$( expr $(wc -l java.props.out|awk '{ print $1}') - 2 )
PYTHON_COUNT=$( expr $(wc -l python.props.out|awk '{ print $1}') - 2 )

# Check both Java and Python jprops found the same number of properties from the same test.properties 
echo "Expected $PROPERTY_COUNT, Java found $JAVA_COUNT, Python jprops found $PYTHON_COUNT"

if [ $JAVA_COUNT != $PROPERTY_COUNT ] || [ $PYTHON_COUNT != $PROPERTY_COUNT ] 
then 
  diff java.props.out python.props.out 
  echo -e "${RED}Test Fail: The properties count $JAVA_COUNT (Java) and/or $PYTHON_COUNT (jprops) do not match the expected count $PROPERTY_COUNT ${NC}"
  exit 1
else
  echo -e "${GREEN}Test Pass: The properties count $PYTHON_COUNT match the expected count $PROPERTY_COUNT ${NC}"
fi 

# Both outputs are ordered by key and formatted in matching format (json) 
# So a simple diff can find if they both match TODO: Use a json tool for matching
if diff java.props.out python.props.out; then 
  echo -e "${GREEN}Test Pass: All $PROPERTY_COUNT properties match${NC}" 
else
  echo -e "${RED}Test Fail: Not all $PROPERTY_COUNT properties match${NC}" 
  exit 1
fi

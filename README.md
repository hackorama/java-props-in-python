java-props-in-python
====================

Read the key, element pairs from a java properties file

Follows the [java properties file format](http://docs.oracle.com/javase/6/docs/api/java/util/Properties.html#load(java.io.Reader)) and tested against the Java 6 version of java.util.Properties

Args:
  propfile: a valid file object (as returned by open(filename))
Returns:
  The property key and elements as a dict
Raises:
  IOError: if file operation fails with I/O related reason
    Corresponds to java IOException in Properties.load()
  UnicodeDecodeError: if the property file has malformed \uxxxx encoding,
    Corresponds to java IllegalArgumentException in Properties.load()
  AttributeError: if invalid object was provided for file object
    Corresponds to java NullPointerException

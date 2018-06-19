# jprops

Read the key, element pairs from a java properties file

Follows the [java properties file format](http://docs.oracle.com/javase/6/docs/api/java/util/Properties.html#load(java.io.Reader)) and tested against the Java 8 version of `java.util.Properties`

## Documentation

`dict getJavaProperties(file)`

- Args:
  - file: a valid file object (as returned by `open(filename)`)
- Returns:
  - The property key and elements as a dict
- Raises:
  - `IOError`: if file operation fails with I/O related reason
    - Corresponds to java `IOException` in `Properties.load()`
  - `UnicodeDecodeError`: if the property file has malformed `\uxxxx` encoding,
    - Corresponds to java `IllegalArgumentException` in `Properties.load()`
  - `AttributeError`: if invalid object was provided for file object
    - Corresponds to java `NullPointerException`

## Example

```
import jprops

props = jprops.getJavaProperties(open("demo.properties"))
print props['greeting']
```

```
$ cat demo.properties
greeting = hello world
```

```
$ python demo.py
hello world
```

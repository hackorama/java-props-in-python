"""java properties file parser"""

import re

def getJavaProperties(propfile):
    """Read the key, element pairs from a java properties file

    Follows the file format 'http://docs.oracle.com/javase/6/docs/api/
    java/util/Properties.html#load(java.io.Reader)' and tested against
    the Java 6 version of java.util.Properties

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
            
    Author: Kishan Thomas <kishan.thomas@gmail.com> www.hackorama.com
    """
    LINE_BREAKS = '\n\r\f' #end-of-line, carriage-return, form-feed
    ESC_DELIM = r'\\' # '\'
    ESCAPED_ESC_DELIM = r'\\\\' # '\\'
    COMMENT_LINE = re.compile('\s*[#!].*') # starts with #|! ignore white space
    MULTI_LINE = re.compile(r'.*[\\]\.*$') # ending with '\' ignore white space and tabs
    # non escaped  =|:|' '|tab|formfeed, include surrounding non escaped white space
    SPLIT_DELIM = re.compile(r'(?<!\\)\s*(?<!\\)[=: \t\f]\s*')
    # match escape characters '\', except escaped '\\' and unicode escape '\u'
    VALID_ESC_DELIM = r'(?<!\\)[\\](?!u)'
    DEFAULT_ELEMENT = ''

    result = dict()
    natural_line = propfile.readline()
    while natural_line:
        # skip blank lines and comment lines, process only valid logical lines
        if natural_line.strip() and COMMENT_LINE.match(natural_line) is None:
            logical_line = natural_line.lstrip().rstrip(LINE_BREAKS)
            # remove multi line delim and append adjacent lines
            while MULTI_LINE.match(logical_line): 
                logical_line = logical_line.rstrip()[:-1] + propfile.readline().lstrip().rstrip(LINE_BREAKS)
            pair = SPLIT_DELIM.split(logical_line, 1)
            if len(pair) == 1: pair.append(DEFAULT_ELEMENT)
            pair = [re.sub(VALID_ESC_DELIM, '', item) for item in pair]
            pair = [re.sub(ESCAPED_ESC_DELIM, ESC_DELIM, item) for item in pair]
            pair = [unicode(item, 'unicode_escape') for item in pair] 
            result[pair[0]] = pair[1] # add key, element to result dict
        natural_line = propfile.readline()
    return result

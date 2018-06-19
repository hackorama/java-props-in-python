import jprops
import json
import collections

props = jprops.getJavaProperties(open("test.properties"))
ordered_props = collections.OrderedDict(sorted(props.items()))
print json.dumps(ordered_props, indent=1)

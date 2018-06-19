import jprops

# Using jprops to get properties from a java style property file
props = jprops.getJavaProperties(open("demo.properties"))
print props['greeting'] 

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.TreeMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Read properties and sort by key so it can be compared with the Python jprops output
 * Format output as valid JSON (escape quotes) to match the json output from Python dict
 */
public class Test {
    public static String jsonEscape(String value) {
        String escaped = value;
        escaped = escaped.replaceAll("\"", "\\\\\"");
        escaped = escaped.replaceAll("\t", "\\\\t");
        escaped = escaped.replaceAll("\f", "\\\\f");
        return escaped;
    }
    public static void main(String[] args) {
        try (InputStream inputStream = new FileInputStream("test.properties")) {
            Properties properties = new Properties();
            properties.load(inputStream);
            TreeMap<String, String> orderedProperties = new TreeMap<>();
            properties.forEach((key, value) -> orderedProperties.put((String) key, (String) value));
            System.out.println("{");
            final AtomicInteger counter = new AtomicInteger(1);
            orderedProperties.forEach((key, value) -> System.out.format(" \"%s\": \"%s\"%s%n",
                    jsonEscape(key), jsonEscape(value),
                    (counter.getAndIncrement() == orderedProperties.size()) ? "" : ", "));
            System.out.println("}");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

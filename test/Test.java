import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.TreeMap;
import java.util.concurrent.atomic.AtomicInteger;

public class Test {
    public static void main(String[] args) {
        try (InputStream inputStream = new FileInputStream("test.properties")) {
            Properties properties = new Properties();
            properties.load(inputStream);
            TreeMap<String, String> orderedProperties = new TreeMap<>();
            properties.forEach((key, value) -> orderedProperties.put((String) key, (String) value));
            System.out.println("{");
            final AtomicInteger counter = new AtomicInteger(1);
            orderedProperties.forEach((key, value) -> System.out.format(" \"%s\": \"%s\"%s%n", key, value,
                    (counter.getAndIncrement() == orderedProperties.size()) ? "" : ", "));
            System.out.println("}");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

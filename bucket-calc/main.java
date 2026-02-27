import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        int start = 1;
        int end = 100000;
        int numBins = 20;

        double logBase = Math.pow((double) end / start, 1.0 / numBins);

        List<Long> binEdgesInt = new ArrayList<>();
        for (int i = 0; i <= numBins; i++) {
            binEdgesInt.add(Math.round(start * Math.pow(logBase, i)));
        }

        System.out.println(binEdgesInt);
    }
}

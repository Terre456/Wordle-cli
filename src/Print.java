
import com.diogonunes.jcolor.Attribute;
import static com.diogonunes.jcolor.Ansi.colorize;
import java.util.Arrays;

public class Print {
    public static void main(String[] args) { // 0: field, 1: word, 2: index
        String[] field = Arrays.copyOfRange(args, 0, 6);
        String word = args[6];
        int index = Integer.parseInt(args[7]);
        String word_to_find = args[8];
        
        field[index] =  "|" + String.join("|",get_colors(word_to_find, word))+ "|";
        System.out.println(String.join("\n",field));

    }
    public static String[] get_colors(String ref, String input){
        String[] out = new String[ref.length()];
        Attribute[] placed = new Attribute[]{Attribute.BRIGHT_GREEN_TEXT()};
        Attribute[] misplaced = new Attribute[]{Attribute.BRIGHT_YELLOW_TEXT()};
        Attribute[] wrong = new Attribute[]{Attribute.BRIGHT_RED_TEXT()};

        int[] occ = get_occ(ref);
        int[] is_green = new int[ref.length()];
        for (int i = 0; i<input.length();i++){
            char a = input.charAt(i);
            char b = ref.charAt(i);
            if (a == b){
                occ[a-'A'] -= 1;
                out[i] = colorize(String.valueOf(a), placed);
                is_green[i] = 2;
            }
        }
        for (int i = 0; i<input.length();i++){
            char a = input.charAt(i);
            if(ref.indexOf(a) != -1 && is_green[i]!=2 && occ[a-'A']>0){
                out[i] = colorize(String.valueOf(a), misplaced);
                is_green[i]=1;
                occ[a-'A'] -=1;
            }}
        for (int i = 0; i<input.length();i++){
            char a = input.charAt(i);
            if(is_green[i]==0){
                out[i] = colorize(String.valueOf(a), wrong);
        }}
        return out;
    }
    public static int[] get_occ(String mot){
        int[] rep = new int[26];
        for (int i= 0;i<mot.length();i++){
            rep[mot.charAt(i)-'A'] += 1;
        }
        return rep;
    }
}

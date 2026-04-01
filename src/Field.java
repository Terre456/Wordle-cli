public class Field {
    public static void main(String[] args) {
        int len = args[0].length();
        String value = "";
        for (int i = 0;i<6;i++){
            
            value += "|" + "-|".repeat(len);
            value += "\n";
        }
        System.out.println(value);
    }
    
}

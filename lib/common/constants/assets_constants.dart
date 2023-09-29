class Assets {
  static const pngPath = "assets/png";
  static const svgPath = "assets/svg";
  static const jaguarPath = "assets/jaguars";

  static List<String> jagPaths = List.generate(10, (index) {
    final jagNumber = index + 1;
    return '$jaguarPath/jag$jagNumber.jpg';
  });

  static String splashImagePath = '$pngPath/logo try.png';
  static String bgImage = '$pngPath/bg.png';

}

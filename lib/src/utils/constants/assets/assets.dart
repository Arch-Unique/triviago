abstract class Assets {
  static const String appFontFamily = 'Ubuntu';

  static const String logo = "assets/images/logo.png";

  static List<String> usersImages =
      List.generate(16, (index) => "assets/images/users-${index + 1}.svg");
}

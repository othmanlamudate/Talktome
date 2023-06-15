class product {
  String title = "";
  String image = "";
  String subtitle = "";
  double prix = 0;
  bool isFree = false;
  String description = "";
  List<String> gcode=[];

  product(String title, String subtitle, String image, double prix, bool isFree,
      String description,List<String> gcode) {
    title = title;
    subtitle = subtitle;
    image = image;
    prix = prix;
    isFree = isFree;
    description = description;
  }

  String getTitle() {
    return title;
  }

  String getimage() {
    return image;
  }

  double getPrix() {
    return prix;
  }

  bool getIsFree() {
    return isFree;
  }

  String getDescription() {
    return description;
  }

  @override
  String toString() {
    return "$title $image $prix  $description";
  }
}

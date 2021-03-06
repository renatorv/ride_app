class PlacePredictions {
  // ignore: non_constant_identifier_names
  String secondary_text;
  // ignore: non_constant_identifier_names
  String main_text;
  // ignore: non_constant_identifier_names
  String place_id;

  PlacePredictions({
    // ignore: non_constant_identifier_names
    this.secondary_text,
    // ignore: non_constant_identifier_names
    this.main_text,
    // ignore: non_constant_identifier_names
    this.place_id,
  });

  PlacePredictions.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    main_text = json["structured_formatting"]["main_text"];
    secondary_text = json["structured_formatting"]["secondary_text"];
  }
}

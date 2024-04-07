class Validators {
  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}

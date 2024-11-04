class Validators {
  static String? validateField(String value) {
    if (value.isEmpty) {
      return 'Trường này không được để trống';
    }
    return null;
  }
}

class SpentStatusFormValidations {
  static String? descriptionValidation(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please inform description';
    }
    return null;
  }
}
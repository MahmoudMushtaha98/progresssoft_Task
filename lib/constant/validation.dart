String? nameValidator(String? name) {
  final fullNameRegExp = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)+$");
  if (name == null || name.isEmpty) {
    return 'Enter your name';
  } else if (fullNameRegExp.hasMatch(name)) {
    return null;
  } else {
    return '';
  }
}

String? phoneValidator(String? phone) {
  final phoneNumberRegExp = RegExp(r"^\+9627\d{8}$");
  if (phone == null || phone.isEmpty) {
    return 'Enter your number';
  } else if (phoneNumberRegExp.hasMatch(phone)) {
    return null;
  } else {
    return '';
  }
}

String? passwordValidator(String? password) {
  final passwordRegExp = RegExp(r"^.{6,}$");

  if (password == null || password.isEmpty) {
    return 'Enter your password';
  } else if (passwordRegExp.hasMatch(password)) {
    return null;
  } else if (password.length < 6) {
    return 'Minimum 6 diets';
  } else {
    return '';
  }
}

String? confirmPasswordValidator(String? confirmPassword,String? password) {
  if (confirmPassword != password) {
    return 'not match';
  } else {
    return null;
  }
}

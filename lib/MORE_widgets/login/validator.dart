

String ValidateEmail(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "This Entry is Required";
  }
  // This is just a regular expression for email addresses
  String p = "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+" ;
  RegExp regExp = new RegExp(p);
  print("in valid = "+value);
  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Value is not Valid';
}


String ValidateName(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "This Entry is Required";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z]" ;
  RegExp regExp = new RegExp(p);
  print("in valid = "+value);
  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Value is not Valid';
}


String ValidateContact(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "This Entry is Required";
  }
  // This is just a regular expression for email addresses
  String p = r'(^(?:[+0]9)?[0-9]{10,12}$)' ;
  RegExp regExp = new RegExp(p);
  print("in valid = "+value);
  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Value is not Valid';
}

String ValidatePassword(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "This Entry is Required";
  }
  // This is just a regular expression for email addresses
  String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$' ;
  RegExp regExp = new RegExp(p);
  print("in valid = "+value);
  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }
  else if (value=="not required for google/fb"){
    return null ;
  }

  // The pattern of the email didn't match the regex above.
  return 'Atleast 1 Upper and 1 Loswer case and 1 Digit and \nlength 5+';
}


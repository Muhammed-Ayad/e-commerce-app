class ValidarorsAuth {
 
  static String? nameValidator(String value) {
    if (value.isEmpty) {
      return ' Name is empty';
    }
    if (value.length < 4) {
      return ' Name is less 4';
    }
  }

 

  
  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is empty';
    }
    if (!value.contains('@')) {
      return 'The email does not contain @';
    }
     if (!value.contains('.')) {
      return 'The email does not contain .';
    }
    
  }

  
  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'password is empty';
    }
    if (value.length < 7) {
      return 'password is less 7';
    }
  }
}

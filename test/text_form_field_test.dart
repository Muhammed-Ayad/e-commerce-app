import 'package:e_commerce_app/services/validators/validators_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextFormField', () {
    test('The name is not empty', () {
      var result = ValidarorsAuth.nameValidator('Mohamed');
      expect(result, null);
    });
    test('The email is not empty', () {
      var result = ValidarorsAuth.emailValidator('test@test.com');
      expect(result, null);
    });

    test('The password is not empty', () {
      var result = ValidarorsAuth.passwordValidator('1234567');
      expect(result, null);
    });
  });
}

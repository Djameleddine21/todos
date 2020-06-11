/* 
* in reality i'm using regxed validator package created by Djamal Belilet(ESI Student )
* but the package have an issue in phone validation, if you see the repo i daclared the issue
* and i created this custom regular expression for phone validation
*/
class Validator {
  final RegExp _phoneValidator = RegExp(r"^\+(?:[0-9] ?){6,14}[0-9]$");

  String phoneValidator(String phone) {
    if (!_phoneValidator.hasMatch(phone)) {
      return "invalide phone number";
    }
    return null;
  }
}


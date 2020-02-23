/// Copyright © 2020 Giorgio Franceschetti. All rights reserved.

final RegExp everythingButDigitsRegExpr = RegExp('[^0-9]*');

final RegExp onlyAlphaCharsRegExp = RegExp(r'^[a-zA-Z]+$');
final RegExp onlyDigitsRegExp = RegExp(r'^[\d]+$');

final RegExp dartIdentifierRegExp = RegExp(r'[_\$a-zA-Z][_\$a-zA-Z\d]*');

final RegExp dartAnnotationRegExp = RegExp(r'@[_\$a-zA-Z][_\$a-zA-Z\d]*');

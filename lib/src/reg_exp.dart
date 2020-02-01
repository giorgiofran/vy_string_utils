/// Copyright © 2016 Vidya sas. All rights reserved.
/// Created by Giorgio on 26/11/2019.

final RegExp everythingButDigitsRegExpr = RegExp('[^0-9]*');

final RegExp onlyAlphaCharsRegExp = RegExp(r'^[a-zA-Z]+$');
final RegExp onlyDigitsRegExp = RegExp(r'^[\d]+$');

final RegExp dartIdentifierRegExp = RegExp(r'[_\$a-zA-Z][_\$a-zA-Z\d]*');

final RegExp dartAnnotationRegExp = RegExp(r'@[_\$a-zA-Z][_\$a-zA-Z\d]*');

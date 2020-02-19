/// Copyright © 2016 Vidya sas. All rights reserved.
/// Created by Giorgio on 20/11/2019.

extension StringExtension on String {
  String cut(int newLength) {
    if (length <= newLength) {
      return this;
    }
    return substring(0, newLength);
  }

  String cutAndAlign(int newLength, {String paddingChar, bool leftAlign}) {
    paddingChar ??= ' ';
    leftAlign ??= true;
    final ret = cut(newLength);
    if (leftAlign) {
      return ret.padRight(newLength, paddingChar);
    } else {
      return ret.padLeft(newLength, paddingChar);
    }
  }
}

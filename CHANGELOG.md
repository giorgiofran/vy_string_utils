# Changelog

## 0.4.6

- Updated SDK

## 0.4.5

- using power _extensions

## 0.4.4

- Moving to Lints

## 0.4.3

New string methods:

- startsAndEndsWith() - Verifies if the string starts and ends with the same given delimiter
- trimDelimiters() - If the string starts and ends with the same given delimiter, those are removed
- trimStringDelimiters() If the string starts and ends with the same string delimiter, those are removed

## 0.4.2

- fix in `splitInLines()` when `firstLineDecrease` parm  is greater than `lineLength` one.

## 0.4.1

- added method `capitalizeAndLowercaseAnyWord()`

## 0.4.0

- list utils
- basic Map utils
- basic Set utils

## 0.4.0-nullsafety

- Breaking change: assuming that now null values are easier to detect, most of the methods requires a non null value. Only the `filled` and `unfilled` methods still accepts null values.

## 0.3.3

- Renamed capitalize() into capitalizeAndLowercase(). A deprecated capitalize() method has been created. In the future will be removed.
- Added simple DateTime formatter for logs.
- Added capitalizeRestUnchanged() and uncapitalizeRestUnchanged() methods

## 0.3.2

- Completed all the extension methods

## 0.3.0

- Moved to Dart 2.7.1
- Created extension methods

## 0.2.1

- Fixed a minor error in splitInLines() method

## 0.2.0

- Removed source analysis classes. They will be part of a new package.
- Changed the splitInLines() Method. Now it is possible to set a different length for the first line.

## 0.1.1

- Fixed a minor error during source analysis

## 0.1.0

- Initial version

/// Simple formatting method for logs (up to seconds)
String dateTimeUpToSeconds(DateTime time) =>
    time.toIso8601String().replaceFirst('T', ' ').split('.').first;

import 'dart:ui';

extension StringExtensions on String? {
  Color parseToColor() => Color(int.parse('0xff$this'));

  String? extractValueFromQuery(String key) {
    // Remove everything before the question mark
    int queryStartIndex = this!.indexOf('?');
    if (queryStartIndex == -1) return null;

    String query = this!.substring(queryStartIndex + 1);

    // Split the query into key-value pairs
    List<String> pairs = query.split('&');

    // Find the key-value pair that matches the given key
    for (String pair in pairs) {
      List<String> keyValue = pair.split('=');
      if (keyValue.length == 2) {
        String currentKey = keyValue[0];
        String value = keyValue[1];

        if (currentKey == key) {
          // Decode the URL-encoded value
          return Uri.decodeComponent(value);
        }
      }
    }

    return null;
  }
}
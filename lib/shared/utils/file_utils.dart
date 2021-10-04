import 'dart:math';

class FileUtils {
  static String formatBytes(byte, decimals) {
    if (byte == 0) return "0.0 KB";
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        size = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(byte) / log(k)).floor();

    return (((byte / pow(k, i)).toStringAsFixed(dm)) + ' ' + size[i]);
  }
}

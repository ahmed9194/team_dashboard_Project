/// 5200 -> "5,200". Exact numbers are used (not "5.2K") so that a single
/// new follower is visible on the dashboard immediately.
String formatCount(int n) {
  final s = n.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
    buffer.write(s[i]);
  }
  return buffer.toString();
}

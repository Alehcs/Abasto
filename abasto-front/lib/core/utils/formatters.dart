abstract final class AppFormatters {
  static const _months = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sept',
    'oct',
    'nov',
    'dic',
  ];

  static String money(double value) {
    final number = value.round().toString();
    final buffer = StringBuffer();
    final reversed = number.split('').reversed.toList();

    for (var i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(reversed[i]);
    }

    return '\$${buffer.toString().split('').reversed.join()}';
  }

  static String shortDateTime(DateTime value) {
    final month = _months[value.month - 1];
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.day} $month, $hour:$minute';
  }

  static String historyDateTime(DateTime value) {
    final month = _months[value.month - 1];
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.day} $month ${value.year} · $hour:$minute';
  }
}

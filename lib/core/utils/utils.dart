abstract class Utils {
  static String formatPrice(double? value) {
    if (value == null) return '--';

    return '\$${Utils.formatNumber(value)}';
  }

  static String formatNumber(double value) {
    if (value >= 1) {
      return value.toStringAsFixed(2);
    }

    return value.toStringAsFixed(6);
  }

  static String formatCurrency(double? value) {
    if (value == null) return '--';

    if (value >= 1e12) {
      return '\$${(value / 1e12).toStringAsFixed(2)}T';
    }

    if (value >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(2)}B';
    }

    if (value >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(2)}M';
    }

    return '\$${value.toStringAsFixed(2)}';
  }
}

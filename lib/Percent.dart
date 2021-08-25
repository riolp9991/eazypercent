// P/T = %/100

class Percent {
  static double getTotal(double percent, double part) {
    return (part * 100) / percent;
  }

  static double getPercent(double total, double part) {
    return (part * 100) / total;
  }

  static double getPart(double total, double percent) {
    return (total * percent) / 100;
  }
}

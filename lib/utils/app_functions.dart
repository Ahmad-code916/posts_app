import 'dart:math' as math;

class AppFunctions {
  static String generateRandomId() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final math.Random random = math.Random();
    return List.generate(
      15,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}

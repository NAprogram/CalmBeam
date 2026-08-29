import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamp_app/services/color_service.dart';

void main() {
  group('ColorService Tests', () {
    test('Temperature colors work correctly', () {
      // Perfect temperature (green)
      expect(ColorService.getTemperatureColor(22.0), const Color(0xFF43A047));

      // Too cold (red)
      expect(ColorService.getTemperatureColor(16.0), const Color(0xFFE53935));

      // Too hot (red)
      expect(ColorService.getTemperatureColor(28.0), const Color(0xFFE53935));

      // Normal range (yellow)
      expect(ColorService.getTemperatureColor(19.0), const Color(0xFFFDD835));
      expect(ColorService.getTemperatureColor(25.0), const Color(0xFFFDD835));
    });

    test('Humidity colors work correctly', () {
      // Perfect humidity (green)
      expect(ColorService.getHumidityColor(50.0), const Color(0xFF43A047));

      // Too dry (red)
      expect(ColorService.getHumidityColor(30.0), const Color(0xFFE53935));

      // Too humid (red)
      expect(ColorService.getHumidityColor(75.0), const Color(0xFFE53935));

      // Normal range (yellow)
      expect(ColorService.getHumidityColor(38.0), const Color(0xFFFDD835));
      expect(ColorService.getHumidityColor(65.0), const Color(0xFFFDD835));
    });

    test('Temperature status messages work correctly', () {
      expect(ColorService.getTemperatureStatus(22.0), 'Perfect');
      expect(ColorService.getTemperatureStatus(16.0), 'Too Cold');
      expect(ColorService.getTemperatureStatus(28.0), 'Too Hot');
      expect(ColorService.getTemperatureStatus(19.0), 'Cool');
      expect(ColorService.getTemperatureStatus(25.0), 'Warm');
    });

    test('Humidity status messages work correctly', () {
      expect(ColorService.getHumidityStatus(50.0), 'Perfect');
      expect(ColorService.getHumidityStatus(30.0), 'Too Dry');
      expect(ColorService.getHumidityStatus(75.0), 'Too Humid');
      expect(ColorService.getHumidityStatus(38.0), 'Dry');
      expect(ColorService.getHumidityStatus(65.0), 'Humid');
    });
  });
}

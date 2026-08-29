import 'dart:ui';
import 'package:flutter/material.dart';

class ColorService {
  static Color getTemperatureColor(double temperature) {
    if (temperature < 18) return const Color(0xFFE53935);
    if (temperature < 20) return const Color(0xFFFDD835);
    if (temperature <= 24) return const Color(0xFF43A047);
    if (temperature <= 26) return const Color(0xFFFDD835);
    return const Color(0xFFE53935);
  }

  static String getTemperatureStatus(double temperature) {
    if (temperature < 18) return 'Too Cold';
    if (temperature < 20) return 'Cool';
    if (temperature <= 24) return 'Perfect';
    if (temperature <= 26) return 'Warm';
    return 'Too Hot';
  }

  // --- NEW HUMIDITY RULES ---
  static Color getHumidityColor(double humidity) {
    if (humidity < 35) return const Color(0xFFE53935); // Red
    if (humidity < 45) return const Color(0xFFFDD835); // Yellow
    if (humidity <= 65) return const Color(0xFF43A047); // Green
    if (humidity <= 75) return const Color(0xFFFDD835); // Yellow
    return const Color(0xFFE53935); // Red
  }

  static String getHumidityStatus(double humidity) {
    if (humidity < 35) return 'Too Dry';
    if (humidity < 45) return 'Dry';
    if (humidity <= 65) return 'Perfect';
    if (humidity <= 75) return 'Humid';
    return 'Too Humid';
  }
}

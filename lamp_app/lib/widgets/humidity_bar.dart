import 'package:flutter/material.dart';

class HumidityBar extends StatelessWidget {
  final double humidity;

  const HumidityBar({Key? key, required this.humidity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Keep the marker from flying off the screen if the sensor bugs out
    final double clampedHumidity = humidity.clamp(0.0, 100.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: Color(0xFF667EEA),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Humidity Level',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${humidity.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF667EEA),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              // Calculate where the marker should sit on the line
              final double markerPosition = (clampedHumidity / 100.0) * width;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // The Gradient Background
                  Container(
                    height: 20,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE53935), // Red
                          Color(0xFFFDD835), // Yellow
                          Color(0xFF43A047), // Green
                          Color(0xFF43A047), // Green
                          Color(0xFFFDD835), // Yellow
                          Color(0xFFE53935), // Red
                        ],
                        stops: [0.0, 0.35, 0.45, 0.65, 0.75, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  // The White Slider Marker
                  Positioned(
                    left: markerPosition - 10, // Centers the 20px wide marker
                    top: -8,
                    child: Container(
                      width: 20,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFF667EEA), width: 3),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF667EEA),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // Helper text below the bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScaleLabel('0%', Colors.red[400]!),
              _buildScaleLabel('35%', Colors.yellow[600]!),
              _buildScaleLabel('65%', Colors.green[600]!),
              _buildScaleLabel('100%', Colors.red[400]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScaleLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

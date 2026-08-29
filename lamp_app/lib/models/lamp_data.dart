class LampData {
  final String id;
  final String lampName;
  final double temperature;
  final double humidity;
  final DateTime timestamp;
  final String status;

  LampData({
    required this.id,
    required this.lampName,
    required this.temperature,
    required this.humidity,
    required this.timestamp,
    required this.status,
  });

  factory LampData.fromMap(Map<String, dynamic> map) {
    return LampData(
      id: map['id'] ?? '',
      lampName: map['lampName'] ?? 'Unknown Lamp',
      temperature: (map['temperature'] ?? 0.0).toDouble(),
      humidity: (map['humidity'] ?? 0.0).toDouble(),
      timestamp: () {
        final raw = map['timestamp'];
        if (raw is DateTime) return raw;
        if (raw is String) return DateTime.parse(raw);
        try {
          return (raw as dynamic).toDate();
        } catch (_) {
          return DateTime.now();
        }
      }(),
      status: map['status'] ?? 'offline',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lampName': lampName,
      'temperature': temperature,
      'humidity': humidity,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }
}

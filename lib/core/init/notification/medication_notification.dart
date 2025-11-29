
class MedicationNotification {
  final int notificationID;
  final String notificationTitle;
  final String notificationBody;
  final String? payload;
  final DateTime notificationTime;

  MedicationNotification({
    required this.notificationID,
    required this.notificationTitle,
    required this.notificationBody,
    required this.notificationTime,
    this.payload,
  });
}

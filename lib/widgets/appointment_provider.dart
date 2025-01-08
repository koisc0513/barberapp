import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  List<Map<String, String>> _appointments = [];
  List<String> _canceledAppointments = [];  // Danh sách lưu trữ thông báo hủy cuộc hẹn

  List<Map<String, String>> get appointments => _appointments;
  List<String> get canceledAppointments => _canceledAppointments;  // Getter cho danh sách thông báo hủy

  // Thêm cuộc hẹn mới
  void addAppointment(String barberName, String date, String time, String service) {
    _appointments.add({
      "barberName": barberName,
      "date": date,
      "time": time,
      "service": service,
    });
    notifyListeners();
  }

  // Hủy cuộc hẹn
  void cancelAppointment(int index) {
    // Lưu thông báo hủy cuộc hẹn
    String canceledAppointmentMessage = "Appointment with ${_appointments[index]['barberName']} on ${_appointments[index]['date']} at ${_appointments[index]['time']} has been canceled.";
    _canceledAppointments.add(canceledAppointmentMessage);

    // Xóa cuộc hẹn tại vị trí index
    _appointments.removeAt(index);
    notifyListeners();
  }
}

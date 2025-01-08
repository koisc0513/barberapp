import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/appointment_provider.dart';  // Import AppointmentProvider

class AppointmentCard extends StatelessWidget {
  final String barberName;
  final String service;  // Dịch vụ
  final String time;     // Thời gian
  final String date;     // Ngày tháng
  final int index;       // Chỉ số của cuộc hẹn trong danh sách

  AppointmentCard({
    required this.barberName,
    required this.service,  // Dịch vụ sẽ được truyền vào
    required this.time,     // Thời gian sẽ được truyền vào
    required this.date,     // Ngày tháng sẽ được truyền vào
    required this.index,    // Chỉ số cuộc hẹn
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(Icons.cut, color: Colors.white),
        ),
        title: Text(barberName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service: $service"),  // Hiển thị dịch vụ
            Text("Time: $time"),        // Hiển thị thời gian
            Text("Date: $date"),        // Hiển thị ngày tháng
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),  // Nút hủy cuộc hẹn
          onPressed: () {
            // Hủy cuộc hẹn
            _cancelAppointment(context);
          },
        ),
      ),
    );
  }

  // Phương thức hủy cuộc hẹn
  void _cancelAppointment(BuildContext context) {
    // Gọi phương thức cancelAppointment từ AppointmentProvider
    Provider.of<AppointmentProvider>(context, listen: false).cancelAppointment(index);

    // Thông báo hủy thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Appointment cancelled successfully!")),
    );
  }
}

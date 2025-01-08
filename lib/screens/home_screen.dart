import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/appointment_provider.dart';  // Import AppointmentProvider
import 'package:untitled/widgets/appointment_card.dart';  // Import AppointmentCard

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barber App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Hiển thị thông báo hoặc các cuộc hẹn
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return NotificationPanel();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Your Booked Appointments",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  provider.appointments.isEmpty
                      ? Center(
                    child: Text(
                      "No appointments booked yet.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                      : Column(
                    children: provider.appointments.asMap().map((index, appointment) {
                      return MapEntry(
                        index,
                        AppointmentCard(
                          barberName: appointment["barberName"]!,
                          time: appointment["time"]!,
                          date: appointment["date"]!,
                          service: appointment["service"]!,
                          index: index,  // Truyền index vào đây để hủy cuộc hẹn
                        ),
                      );
                    }).values.toList(),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to BookScreen
                        Navigator.pushNamed(context, '/book_screen');
                      },
                      child: Text("Book New Appointment"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notifications",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Consumer<AppointmentProvider>(
            builder: (context, provider, child) {
              if (provider.canceledAppointments.isEmpty) {
                return Center(
                  child: Text(
                    "No recent canceled appointments.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: provider.canceledAppointments.map((message) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

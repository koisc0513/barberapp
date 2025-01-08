import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/appointment_provider.dart';  // Import AppointmentProvider
import 'package:untitled/widgets/appointment_card.dart';  // Import AppointmentCard

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule")),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          );
        },
      ),
    );
  }
}
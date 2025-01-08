import 'package:flutter/material.dart';

class BookedAppointmentsList extends StatelessWidget {
  final List<Map<String, String>> appointments;

  BookedAppointmentsList({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booked Appointments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          appointments.isEmpty
              ? Center(
            child: Text(
              "No appointments booked yet.",
              style: TextStyle(color: Colors.grey),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.teal),
                  title: Text(appointment["barberName"]!),
                  subtitle: Text(
                    "${appointment["date"]!} at ${appointment["time"]!}",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

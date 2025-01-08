import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/appointment_provider.dart';  // Import AppointmentProvider

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _barberNames = ["Trung", "Nam", "Đạt"];
  final _services = ["Cắt", "Uốn", "Tạo kiểu"];
  String? _selectedBarber;
  String? _selectedService;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedBarber,
              onChanged: (value) {
                setState(() {
                  _selectedBarber = value;
                });
              },
              items: _barberNames.map((barber) {
                return DropdownMenuItem(
                  value: barber,
                  child: Text(barber),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Select Barber",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
              items: _services.map((service) {
                return DropdownMenuItem(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Select Service",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectDate,
              child: Text(
                _selectedDate == null
                    ? "Select Date"
                    : "Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectTime,
              child: Text(
                _selectedTime == null
                    ? "Select Time"
                    : "Time: ${_selectedTime!.format(context)}",
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _bookAppointment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _bookAppointment() {
    if (_selectedBarber == null ||
        _selectedService == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select all fields!")),
      );
      return;
    }

    // Lưu cuộc hẹn vào AppointmentProvider
    Provider.of<AppointmentProvider>(context, listen: false).addAppointment(
      _selectedBarber!,
      _selectedDate!.toLocal().toString().split(' ')[0],
      _selectedTime!.format(context),
      _selectedService!,  // Lưu dịch vụ đã chọn
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Appointment booked successfully!")),
    );

    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';

class BarberCard extends StatelessWidget {
  final int index;

  BarberCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.teal,
              child: Text(
                "B${index + 1}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Barber ${index + 1}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "4.5 ⭐",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/book_screen.dart'; // Import BookScreen
import 'widgets/appointment_provider.dart'; // Import AppointmentProvider
import 'widgets/auth_provider.dart';


void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppointmentProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()), // Provide AuthProvider to the app

    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: authProvider.isLoggedIn ? '/home' : '/login', // Conditional initial route
      routes: {
        '/': (context) => BarberScheduleHome(),       // Home route
        '/login': (context) => LoginScreen(),         // Login route
        '/register': (context) => RegisterScreen(),   // Register route
        '/home': (context) => BarberScheduleHome(),   // Home route
        '/book_screen': (context) => BookScreen(),    // The route for the booking screen
      },
    );
  }
}

class BarberScheduleHome extends StatefulWidget {
  @override
  _BarberScheduleHomeState createState() => _BarberScheduleHomeState();
}

class _BarberScheduleHomeState extends State<BarberScheduleHome> {
  int _currentIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    HomeScreen(),       // Home screen with appointments
    ScheduleScreen(),   // Schedule screen to show the booking details
    ProfileScreen(),    // Profile screen for user info
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Track current index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index on tap
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

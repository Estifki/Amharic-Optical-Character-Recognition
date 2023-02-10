import 'package:amharic_ocr/const.dart';
import 'package:amharic_ocr/screen/home.dart';
import 'package:amharic_ocr/screen/recent.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [const HomeScreen(), const RecentScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0.0,
        selectedItemColor: AppColor.secondayColorCustom,
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.adf_scanner_outlined, size: 22), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt, size: 22), label: "Recent")
        ],
      ),
    );
  }
}

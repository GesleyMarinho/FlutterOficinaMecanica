import 'package:flutter/material.dart';
import 'home_screens.dart';
import 'list_clientes_screen.dart';

class NavigationsScreen extends StatefulWidget {
  const NavigationsScreen({super.key});

  @override
  State<NavigationsScreen> createState() => _NavigationsScreenPage();
}

class _NavigationsScreenPage extends State<NavigationsScreen> {
  int _abaSelecionada = 0;
  final List<Widget> _telas = [HomeScreens(), ListClientesScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_abaSelecionada],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaSelecionada,
        onTap: (index) {
          setState(() {
            _abaSelecionada = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clientes'),
        ],
      ),
    );
  }
}

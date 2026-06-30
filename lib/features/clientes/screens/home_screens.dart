import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Oficina'), centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.build, size: 80, color: Colors.deepOrange),
          SizedBox(height: 24.0),
          Text(
            'Seja Bem Vindo',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
            ,), SizedBox(height: 8.0),
          Text('Gerencie os clientes e serviços pela aba abaixo =]',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

        ],
      ),
      ),
    );
  }
}
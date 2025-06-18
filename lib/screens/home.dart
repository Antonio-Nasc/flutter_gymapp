import 'package:flutter/material.dart';
import 'package:flutter_gymapp/services/authentication_service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tela Inicial")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
              onTap: () {
                AuthenticationService().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

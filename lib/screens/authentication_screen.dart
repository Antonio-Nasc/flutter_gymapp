import 'package:flutter/material.dart';
import 'package:flutter_gymapp/_commom/my_colors.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool queroEntrar = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MyColors.azulTopoGradient, MyColors.azulBaixoGradient],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/logo.png", height: 128),
                  const Text(
                    "GymApp",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    decoration: InputDecoration(label: Text("E-mail")),
                  ),
                  TextFormField(
                    decoration: InputDecoration(label: Text("Senha")),
                    obscureText: true,
                  ),
                  Visibility(
                    visible: !queroEntrar,
                    child: Column(children: const  [
                      
                    ],
                  ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text((queroEntrar) ? "Acessar" : "Cadastrar"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        queroEntrar = !queroEntrar;
                      });
                    },
                    child: Text(
                      (queroEntrar)
                          ? "Ainda não tem uma conta? Cadastre-se!"
                          : "Já tem uma conta? Acesse",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

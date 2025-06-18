import 'package:flutter/material.dart';
import 'package:flutter_gymapp/_commom/my_colors.dart';
import 'package:flutter_gymapp/_commom/my_snackbar.dart';
import 'package:flutter_gymapp/components/authentication_input_decoration.dart';
import 'package:flutter_gymapp/services/authentication_service.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  AuthenticationService _authService = AuthenticationService();
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
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
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
                        controller: _emailController,
                        decoration: getAuthenticationInputDecoration("E-mail"),
                        validator: (String? value) {
                          if (value == null) {
                            return "O e-mail não pode ser vazio";
                          }
                          if (value.length < 5) {
                            return "O e-mail é muito curto";
                          }
                          if (!value.contains("@")) {
                            return "O e-mail não é válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _senhaController,
                        decoration: getAuthenticationInputDecoration("Senha"),
                        validator: (String? value) {
                          if (value == null) {
                            return "A senha não pode ser vazia";
                          }
                          if (value.length < 5) {
                            return "A senha é muito curta";
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: getAuthenticationInputDecoration(
                                "Confirme Sua Senha",
                              ),
                              validator: (String? value) {
                                if (value == null) {
                                  return "A confirmação de senha não pode ser vazia";
                                }
                                if (value.length < 5) {
                                  return "A confirmação de senha é muito curta";
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _nomeController,
                              decoration: getAuthenticationInputDecoration(
                                "Nome",
                              ),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O nome não pode ser vazio";
                                }
                                if (value.length < 5) {
                                  return "O nome é muito curto";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          botaoPrincipalClicado();
                        },
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
            ),
          ),
        ],
      ),
    );
  }

  botaoPrincipalClicado() {
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    String email = _emailController.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        _authService.SignUser(email: email, password: senha).then((
          String? erro,
        ) {
          if (erro != null) {
            showSnackBar(context: context, text: erro);
          }
        });
      } else {
        _authService.registerUser(nome: nome, senha: senha, email: email).then((
          String? erro,
        ) {
          if (erro != null) {
            showSnackBar(context: context, text: erro);
          }
        });
      }
    } else {
      print("Inválido");
    }
  }
}

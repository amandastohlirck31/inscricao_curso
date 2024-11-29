import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importe o pacote url_launcher
import 'signup_screen.dart'; // Certifique-se de ter o caminho correto

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;

  bool _isValidPassword(String password) {
    final RegExp regex = RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>]).{6,8}$');
    return regex.hasMatch(password);
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    if (username.isEmpty) {
      setState(() {
        _usernameError = "O usuário não pode ser nulo";
      });
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = "A senha não pode ser nula";
      });
    } else if (!_isValidPassword(password)) {
      setState(() {
        _passwordError = "A senha deve ter entre 6 a 8 caracteres e um caractere especial";
      });
    }

    if (_usernameError == null && _passwordError == null) {
      // A lógica do login vai aqui
    }
  }

  // Função para abrir os links
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.person, color: Colors.grey[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorText: _usernameError,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.lock, color: Colors.grey[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorText: _passwordError,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0A047A),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Novo texto "Não possui conta? Crie agora!" com parte do texto normal e parte como link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não possui conta? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Redireciona para a tela de SignUpScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Crie agora!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Espaço para alinhar o container na parte inferior
          Spacer(),
          // Container para redes sociais, sem o fundo azul
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ACOMPANHE NOSSAS REDES SOCIAIS: ",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.black, size: 20),
                  onPressed: () => _launchURL('https://englishinaction.github.io/englishinactionifrs/'), // Link do Facebook
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.black, size: 20),
                  onPressed: () => _launchURL('https://www.instagram.com/english_action_?igsh=OGs3eDV1cGp6N2wz'), // Link do Instagram
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

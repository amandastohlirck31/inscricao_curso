import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importe o pacote url_launcher

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _usernameError;
  String? _passwordError;

  bool _isValidPassword(String password) {
    final RegExp regex = RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>]).{6,8}$');
    return regex.hasMatch(password);
  }

  void _signUp() {
    String name = _nameController.text;
    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      _nameError = null;
      _emailError = null;
      _usernameError = null;
      _passwordError = null;
    });

    if (name.isEmpty) {
      setState(() {
        _nameError = "O nome não pode ser nulo";
      });
    }

    if (email.isEmpty) {
      setState(() {
        _emailError = "O email não pode ser nulo";
      });
    }

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

    if (_nameError == null && _emailError == null && _usernameError == null && _passwordError == null) {
      // Realizar o cadastro
    }
  }

  // Função para abrir links
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true, // Isso vai permitir que o usuário volte
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Texto "Cadastro"
            Text(
              "Cadastro",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),

            // Campo Nome
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.person, color: Colors.grey[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                errorText: _nameError,
              ),
            ),
            SizedBox(height: 20),

            // Campo Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.email, color: Colors.grey[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                errorText: _emailError,
              ),
            ),
            SizedBox(height: 20),

            // Campo Usuário
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

            // Campo Senha
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

            // Botão de Cadastro
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Cadastrar'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF0A047A),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            Spacer(), // Isso vai empurrar o Container das redes sociais para a parte inferior

            // Container para as redes sociais
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ACOMPANHE NOSSAS REDES SOCIAIS: ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://englishinaction.github.io/englishinactionifrs/');  // Link do Facebook
                    },
                    child: Icon(Icons.attach_file, color: Colors.black, size: 20),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://www.instagram.com/english_action_?igsh=OGs3eDV1cGp6N2wz');  // Link do Instagram
                    },
                    child: Icon(Icons.camera_alt, color: Colors.black, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

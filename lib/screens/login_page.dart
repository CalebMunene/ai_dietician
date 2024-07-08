import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_page.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() => error = 'Could not sign in with those credentials');
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                  }
                }
              },
            ),
            TextButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            ),
            TextButton(
              child: Text('Forgot Password?'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
              },
            ),
            Text(error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
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
            ElevatedButton(
              child: Text('Send Reset Link'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _auth.sendPasswordResetEmail(email);
                  setState(() => message = 'Password reset link sent. Check your email.');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                }
              },
            ),
            Text(message, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

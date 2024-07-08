import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String newPassword = '';
  String confirmNewPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Enter your email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => newPassword = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
              validator: (val) => val != newPassword ? 'Passwords do not match' : null,
              onChanged: (val) {
                setState(() => confirmNewPassword = val);
              },
            ),
            ElevatedButton(
              child: Text('Reset Password'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _auth.resetPassword(email, newPassword);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
            ),
            Text(error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

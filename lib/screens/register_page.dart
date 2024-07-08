import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (val) => val != password ? 'Passwords do not match' : null,
              onChanged: (val) {
                setState(() => confirmPassword = val);
              },
            ),
            ElevatedButton(
              child: Text('Register'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() => error = 'Please supply a valid email');
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                  }
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/url.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await http.get(Uri.parse('${uri}?email=${emailC.text}'));

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data.isNotEmpty && data[0]['password'] == passwordC.text) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login berhasil")));
						
						Get.offNamed('/userList');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Email atau password salah")));
          }
        } else {
          print('Terjadi kesalahan');
        }
      } catch (e) {
        throw Exception(e);
      }
    } else {
      print("Terjadi kesalahan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				leading: FlutterLogo(size: 28),
        title: const Text("Silahkan melakukan login",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordC,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
          
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

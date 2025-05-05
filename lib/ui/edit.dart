import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/url.dart';
import '../model/models.dart';
import 'main.dart';

import 'package:http/http.dart' as http;

class editUser extends StatefulWidget {
  const editUser({super.key, required this.userId});

  final userId;

  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  late Future<UserList> userFuture;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  void initState() {
    super.initState();
    userFuture = getData(widget.userId);
  }

  Future<UserList> getData(String id) async {
    var response = await http.get(Uri.parse('$uri/$id'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return UserList.fromJson(data);
    } else {
      throw Exception();
    }
  }

  Future<void> updateData(String id) async {
    var response = await http.put(Uri.parse('$uri/$id'),
        body: ({'email': emailC.text, 'name': nameC.text}));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User berhasil diupdate")));
      Get.offAll(() => userList());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal update user")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit User", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('User Tidak ditemukan'),
              );
            }

            final user = snapshot.data!;
            nameC = TextEditingController(text: user.name);
            emailC = TextEditingController(text: user.email);

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: nameC,
                    decoration: InputDecoration(
                        labelText: "Nama", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailC,
                    decoration: InputDecoration(
                        labelText: "Email", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        updateData(widget.userId);
                      },
                      child: Text("Simpan"))
                ],
              ),
            );
          },
        ));
  }
}

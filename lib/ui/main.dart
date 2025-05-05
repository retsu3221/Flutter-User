import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/url.dart';
import 'edit.dart';

class userList extends StatefulWidget {
  const userList({super.key});

  @override
  State<userList> createState() => _userListState();
}

class _userListState extends State<userList> {
  Future<List<UserList>> getData() async {
		await Future.delayed(Duration(seconds: 1));
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body) as List;

      return data.map((e) => UserList.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteData(String id) async {
    var response = await http.delete(Uri.parse('$uri/$id'));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User berhasil dihapus")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal mengahapus data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				automaticallyImplyLeading: false,
        title: const Text("User List", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('addData');
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
        ],
      ),
      body: FutureBuilder<List<UserList>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          var data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    title: Text(data[index].name),
                    subtitle: Text(data[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(() => editUser(userId: data[index].id));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blueGrey,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteData(data[index].id);
                            setState(() {});
                          },
                        ),
                      ],
                    )),
              );
            },
          );
        },
      ),
    );
  }
}

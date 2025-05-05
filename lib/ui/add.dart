import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/model/url.dart';
import '../model/models.dart';
import 'main.dart';
import 'package:get/get.dart';

class addData extends StatelessWidget {
  const addData({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameC = TextEditingController();

    TextEditingController emailC = TextEditingController();

		Future<void> addData() async {
			var response = await http.post(Uri.parse(uri),
			body: ({
				'email': emailC.text,
				'name' : nameC.text
			}));

			if(response.statusCode == 201) {
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text("Data berhasil ditambahkan"))
				);
				Get.offAll(() => userList());
			}else {
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text("Gagal tambah data"))
				);
				
			}
		}
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah User", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
				padding: const EdgeInsets.all(10),
				child: Center(
					child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text("Tambah data user", style: TextStyle(color: Colors.blue, fontSize: 20),),
							SizedBox(height: 20),
							TextField(
								controller: nameC,
								decoration: InputDecoration(labelText: "Masukan Nama", border: OutlineInputBorder()),
							),
										SizedBox(height: 20),
							TextField(
								controller: emailC,
								decoration: InputDecoration(labelText: "Masukan Email", border: OutlineInputBorder()),
								keyboardType: TextInputType.emailAddress,
							),
							SizedBox(height: 20),
							ElevatedButton(onPressed: () {
										 addData();
										}, child: Text("Tambah data"))
						],
					),
				),
			),
    );
  }
}

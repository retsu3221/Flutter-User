import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vigenesia/ui/add.dart';
import 'ui/main.dart';
import 'ui/edit.dart';
import 'login/screen.dart';
import 'ui/edit.dart';
import 'package:get/get.dart';
import 'ui/add.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
			getPages: [
				GetPage(name: '/userList', page: () => userList()),
				GetPage(name: '/addData', page: () => addData())
			],
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Test Flutter",
//       home: LoginScreen(),
// 			initialRoute: '/',
// 			getPages: [
// 				GetPage(name: "/userList", page: () => userList()),
// 				GetPage(name: "/", page: () => LoginScreen()),
// 				GetPage(name: "/addData", page: () => addData()),
				

// 			],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_note/ui/home_screen.dart';
import 'package:flutter_note/ui/note_details_screen.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        drawer: buildDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.showSnackbar(
              const GetSnackBar(
                title: "added to database",
              ),
            );
          },
        ),
        body: const HomeScreen(),
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomeScreen()),
        GetPage(name: "/noteDetails", page: () => const NoteDetailsScreen()),
      ],
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      width: 50,
      backgroundColor: Colors.blue,
      elevation: 5,
      child: drawerItems(),
    );
  }

  Container drawerItems() {
    return Container(
      child: ListView(
        children: [
          ListTile(),
          ListTile(),
          ListTile(),
          ListTile(),
        ],
      ),
    );
  }
}

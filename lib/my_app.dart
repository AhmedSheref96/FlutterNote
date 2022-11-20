import 'package:flutter/material.dart';
import 'package:flutter_note/ui/home_controller.dart';
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
        appBar: AppBar(
          title: const Text("FlutterNote"),
        ),
        floatingActionButton: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return floatingActionButton(controller);
          },
        ),
        body: const HomeScreen(),
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomeScreen()),
        GetPage(name: "/noteDetails", page: () => const NoteDetailsScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }

  FloatingActionButton floatingActionButton(HomeController controller) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        controller.insertNote();
        Get.showSnackbar(
          const GetSnackBar(
            title: "added to database",
            message: "added to database",
          ),
        );
      },
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: Colors.blue,
      elevation: 5,
      child: drawerItems(),
    );
  }

  ListView drawerItems() {
    return ListView(
      children: const [
        ListTile(
          title: Text("Favorites"),
        ),
        ListTile(
          title: Text("Archived"),
        ),
        ListTile(
          title: Text("Deleted"),
        ),
        ListTile(
          title: Text("Pinned"),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> menus = const [
    {
      "title": "Counter",
      "icon": Icons.exposure_plus_1,
      "route": "/counter",
      "color": Colors.blue,
    },
    {
      "title": "Formulir",
      "icon": Icons.assignment,
      "route": "/formulir",
      "color": Colors.green,
    },
    {
      "title": "Kuliner",
      "icon": Icons.fastfood,
      "route": "/kuliner",
      "color": Colors.orange,
    },
    {
      "title": "Post",
      "icon": Icons.article,
      "route": "/post",
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menus.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final menu = menus[index];
            return GestureDetector(
              onTap: () => Get.toNamed(menu['route']),
              child: Container(
                decoration: BoxDecoration(
                  color: menu['color'],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      menu['icon'],
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      menu['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

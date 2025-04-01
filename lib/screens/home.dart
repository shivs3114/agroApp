import 'dart:io';

import 'package:agro/controller/cropController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StoryScreen extends StatefulWidget {
  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  // Sample user data (Replace with real images & names)
  final List<String> userImages = List.generate(
      10, (index) => "https://source.unsplash.com/100x100/?face$index");

  final List<String> userNames = List.generate(10, (index) => "User $index");
     CropController cropController = Get.put(CropController());

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Stories"), backgroundColor: Colors.green),
      body: Column(
        children: [
          Container(
            height: 110, // Set height to fit the stories
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: userImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3), // Border effect
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.pink, Colors.red],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 35, // Story size
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(userImages[index]),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        userNames[index],
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
  decoration: BoxDecoration(
    color: Colors.white, // Outer container remains white
    border: Border.all(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  height: Get.height / 4,
  child: Center(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Padding around text
      decoration: BoxDecoration(
        color: Colors.blue, // Blue background only for text
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: InkWell(
        onTap: _pickImage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, color: Colors.white), // White icon
            SizedBox(width: 8), // Space between icon and text
            Text(
              'Take a Picture',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  ),
),
Expanded( // Ensures GridView takes available space
            child: Obx(() => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: cropController.items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${cropController.items[index]} tapped!")),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          cropController.items[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),

        ],
      ),
    );
  }
}

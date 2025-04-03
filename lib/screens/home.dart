import 'dart:ffi';
import 'dart:io';

import 'package:agro/controller/cropController.dart';
import 'package:agro/screens/profileScreen.dart';
import 'package:agro/screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    StoryScreen(),
    SearchScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}







class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24)));
  }
}

class StoryScreen extends StatefulWidget {
  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  // Sample user data (Replace with real images & names)
 

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
      floatingActionButton: FloatingActionButton(
        onPressed:(){},child: Icon(Icons.message),),
      appBar: AppBar(
        title: Text("Plantix", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for(int i=0;i<9;i++)CropIcon(imagePath: "assets/potato.png"),
              CircleAvatar(backgroundColor: Colors.blue,
            
                child: IconButton(onPressed: (){}, icon:Icon(Icons.add)))

              ],
            ),
            SizedBox(height: 16),
      
            // Weather Info
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Churk, 3 Apr", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Clear • 23°C / 36°C", style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("26°C", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      Icon(Icons.nightlight_round, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
      
            // Heal Your Crop Section
            Text("Heal your crop", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CropProcessStep(icon: Icons.camera_alt, text: "Take a picture"),
                      Icon(Icons.arrow_forward, color: Colors.black54),
                      CropProcessStep(icon: Icons.description, text: "See diagnosis"),
                      Icon(Icons.arrow_forward, color: Colors.black54),
                      CropProcessStep(icon: Icons.medical_services, text: "Get medicine"),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        // Handle Picture Capture
                      },
                      child: Text("Take a picture", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          Text("Crop Health", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
          SizedBox(height: 10,),
      Container(
           padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
         
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){},
              
               child: Text("Check Crop Health", style: TextStyle(fontSize: 16),)),
            ),
          )
        ],),
      ),
          SizedBox(height: 10,),   
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
          
      
        ]))
    );
      
    
  }}

  class CropIcon extends StatelessWidget {
  final String imagePath;

  CropIcon({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white,
      child: Image.asset(imagePath, height: 40),
    );
  }
}
  class CropProcessStep extends StatelessWidget {
  final IconData icon;
  final String text;

  CropProcessStep({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.green),
        SizedBox(height: 4),
        Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}


import 'package:agro/controller/cropController.dart';
import 'package:agro/controller/profileController.dart';
import 'package:agro/controller/speech_controller.dart';

import 'package:agro/screens/searchScreen.dart';
import 'package:agro/tflite/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glow_container/glow_container.dart';




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
  ProfilePage(),
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




class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Update Profile")),
        backgroundColor: Color.fromARGB(255, 62, 191, 55),
      ),
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
CircleAvatar(
  radius: 80,
  child: Icon(Icons.person,size: 50,),),
  SizedBox(height: 16),

                    TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 84, 174, 101),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Update Profile",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
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
  final CustomImageProcessor processor = CustomImageProcessor();


  CropController cropController = Get.put(CropController());
  final SpeechController controller = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      floatingActionButton:Obx(() => FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: controller.listen,
        child: Icon(
          controller.isListening.value ? Icons.mic : Icons.mic_none,
        ),)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Crop Icons
            Center(
              child: Container(
                height: Get.height*0.4,
                width: Get.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green[300]
                ),
                child: GlowContainer(
                  gradientColors: [Colors.yellow,Colors.orange],
                  glowRadius: 5,
                  containerOptions: ContainerOptions(borderRadius: 20,),
                  child: Obx(() => Center(
                    child: Text(
                              controller.spokenText.value.isEmpty
                      ? 'Tap mic to speak'
                      : controller.spokenText.value,
                              style: TextStyle(fontSize: 20),
                            ),
                  )),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.1,),
           ElevatedButton(onPressed:(){}, child:Text('Diagnose this Problem'))
          ],
        ),
      ),
    );
  }
}

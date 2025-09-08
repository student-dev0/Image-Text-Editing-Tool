import 'package:editing_tool/screens/image_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.upload_file, size: 48),
          onPressed: () async {
            XFile? image = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            if (image != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>

                      ImageEditingScreen(selectedImage: image.path,screenshotController: ScreenshotController(),),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

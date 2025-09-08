import 'dart:typed_data';

import 'package:editing_tool/models/text_info.dart';
import 'package:editing_tool/screens/image_editing_screen.dart';
import 'package:editing_tool/utils/utils.dart';
import 'package:editing_tool/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditImageViewModel extends State<ImageEditingScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  List<TextInfo> texts = [];
  int currentIndex = 0;

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selcted for styling', style: TextStyle(fontSize: 16.0)),
      ),
    );
  }

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController
          .capture()
          .then((Uint8List? image) {
            screenshotController.capture().then((Uint8List? image) {
              if (image != null) {
                saveImage(image);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Image Saved to Gallery',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              }
            });
          })
          // ignore: invalid_return_type_for_catch_error
          .catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    await requestPermisssion(Permission.storage);
    await ImageGallerySaverPlus.saveImage(bytes, name:name);
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted', style: TextStyle(fontSize: 16.0))),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  alignleft() {
    setState(() {
      texts[currentIndex].textalign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textalign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textalign = TextAlign.right;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontsize = texts[currentIndex].fontsize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontsize = texts[currentIndex].fontsize + -2;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontweight == FontWeight.bold) {
        texts[currentIndex].fontweight == FontWeight.normal;
      } else {
        texts[currentIndex].fontweight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontstyle == FontStyle.italic) {
        texts[currentIndex].fontstyle == FontStyle.normal;
      } else {
        texts[currentIndex].fontstyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text = texts[currentIndex].text.replaceAll(
          '\n',
          ' ',
        );
      } else {
        texts[currentIndex].text = texts[currentIndex].text.replaceAll(
          ' ',
          '\n',
        );
      }
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          color: Colors.black,
          text: textEditingController.text,
          left: 0,
          top: 0,
          fontweight: FontWeight.normal,
          fontsize: 20,
          textalign: TextAlign.left,
          fontstyle: FontStyle.normal,
        ),
      );
    });
    Navigator.of(context).pop;
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Text'),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.edit),
            filled: true,
            hintText: 'Your Text Here.....',
          ),
        ),
        actions: [
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
            textColor: Colors.black,
            child: const Text('Back'),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('Add Text'),
          ),
        ],
      ),
    );
  }
}

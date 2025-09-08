import 'package:editing_tool/widgets/edit_image_viewmodel.dart';
import 'package:editing_tool/widgets/image_text.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:screenshot/screenshot.dart';

class ImageEditingScreen extends StatefulWidget {
 final  ScreenshotController screenshotController;
  final String selectedImage;
  const ImageEditingScreen({super.key, required this.selectedImage, required this.screenshotController});

  @override
  State<ImageEditingScreen> createState() => _ImageEditingScreenState();
}

class _ImageEditingScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                _selectedImage,
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentIndex = i;
                          removeText(context);
                        });
                      },
                      onTap: () => setCurrentIndex(context, i),
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final renderbox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderbox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
                          });
                        },
                        child: ImageText(textInfo: texts[i]),
                      ),
                    ),
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _addNewTextFab,
    );
  }

  Widget get _addNewTextFab => FloatingActionButton(
    onPressed: () => addNewDialog(context),
    backgroundColor: Colors.white,
    tooltip: 'Add New Text',
    child: Icon(Icons.edit, color: Colors.black),
  );

  Widget get _selectedImage {
    return Center(
      child: Image.file(
        File(widget.selectedImage),
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  AppBar get _appbar => AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Text('Editing Tool'),

    bottom: PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 800),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.save, color: Colors.black),
                onPressed: () => saveToGallery(context),
                tooltip: 'Save Image',
              ),

              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: increaseFontSize,
                tooltip: 'Increase font size',
              ),

              IconButton(
                icon: Icon(Icons.remove, color: Colors.black),
                onPressed: decreaseFontSize,
                tooltip: 'Decrease font size ',
              ),

              IconButton(
                icon: Icon(Icons.format_align_left, color: Colors.black),
                onPressed: alignleft,
                tooltip: 'Align Left',
              ),

              IconButton(
                icon: Icon(Icons.format_align_center, color: Colors.black),
                onPressed: alignCenter,
                tooltip: 'Align Center',
              ),

              IconButton(
                icon: Icon(Icons.format_align_right, color: Colors.black),
                onPressed: alignRight,
                tooltip: 'Align Right',
              ),

              IconButton(
                icon: Icon(Icons.format_bold, color: Colors.black),
                onPressed: boldText,
                tooltip: 'Bold',
              ),

              IconButton(
                icon: Icon(Icons.format_italic, color: Colors.black),
                onPressed: italicText,
                tooltip: 'Italic',
              ),

              IconButton(
                icon: Icon(Icons.space_bar, color: Colors.black),
                onPressed: () {},
                tooltip: 'Add new Line',
              ),
              const SizedBox(width: 5),

              Tooltip(
                message: 'BlueAcccent',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blueAccent),
                  child: CircleAvatar(backgroundColor: Colors.blueAccent),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'CyanGreen',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.greenAccent),
                  child: CircleAvatar(backgroundColor: Colors.greenAccent),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'purple',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.purpleAccent),
                  child: CircleAvatar(backgroundColor: Colors.purpleAccent),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: CircleAvatar(backgroundColor: Colors.green),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Yellow',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: CircleAvatar(backgroundColor: Colors.yellow),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: CircleAvatar(backgroundColor: Colors.blue),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: CircleAvatar(backgroundColor: Colors.red),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: CircleAvatar(backgroundColor: Colors.black),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: CircleAvatar(backgroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    ),
  );

  //  body: Image.file(File(widget.selectedImage)),
}

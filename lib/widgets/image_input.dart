import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    if (pickedImage == null) {
      return;
    }
    _selectedImage = File(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      alignment: Alignment.center,
      height: 100,
      width: 100,
      child: TextButton.icon(
        onPressed: _takePicture,
        icon: Icon(Icons.camera_alt_outlined),
        label: Text(
          'Take picture',
          textAlign: TextAlign.center,
        ),
      ),
    );
    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
      );
    }
    return content;
  }
}

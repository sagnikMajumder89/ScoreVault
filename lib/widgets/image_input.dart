import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.imageSelected});
  final Function(File?) imageSelected;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 500, maxWidth: 500);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.imageSelected(_selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _takePicture,
        child: CircleAvatar(
          radius: 60,
          child: IconButton(
            iconSize: 35,
            onPressed: _takePicture,
            icon: const Icon(
              Icons.camera_alt_outlined,
            ),
          ),
        ),
      ),
    );
    if (_selectedImage != null) {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _takePicture,
          child: CircleAvatar(
            radius: 80,
            backgroundImage: FileImage(_selectedImage!),
          ),
        ),
      );
    }
    return content;
  }
}

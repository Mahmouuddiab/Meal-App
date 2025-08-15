import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:meal_app/core/Utils/app_colors.dart";

import "../../../../../core/Utils/app_images.dart";

class InputImage extends StatefulWidget{
  const InputImage({
    super.key, 
    required this.onSelectImage,
    required this.imagePath
  });

  final String imagePath;

  final void Function(File image) onSelectImage;
  
  
  @override
  State<StatefulWidget> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage>{

  late File _selectedPicture;

  @override
  void initState(){
    super.initState();
   _selectedPicture = File(widget.imagePath);
  }

  void _takeImage() async {
    final picker = ImagePicker();
    XFile? xfile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 500,
    );
    if (xfile == null) {
      return;
    }
    setState(() {
      _selectedPicture = File(xfile.path);
    });

    widget.onSelectImage(_selectedPicture);
  }


  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage:_selectedPicture.path != "" ? FileImage(
             _selectedPicture
          ) : AssetImage(AppImages.defaultUserImage)
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: IconButton(
              onPressed:_takeImage,
              icon: Icon(
                Icons.edit,
                color:AppColors.white,
              ),

            ),
          ),
        )
      ],
    );
  }
}
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "dart:io";

class ImagePick extends StatefulWidget {
  
  final void Function(File pickedImage) imagepickfn;
  ImagePick(this.imagepickfn);

  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File _pickedImage;  
  void _pickImage(a,b) async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      // imageQuality: 50,
       maxHeight: 0.3*b,
       maxWidth:a, 
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagepickfn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    var a=MediaQuery.of(context).size.width;
   var b=MediaQuery.of(context).size.height;
    // var a=MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
       (_pickedImage!=null) ?CircleAvatar(
          radius: 60,
          backgroundImage: FileImage(_pickedImage),
        ):
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed:()=> _pickImage(a,b),
          icon: Icon(Icons.image),
          label: Text("Add image"),
        ),
      ],
    );
  }
}

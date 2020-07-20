import "package:flutter/material.dart";
// import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
// import "package:http/http.dart" as http;
// import 'package:wallpapers/screens/homepage.dart';
import "package:wallpapers/widgets/image_pick.dart";
import "dart:io";
import "dart:math";
// import "package:firebase_storage/firebase_storage.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "dart:convert";

class TextForm extends StatefulWidget {
  static const routename = '/textform';
  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final _placefocusnode = FocusNode();
  final _memoryfocusnode = FocusNode();
  final _namecontroller = TextEditingController();
  final _placecontroller = TextEditingController();
  final _memorycontoller = TextEditingController();
  final _datecon = TextEditingController();
  final _namefocusnode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  File _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  String date = "";
  String place = "";
  String text = "";
  String name = "";

  @override
  void dispose() {
    _namefocusnode.dispose();
    _memoryfocusnode.dispose();
    _placefocusnode.dispose();

    super.dispose();
  }

  Future<void> uploadImageToFirebase(File image, BuildContext context) async {
    try {
      // Make random image name.
      print(3);
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/image${randomNumber}.jpg';

      // Upload image to firebase.
      print(4);
      final StorageReference storageReference =
          FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      print(6);
      await uploadTask.onComplete;
      print(8);
      print("file uploaded");
      _addPathToDatabase(imageLocation, context);
    } catch (e) {
      print(e.message);
    }
  }

  var _isLoading = false;

  Future<void> _addPathToDatabase(String text1, BuildContext context) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage().ref().child(text1);
      var imageString = await ref.getDownloadURL();

      // Add location and url to database
      await Firestore.instance.collection('images').document().setData(
        {
          'url': imageString,
          'location': text1,
          "text": text,
          "date": date,
          "place": place,
          "name": name
        },
      );
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }

  Future<void> _saveForm(image) async {
    print(1);
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(2);
    setState(() {
      _isLoading = true;
    });
    try {
      print(3);
      await uploadImageToFirebase(image, context);
      print(4);
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    // finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   Navigator.of(context).pop();
    // }
    Navigator.of(context).pop();
  }

  // Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseStorage().ref().child(text);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Memories...")),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            constraints: BoxConstraints(
              minHeight: 360,
            ),
            width: deviceSize.width,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ImagePick(_pickedImage),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Date:"),
                      controller: _datecon,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_placefocusnode);
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Date is empty";
                        return null;
                      },
                      onSaved: (value) {
                        date = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Place:"),
                      textInputAction: TextInputAction.next,
                      controller: _placecontroller,
                      focusNode: _placefocusnode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_memoryfocusnode);
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Enter the place";
                        return null;
                      },
                      onSaved: (value) {
                        place = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Memories..."),
                      maxLines: 10,
                      controller: _memorycontoller,
                      keyboardType: TextInputType.multiline,
                      focusNode: _memoryfocusnode,
                      validator: (value) {
                        if (value.isEmpty)
                          return "You forgot to pen down your memories";
                        return null;
                      },
                      onSaved: (value) {
                        text = value;
                        print("ready to be uploaded");
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      keyboardType: TextInputType.text,
                      controller: _namecontroller,
                      focusNode: _namefocusnode,
                      validator: (value) {
                        if (value.isEmpty)
                          return "You forgot to write your name";
                        return null;
                      },
                      onSaved: (value) {
                        name = value;
                        print("ready to be uploaded");
                      },
                      onFieldSubmitted: (_) {
                        print("saved");
                        // _saveForm(_userImageFile);
                        // addProduct(_pickedImage);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(15),),
                    Center(
                      child: FloatingActionButton(
                        elevation: 8,
                        child: Icon(Icons.assignment_turned_in),
                        onPressed: () => _saveForm(_userImageFile),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Future<void> addProduct(image) async {
//   int randomNumber = Random().nextInt(100000);
//     String imageLocation = 'images/image${randomNumber}.jpg';
//     final StorageReference storageReference =
//         FirebaseStorage().ref().child(imageLocation);
//     final StorageUploadTask uploadTask = storageReference.putFile(image);
//     await uploadTask.onComplete;
//     final ref = FirebaseStorage().ref().child("images");
//     var imageString = await ref.getDownloadURL();

//   final url =
//       'https://wallpapers-cb4dd.firebaseio.com/images.json';
//   try {
//     final response = await http.post(
//       url,
//       body: json.encode({
//         'url': imageString,
//         "location":imageLocation,
//         "text": text,
//         "date": date,
//         "place": place,
//         "name": name
//       }),
//     );

//     // _items.insert(0, newProduct); // at the start of the list

//   } catch (error) {
//     print(error);
//     throw error;
//   }
// }

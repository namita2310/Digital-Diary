import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart"; // as firestore;
import "package:firebase_storage/firebase_storage.dart";
// import "package:wallpapers/widgets/image_wid.dart";
import "package:wallpapers/widgets/text_form.dart";
import "package:image_picker/image_picker.dart";
import "dart:io";
import "package:google_fonts/google_fonts.dart";
import "dart:math";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Image _pickedimg;
  File img;
  String uploadedImg;
  DateTime i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memories..."),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Flexible(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TextForm.routename);
        },
        child: Icon(Icons.brush),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("images").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return PageView(
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   var ref= Firestore.instance.collection("images").document().get();
//   final record = Record.fromSnapshot(data);
//   return Padding(
//     key: ValueKey(record.location),
//     padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: ListTile(
//         title: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(1.0),

//               child: Text(
//                "Date: ${record.date}\nPlace: ${record.place}\n${record.text}\nName:${record.name}"

//                , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),

//             ),
//             Image.network(record.url),
//             GridTileBar(
//                 backgroundColor: Colors.black87,
//                 leading: IconButton(
//                   icon: Icon(Icons.favorite,),
//                   onPressed: null,

//                 ),
//                 trailing: IconButton(
//                   icon: Icon(Icons.border_color),
//                   onPressed: (){

//                   // .pushReplacementNamed(TextForm.routename);
//                   },

//                 ),
//                 ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

class Record {
  final String location;
  final String url;
  final String name;
  final String place;
  final String date;
  final String text;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        assert(map['text'] != null),
        assert(map['date'] != null),
        assert(map['place'] != null),
        assert(map['name'] != null),
        location = map['location'],
        url = map['url'],
        text = map["text"],
        place = map["place"],
        name = map["name"],
        date = map["date"];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url:$text$date$place$name>";
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  var ref = Firestore.instance.collection("images").document().get();
  var a = MediaQuery.of(context).size.width;
  var b = MediaQuery.of(context).size.height;
  final record = Record.fromSnapshot(data);
  return Card(
    elevation: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(18.0),
      ),
    ),
    child: PageView(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18.0),
            bottomRight: Radius.circular(18.0),
          ),
          child: Container(
            color: Colors.brown[50],
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 4),
                  ),
                  child: (record.url!=null)?Image.network(
                    record.url,
                    width: double.infinity,
                    height: 2 * b / 6,
                    alignment: Alignment.topLeft,
                    fit: BoxFit.fitWidth,
                  ):CircularProgressIndicator(),
                ),
                // GridTileBar(
                //   backgroundColor: Colors.black87,
                //   leading: IconButton(
                //     icon: Icon(
                //       Icons.favorite,
                //     ),
                //     onPressed: null,
                //   ),
                //   trailing: IconButton(
                //     icon: Icon(Icons.border_color),
                //     onPressed: () {
                //       // .pushReplacementNamed(TextForm.routename);
                //     },
                //   ),
                // ),
                Padding(padding: EdgeInsets.all(5.0),),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        
                        "Date: ${record.date}\nPlace: ${record.place}\n\n${record.text}\n\n${record.name}",
                        style:GoogleFonts.pacifico( fontSize: 20,),
                        //  style:TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 20,
                          
                        //   decoration: TextDecoration.underline,
                        // ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

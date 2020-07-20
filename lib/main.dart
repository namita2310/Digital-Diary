import 'package:flutter/material.dart';
import 'package:wallpapers/screens/homepage.dart';
import "package:wallpapers/widgets/text_form.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Themes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: HomePage(),
      routes: {
        TextForm.routename:(ctx)=>TextForm(),
      },
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:page_turn/page_turn.dart';


// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class AlicePage extends StatelessWidget {
//   final int page;

//   const AlicePage({Key key, this.page}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle.merge(
//       style: TextStyle(fontSize: 16.0),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Text(
//                 "CHAPTER $page",
//                 style: TextStyle(
//                   fontSize: 32.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 "Down the Rabbit-Hole",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 32.0),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(
//                     child: Text(
//                         "Alice was beginning to get very tired of sitting by her sister on the bank, and of"
//                         " having nothing to do: once or twice she had peeped into the book her sister was "
//                         "reading, but it had no pictures or conversations in it, `and what is the use of "
//                         "a book,' thought Alice `without pictures or conversation?'"),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 12.0),
//                     color: Colors.black26,
//                     width: 160.0,
//                     height: 220.0,
//                     child: Placeholder(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               Text(
//                 "So she was considering in her own mind (as well as she could, for the hot day made her "
//                 "feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be "
//                 "worth the trouble of getting up and picking the daisies, when suddenly a White "
//                 "Rabbit with pink eyes ran close by her.\n"
//                 "\n"
//                 "There was nothing so very remarkable in that; nor did Alice think it so very much out "
//                 "of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be "
//                 "late!' (when she thought it over afterwards, it occurred to her that she ought to "
//                 "have wondered at this, but at the time it all seemed quite natural); but when the "
//                 "Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then "
//                 "hurried on, Alice started to her feet, for it flashed across her mind that she had "
//                 "never before seen a rabbit with either a waistcoat-pocket, or a watch to take out "
//                 "of it, and burning with curiosity, she ran across the field after it, and fortunately "
//                 "was just in time to see it pop down a large rabbit-hole under the hedge.",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _controller = GlobalKey<PageTurnState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageTurn(
//         key: _controller,
//         backgroundColor: Colors.white,
//         showDragCutoff: false,
//         lastPage: Container(child: Center(child: Text('Last Page!'))),
//         children: <Widget>[
//           for (var i = 0; i < 20; i++) AlicePage(page: i),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.search),
//         onPressed: () {
//           _controller.currentState.goToPage(i+1);
//         },
//       ),
//     );
//   }
// }

// import 'dart:io';

import "package:flutter/material.dart";


class WallPaper extends StatelessWidget {

  final  imageGallery;
  WallPaper(this.imageGallery);

  @override
  Widget build(BuildContext context) {
          // final img = Provider.of<ImageWidget>(context, listen: false);

    return  ClipRRect(
        
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(...);
            },
            child:Image.network(imageGallery),
             
          ),
            footer: GridTileBar(backgroundColor: Colors.black87,
            leading: Center(child: Icon(Icons.favorite),),),
          ),
        
      );
    
  }
}

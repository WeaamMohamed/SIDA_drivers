import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget bottomsheetChangePhoto(context ,takephoto, deletePhoto)
{
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 20
        ,vertical: 20),
    child: Column(
      children: <Widget>[
        Text('Choose Profile Picture',
          style: TextStyle(
              fontSize: 20
          ),
        ),
        SizedBox( height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon( Icons.camera),
              onPressed: (){
                takephoto(ImageSource.camera);
                Navigator.pop(context);

              },
              label: Text('Camera'),
            ),
            FlatButton.icon(
              icon: Icon( Icons.image),
              onPressed: (){
                takephoto(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text('Gallery'),
            ),
            FlatButton.icon(
              icon: Icon( Icons.delete),
              onPressed: (){
                deletePhoto();
                Navigator.pop(context);
              },
              label: Text('Remove'),
            )

          ],

        )
      ],
    ),
  );


}
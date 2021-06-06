import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;
import 'package:http/http.dart' as http;
import 'package:seeip_client/seeip_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';






class ImageUploadPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Upload image'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  String uploadingimage;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        settoblob(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }
  Future getImagefromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        settoblob(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 400.0,
              child: Center(
                child: _image == null
                    ? Text("No Image is picked")
                    : Image.file(_image),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: getImage,
                tooltip: "pickImage from camera",
                child: Icon(Icons.add_a_photo),
                heroTag: null,
              ),
              FloatingActionButton(
                onPressed: getImagefromGallery,
                tooltip: "Pick Image from gallery",
                child: Icon(Icons.file_upload),
                heroTag: null,
              ),


           ],
          ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

              FloatingActionButton.extended(

                onPressed: uploadImage,
                tooltip: "upload image",
                icon:Icon(Icons.save_outlined),
                label:Text("save"),
                heroTag: null,
              ),

                ]),
        ],
      ),
    );
  }


    Future<http.Response> uploadImage()async {
      var seeip = SeeipClient();
      var ipaddress = await seeip.getIP();
      print(ipaddress);
      final response=await http.post(
        Uri.parse('https://roadmakergo.herokuapp.com/save_form'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        'ipaddress':ipaddress.toString(),
          'image':uploadingimage
        }),
      );
      if (response.statusCode >= 200 && response.statusCode<= 300) {
        Fluttertoast.showToast(
            msg: "Uploaded Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
        // If the server did return a 201 CREATED response,
        // then parse the JSON.

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create album.');
      }
    }

  Future<void> settoblob(String path) async {
    final bytes = Io.File(path).readAsBytesSync();
    base64Encode(List<int> bytes) => base64.encode(bytes);
    uploadingimage=base64Encode(bytes);
   /* SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', base64Encode(bytes));*/
  }

  /*getImageString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString('image');
  }*/

  }







import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/blocs/app_state_provider.dart';
import 'package:iremember/theme/theme_provider.dart';
import 'package:iremember/widgets/loading_overlay.dart';

//TODO allow user to pick image and display the preview in UI
//TODO save new data to firestore (upload image to storage)
class AddPage extends StatefulWidget {

  static const String route = '/add';

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: LoadingOverlay.willPop,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          _buildTitleField(),
          SizedBox(
            height: 20,
          ),
          _buildDescriptionField(),
          SizedBox(
            height: 20,
          ),
          _buildImgSelectButton(),
          SizedBox(
            height: 20,
          ),
          _buildSaveButton(context)
        ],
      ),
    ));
  }

  TextField _buildTitleField() {
    var appState = AppStateProvider.of(context);
    return TextField(
      onChanged: appState.articleBloc.addTitle,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "title",
          prefixIcon: Icon(Icons.title)),
    );
  }

  TextField _buildDescriptionField() {
    var appState = AppStateProvider.of(context);

    return TextField(
      onChanged: appState.articleBloc.addDescription,
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
    );
  }

  Widget _buildImgSelectButton() {
    var appState = AppStateProvider.of(context);
    var themeData =ThemeProvider.of(context);

    return ValueListenableBuilder(
      valueListenable: appState.articleBloc.image, 
      builder: (BuildContext context, File image, Widget child){
        if(image!= null) return Container(
          height: 150,
          child: Image.file(image),
        );
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton.icon(
        icon: Icon(Icons.camera,
          color: themeData.primaryWhite,
        ),
        label: Text("Add Image",
          style: TextStyle(
            color: themeData.primaryWhite
          ),
        ),
        color: themeData.primaryBlue,
        onPressed: () async {
          var image = await ImagePicker.pickImage(source: ImageSource.gallery);
          await appState.articleBloc.addImage(image);
        },
      ),
    );
    });
  }

  SizedBox _buildSaveButton(BuildContext context) {
    var themeData =ThemeProvider.of(context);
    return SizedBox(
      height: 50,
      width: 20.0,
      child: RaisedButton.icon(
        icon: Icon(Icons.save,
          color: themeData.primaryWhite,
        ),
        label: Text("Save",
         style: TextStyle(
            color: themeData.primaryWhite
          ),
        ),
        color: themeData.primaryBlue,
        onPressed: () async {
          final appSate = AppStateProvider.of(context);
          LoadingOverlay.showLoadingOverlay(context);
          var res = await appSate.articleBloc.submit();
          LoadingOverlay.hideOverLay();
          if(res){
            Navigator.popUntil(context, (r) => r.settings.name == '/');
          }
        },
      ),
    );
  }
}

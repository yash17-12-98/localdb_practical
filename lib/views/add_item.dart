import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wapnet/models/item.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  static var _favourites = [0, 1];
  TextEditingController titleController = TextEditingController();
  File? selectedImageFile;
  Item? item;
  List<int>? imageBytes;
  String base64Image = "", imageFileName = "";
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
      ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 12.0, right: 12.0),
          child: ListView(
            children: <Widget>[

              // First element
              // ListTile(
              //   title: DropdownButton(
              //       items: _favourites.map((int dropDownStringItem) {
              //         return DropdownMenuItem<int> (
              //           value: dropDownintItem,
              //           child: Text(dropDownintItem),
              //         );
              //       }).toList(),
              //
              //       style: textStyle,
              //
              //       value: getFavAsInt(note.priority),
              //
              //       onChanged: (valueSelectedByUser) {
              //         setState(() {
              //           debugPrint('User selected $valueSelectedByUser');
              //           updatePriorityAsInt(valueSelectedByUser);
              //         });
              //       }
              //   ),
              // ),

              // Second Element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  maxLines: 1,
                  onChanged: (value) {
                    debugPrint('Something changed in Title Text Field');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),


              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: 300,
                      width: double.maxFinite,
                      child: selectedImageFile == null ? Image.asset(
                          "assets/ic_placeholder.jpg") : Image.file(selectedImageFile!)),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          _newTaskModalBottomSheet(context);
                        },
                        elevation: 2.0,
                        fillColor:Colors.blue,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      Text("Upload Image")
                    ],
                  ),
                ],
              ),

              // Third Element
              // Padding(
              //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              //   child: TextField(
              //     controller: descriptionController,
              //     style: textStyle,
              //     onChanged: (value) {
              //       debugPrint('Something changed in Description Text Field');
              //       updateDescription();
              //     },
              //     decoration: InputDecoration(
              //         labelText: 'Description',
              //         labelStyle: textStyle,
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(5.0)
              //         )
              //     ),
              //   ),
              // ),

              // Fourth Element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                            // _save();
                          });
                        },
                      ),
                    ),

                    Container(width: 5.0,),

                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                            // _delete();
                          });
                        },
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
    );
  }

  void _newTaskModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                        child: Text(
                          "Choose option",
                          style: TextStyle(fontSize: 22.0),
                        )),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              onPressed: () {
                                _pickImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.photo_library,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              onPressed: () {
                                // loadAssets(albumId);
                                _pickImage(ImageSource.gallery);

                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25.0,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ));
        });
  }

  Future<void> _pickImage(ImageSource source) async {
    // final pickedFile = await picker.getImage(source: source);
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImageFile = File(pickedFile.path);
      });
    }
  }

  int getFavAsInt(int value) {
    int fav = 0;
    switch (value) {
      case 1:
        fav = _favourites[0];  // 'High'
        break;
      case 2:
        fav = _favourites[1];  // 'Low'
        break;
    }
    return fav;
  }

  void updateTitle(){
    item!.title = titleController.text;
  }
}

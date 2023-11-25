import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mac_test/api/category.dart';
import 'package:new_mac_test/api/location.dart';
import 'package:new_mac_test/api/media.dart';
import 'package:new_mac_test/api/stores.dart';
import 'package:new_mac_test/models/category.dart';
import 'package:new_mac_test/models/store.dart';

class RegisterStoreModal extends StatefulWidget {
  final double latitude;
  final double longitude;

  RegisterStoreModal(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<RegisterStoreModal> createState() => _RegisterStoreModalState();
}

class _RegisterStoreModalState extends State<RegisterStoreModal> {
  List<Category> _categories = [];
  List<Category> _selectedCategories = [];
  List<XFile>? _images = [];
  String _storeName = "";
  String _storeAddress = "";

  @override
  void initState() {
    super.initState();
    initStoreDetails();
  }

  initStoreDetails() async {
    List<Category> res = await getCategories();
    setState(() {
      _categories = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: true,
        initialChildSize: 0.32,
        minChildSize: 0.32,
        maxChildSize: 0.8,
        shouldCloseOnMinExtent: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              width: MediaQuery.of(context).size.width - 32,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              color: Colors.white,
              child: ListView(
                controller: scrollController,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Store Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _storeName = value;
                      });
                    },
                  ),
                  // SizedBox(height: 16),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Store Address',
                  //   ),

                  // ),
                  SizedBox(height: 16),
                  Wrap(
                    children: _categories
                        .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selectedCategories.contains(e)) {
                                  _selectedCategories.remove(e);
                                } else {
                                  _selectedCategories.add(e);
                                }
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 4),
                                child: Chip(
                                  label: Text(e.name ?? ""),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  backgroundColor:
                                      _selectedCategories.contains(e)
                                          ? Colors.teal
                                          : Colors.white,
                                  labelStyle: TextStyle(
                                    color: _selectedCategories.contains(e)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ))))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  (_images != null
                              ? _images
                                  ?.map((e) => Image.file(File(e.path)))
                                  .toList()
                              : [])!
                          .isNotEmpty
                      ? Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _images!.length + 1,
                            itemBuilder: (BuildContext context, int index) =>
                                index < _images!.length
                                    ? Image.file(File(_images![index].path))
                                    : GestureDetector(
                                        onTap: () async {
                                          final ImagePicker _picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await _picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            _images!.add(image!);
                                          });
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.grey,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(width: 8),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              _images!.add(image!);
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey,
                            child: Icon(Icons.add),
                          ),
                        ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      Store res = await createStore(Store(
                        name: _storeName,
                      ));
                      String storeId = res.id ?? "";
                      if (storeId != '') {
                        await createLocationForStore(
                            storeId, widget.latitude, widget.longitude);
                        await updateStoreCategories(storeId,
                            _selectedCategories.map((e) => e.id ?? 0).toList());
                        for (XFile image in _images!) {
                          await uploadMedia(storeId, File(image.path));
                        }
                      }
                    },
                    child: Text("Register"),
                  ),
                  SizedBox(height: 16),
                ],
              ));
        });
  }
}

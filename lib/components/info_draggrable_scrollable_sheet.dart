import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mac_test/api/media.dart';
import 'package:new_mac_test/api/stores.dart';
import 'package:new_mac_test/api/visit.dart';
import 'package:new_mac_test/components/category_chip.dart';
import 'package:new_mac_test/models/category.dart';
import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/media.dart';
import 'package:new_mac_test/models/store.dart';
import 'package:new_mac_test/models/visit.dart';

class InfoDraggrableScrollableSheet extends StatefulWidget {
  final String id;

  const InfoDraggrableScrollableSheet({super.key, required this.id});

  @override
  State<InfoDraggrableScrollableSheet> createState() =>
      _InfoDraggrableScrollableSheetState();
}

class _InfoDraggrableScrollableSheetState
    extends State<InfoDraggrableScrollableSheet> {
  (Store, Location, List<Media>, List<Category>, Visit?) _store = (
    Store(
      name: "",
    ),
    Location(),
    [],
    [],
    null
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStoreDetails();
  }

  initStoreDetails() async {
    if (widget.id == "") {
      return;
    }
    (Store, Location, List<Media>, List<Category>, Visit?) res =
        await getStore(widget.id);
    setState(() {
      _store = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != ""){
      if(widget.id != _store.$1.id){
        print("They are different");
        initStoreDetails();
      }
    }
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.32,
      minChildSize: 0.32,
      maxChildSize: 0.6,
      shouldCloseOnMinExtent: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return _store.$1.id != null ? widget.id != ""
            ? Container(
                width: MediaQuery.of(context).size.width - 32,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                color: Colors.white,
                child: ListView(
                  controller: scrollController,
                  children: [
                    const Icon(Icons.drag_handle),
                    Text(
                      _store.$1.name ?? "Store Name",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _store.$4.isEmpty
                        ? Container()
                        : SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _store.$4.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  CategoryChip(
                                      name: _store.$4[index].name ?? ""),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(width: 8),
                            ),
                          ),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _store.$3.length + 1,
                          itemBuilder: (BuildContext context, int index) => index <
                                  _store.$3.length
                              ? Image.network(
                                  _store.$3[index].ref != null
                                      ? 'https://chjzbaxswixtqvtytkyz.supabase.co/storage/v1/object/public/${_store.$3[index].ref}'
                                      : "https://placehold.co/150x150.png",
                                  width: 150,
                                  fit: BoxFit.cover,
                                  height: 100)
                              : Container(
                                  width: 150,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image =
                                          await picker.pickImage(
                                              source: ImageSource.gallery);
                                      final storeId = _store.$1.id;
                                      if (image != null && storeId != null) {
                                        await uploadMedia(
                                            storeId, File(image.path));
                                        initStoreDetails();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 8)),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _store.$2.displayAddress ?? "Address",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Last Visit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _store.$5 != null
                        ? Text(
                            _store.$5!.visitedAt.toString().split('T')[0],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        : const Text(
                            "No visit yet",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green, backgroundColor: Colors.green[50],
                          ),
                          onPressed: () async {
                            await createVisit(Visit(
                              locationId: _store.$2.id,
                              visitedAt: DateTime.now(),
                            ));
                            initStoreDetails();
                          },
                          icon: const Icon(
                            Icons.check,
                            size: 24.0,
                          ),
                          label: const Text('Check in'),
                        ),
                      ],
                    )
                  ],
                ))
            : Container() : Container();
      },
    );
  }
}

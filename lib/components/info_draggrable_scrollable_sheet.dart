import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_mac_test/api/stores.dart';
import 'package:new_mac_test/components/category_chip.dart';
import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/media.dart';
import 'package:new_mac_test/models/store.dart';

class InfoDraggrableScrollableSheet extends StatefulWidget {
  final String id;

  InfoDraggrableScrollableSheet({super.key, required this.id});

  @override
  State<InfoDraggrableScrollableSheet> createState() =>
      _InfoDraggrableScrollableSheetState();
}

class _InfoDraggrableScrollableSheetState
    extends State<InfoDraggrableScrollableSheet> {
  (Store, Location, List<Media>) _store = (Store(), Location(), []);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStoreDetails();
  }

  initStoreDetails() async {
    setState(() async {
      _store = await getStore(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.32,
      minChildSize: 0.32,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return _store.$1.id != null
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                color: Colors.white,
                child: ListView(
                  controller: scrollController,
                  children: [
                    Icon(Icons.drag_handle),
                    Text(
                      _store.$1.name ?? "Store Name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        CategoryChip(name: "dessert"),
                        SizedBox(width: 8),
                        CategoryChip(name: "korean"),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _store.$3.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Image.network(
                                  _store.$3[index].ref != null
                                      ? 'https://chjzbaxswixtqvtytkyz.supabase.co/storage/v1/object/public/${_store.$3[index].ref}'
                                      : "https://placehold.co/150x150.png",
                                  width: 150,
                                  fit: BoxFit.cover,
                                  height: 100),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 8)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "1234 Main St, San Francisco, CA 94122",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        IconButton(
                            onPressed: () async {
                              Clipboard.setData(ClipboardData(text: 'test'));
                            },
                            icon: Icon(Icons.copy, size: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.add))
                      ],
                    )
                  ],
                ))
            : Container();
      },
    );
  }
}

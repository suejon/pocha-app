import 'package:flutter/material.dart';
import 'package:new_mac_test/api/stores.dart';
import 'package:new_mac_test/components/category_chip.dart';
import 'package:new_mac_test/models/category.dart';
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
  (Store, Location, List<Media>, List<Category>) _store =
      (Store(), Location(), [], []);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStoreDetails();
  }

  initStoreDetails() async {
    (Store, Location, List<Media>, List<Category>) res =
        await getStore(widget.id);
    setState(() {
      _store = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.32,
      minChildSize: 0.32,
      maxChildSize: 0.7,
      shouldCloseOnMinExtent: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return _store.$1.id != null
            ? Container(
                width: MediaQuery.of(context).size.width - 32,
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
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _store.$4.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CategoryChip(name: _store.$4[index].name ?? ""),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 8),
                      ),
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
                    SizedBox(height: 8),
                    Text(
                      _store.$2.displayAddress ?? "Address",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            primary: Colors.red,
                            backgroundColor: Colors.red[50],
                          ),
                          // <-- TextButton
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            size: 24.0,
                          ),
                          label: Text('Not here'),
                        ),
                        SizedBox(width: 8),
                        TextButton.icon(
                          // <-- TextButton
                          style: TextButton.styleFrom(
                            primary: Colors.green,
                            backgroundColor: Colors.green[50],
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.check,
                            size: 24.0,
                          ),
                          label: Text('Still here'),
                        ),
                      ],
                    )
                  ],
                ))
            : Container();
      },
    );
  }
}

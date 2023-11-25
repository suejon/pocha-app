import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_mac_test/components/category_chip.dart';

class InfoDraggrableScrollableSheet extends StatefulWidget {
  InfoDraggrableScrollableSheet({super.key});

  @override
  State<InfoDraggrableScrollableSheet> createState() =>
      _InfoDraggrableScrollableSheetState();
}

class _InfoDraggrableScrollableSheetState
    extends State<InfoDraggrableScrollableSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: ListView(
              controller: scrollController,
              children: [
                Icon(Icons.drag_handle),
                Text(
                  "Jared's Pocha",
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
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) =>
                          Image.network(
                              'https://media.istockphoto.com/id/1419410282/ko/%EC%82%AC%EC%A7%84/%EC%95%84%EB%A6%84-%EB%8B%A4%EC%9A%B4-%EB%B0%9D%EC%9D%80-%ED%83%9C%EC%96%91-%EA%B4%91%EC%84%A0%EC%9C%BC%EB%A1%9C-%EB%B4%84%EC%97%90%EC%84%9C-%EC%82%AC%EC%9D%BC%EB%9F%B0%ED%8A%B8-%EC%88%B2.jpg?s=2048x2048&w=is&k=20&c=qdZOqoFw6-oV6tl9k2QnQDuqPw1D9aVAPOtmq_-XUs0=',
                              width: 150,
                              height: 150),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 8)),
                ),
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
                )
              ],
            ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../data/models/album_model.dart';
import 'image_item.dart';
import 'shimmer_album_item.dart';

class AlbumItem extends StatelessWidget {
  final AlbumModel album;

  const AlbumItem(this.album);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController(initialScrollOffset: 10000);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(album.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 150,
            child: album.images.isEmpty
                ? ShimmerAlbumItem()
                : NotificationListener<ScrollNotification>(
                    onNotification: (_) {
                      if (controller.offset <= 0 ||
                          controller.offset >=
                              controller.position.maxScrollExtent) {
                        controller.jumpTo(10000);
                      }
                      return true;
                    },
                    child: ListView.builder(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final img = album.images[index % album.images.length];
                        return ImageItem(img);
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

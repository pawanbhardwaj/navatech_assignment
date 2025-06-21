import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:navatech_assignment/blocs/album_event.dart';
import 'package:navatech_assignment/blocs/album_state.dart';
import '../blocs/album_bloc.dart';
import '../widgets/album_item.dart';
import '../widgets/shimmer_album_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController(initialScrollOffset: 10000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AlbumBloc, AlbumState>(
        listener: (context, state) {
          controller.addListener(() {
            if (controller.position.pixels >=
                controller.position.maxScrollExtent - 300) {
              // context.read<AlbumsBloc>().add(LoadMoreAlbums());
            }
          });
        },
        builder: (context, state) {
          if (state is AlbumInitial) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (_, __) => ShimmerAlbumItem(),
            );
          } else if (state is AlbumLoaded) {
            return NotificationListener<ScrollNotification>(
              onNotification: (_) {
                if (controller.offset <= 0 ||
                    controller.offset >= controller.position.maxScrollExtent) {
                  controller.jumpTo(10000);
                }
                return true;
              },
              child: ListView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  final album = state.albums[index % state.albums.length];
                  return AlbumItem(album);
                },
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/error.json', width: 200),
                  SizedBox(height: 20),
                  Text('Something went wrong', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () =>
                        context.read<AlbumBloc>().add(LoadAlbums()),
                    child: Text('Retry'),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

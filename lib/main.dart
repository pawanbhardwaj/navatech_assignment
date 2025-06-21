import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/blocs/album_event.dart';
import 'blocs/album_bloc.dart';
import 'repositories/album_repository.dart';
import 'screens/home_screen.dart';
import 'data/local/database.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.init();
  await setupDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Album Scroll',
      home: BlocProvider(
        create: (_) => AlbumBloc(albumRepository: getIt<AlbumRepository>())
          ..add(LoadAlbums()),
        child: HomeScreen(),
      ),
    );
  }
}

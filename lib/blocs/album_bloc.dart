// album_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/blocs/album_state.dart';
import 'package:navatech_assignment/blocs/album_event.dart';
import 'package:navatech_assignment/repositories/album_repository.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository albumRepository;

  AlbumBloc({required this.albumRepository}) : super(AlbumInitial()) {
    on<LoadAlbums>((event, emit) async {
      try {
        final albums = await albumRepository.getAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError('Failed to load albums: $e'));
      }
    });
  }
}

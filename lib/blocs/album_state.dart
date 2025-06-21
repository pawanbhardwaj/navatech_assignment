// album_bloc_state.dart
import 'package:equatable/equatable.dart';
import 'package:navatech_assignment/data/models/album_model.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();
}

class AlbumInitial extends AlbumState {
  @override
  List<Object?> get props => [];
}

class AlbumLoaded extends AlbumState {
  final List<AlbumModel> albums;

  const AlbumLoaded(this.albums);

  @override
  List<Object?> get props => [albums];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';

class GenreMovie extends Equatable {
  const GenreMovie({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}

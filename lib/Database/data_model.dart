import 'package:objectbox/objectbox.dart';

@Entity()
class DM {
  @Id()
  int id;

  String name;
  
  DM({required this.name, this.id = 0});
}

@Entity()
class Game {
  @Id()
  int id;

  String name;

  DateTime createdAt;

  Game({required this.name, required this.createdAt, this.id = 0});

  final dm = ToOne<DM>();
}
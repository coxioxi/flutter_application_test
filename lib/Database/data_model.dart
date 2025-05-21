import 'package:objectbox/objectbox.dart';

/// Represents a Dungeon Master (DM) in the app.
///
/// This entity is stored locally using ObjectBox and corresponds to a single user.
/// Each DM has a unique [firebaseUid] from Firebase Authentication, allowing local
/// data to be associated with authenticated users.
///
/// A DM can be associated with many [Game] entities via a one-to-many relationship.
@Entity()
class DM {
  /// ObjectBox-generated unique ID for the DM.
  @Id()
  int id;

  /// Display name of the Dungeon Master.
  String name;

  /// Firebase UID that uniquely identifies the DM across devices.
  String firebaseUid;

  /// One-to-many relationship: A DM can have multiple games.
  ///
  /// This is a backlink to the `dm` field in the [Game] class.
  @Backlink('dm')
  final game = ToMany<Game>();

  /// Creates a new [DM] instance.
  DM({
    required this.name, 
    required this.firebaseUid, 
    this.id = 0
  });
}

/// Represents a single Dungeons & Dragons (or similar) game session.
///
/// Each game belongs to one [DM] and has a name and creation date.
/// This entity is stored locally using ObjectBox.
@Entity()
class Game {
  /// ObjectBox-generated unique ID for the Game.
  @Id()
  int id;

  /// Name or title of the game session.
  String name;

  /// The date and time when the game was created.
  @Property(type: PropertyType.date)
  DateTime createdAt;

  /// The DM (Dungeon Master) who owns this game.
  ///
  /// This is a one-to-one relationship linking the game to its creator.
  final dm = ToOne<DM>();

  // Relationships
  @Backlink('game')
  final players = ToMany<Player>();

  @Backlink('game')
  final monsters = ToMany<Monster>();

  @Backlink('game')
  final gameLogs = ToMany<GameLogs>();

  /// Creates a new [Game] instance.
  Game({
    required this.name, 
    required this.createdAt, 
    this.id = 0
    });
}

/// Represents a player character in a game session.
@Entity()
class Player {
  @Id()
  int id; // Unique identifier for the player (automatically set by ObjectBox)

  String name; // Player's name

  int hp; // Hit points

  int ac; // Armor Class (defensive stat)

  int initModifier; // Initiative modifier (used to calculate turn order)

  int? initiativeNum; // Initiative value after rolling (nullable until set)

  // Relationship to the Game entity (each player belongs to one game)
  final game = ToOne<Game>();

  Player({
    required this.name,
    required this.hp,
    required this.ac,
    required this.initModifier,
    this.id = 0,
  });
}

/// Represents a monster (enemy/NPC) in a game session.
@Entity()
class Monster {
  @Id()
  int id; // Unique identifier for the monster

  String name; // Monster's name

  String damage; // Description of the monster's damage (e.g., "1d6 + 3")

  int hp; // Hit points

  int ac; // Armor Class

  int initModifier; // Initiative modifier

  int? initiativeNum; // Initiative value after rolling (nullable until set)

  // Relationship to the Game entity (each monster belongs to one game)
  final game = ToOne<Game>();

  Monster({
    required this.name,
    required this.hp,
    required this.ac,
    required this.initModifier,
    required this.damage,
    this.id = 0,
  });
}

/// Stores log entries related to gameplay, like dice rolls or combat events.
@Entity()
class GameLogs {
  @Id()
  int id; // Unique identifier for the log entry

  String message; // The log message (e.g., "Player rolled 17")

  String type; // The type of log ("dice" or "combat")

  @Property(type: PropertyType.date)
  DateTime timestamp; // When the log entry was created

  // Relationship to the Game entity (each log belongs to one game)
  final game = ToOne<Game>();

  GameLogs({
    required this.message,
    required this.timestamp,
    required this.type,
    this.id = 0,
  });
}
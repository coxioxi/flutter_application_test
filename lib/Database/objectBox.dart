import 'data_model.dart';
import 'objectbox.g.dart';

/// The [Objectbox] class encapsulates the setup and usage of the ObjectBox database,
/// providing methods for adding and retrieving [DM], [Game], and [GameLogs] entities.
class Objectbox {
  /// The main ObjectBox [Store] used to access and manage the database.
  late final Store store;

  /// A [Box] for interacting with [DM] entities in the database.
  late final Box<DM> dmBox;

  /// A [Box] for interacting with [Game] entities in the database.
  late final Box<Game> gameBox;

  /// A [Box] for interacting with [GameLogs] entities in the database.
  late final Box<GameLogs> gameLogsBox;

  /// Private constructor that initializes the store and entity boxes.
  Objectbox._create(this.store) {
    dmBox = Box<DM>(store);
    gameBox = Box<Game>(store);
    gameLogsBox = Box<GameLogs>(store);
  }

  /// Asynchronously creates and returns an [Objectbox] instance with the store initialized.
  static Future<Objectbox> create() async {
    final store = await openStore();
    return Objectbox._create(store);
  }

  /// Adds a new [Game] associated with the given [DM].
  ///
  /// Returns the ID of the inserted game.
  int addGame(String gameName, DateTime date, DM dm) {
    Game newGame = Game(name: gameName, createdAt: date);
    newGame.dm.target = dm;
    return gameBox.put(newGame);
  }

  void removeGame(Game game) {
    gameBox.remove(game.id);
  }

  /// Adds a new [DM] (Dungeon Master) with the specified name and Firebase UID.
  ///
  /// Returns the ID of the inserted DM.
  int addDm(String dmName, String uid) {
    DM newDm = DM(name: dmName, firebaseUid: uid);
    return dmBox.put(newDm);
  }

  DM? getDm(String uid) {
    final query = dmBox.query(DM_.firebaseUid.equals(uid)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  /// Adds a new [GameLogs] entry to the specified [Game], with the given message and type.
  ///
  /// The [type] must be either `"dice"` or `"combat"`.
  /// Returns the ID of the inserted log entry.
  int addLog(String message, String type, Game game) {
    GameLogs newLog = GameLogs(
      message: message,
      timestamp: DateTime.now(),
      type: type,
    );
    newLog.game.target = game;
    return gameLogsBox.put(newLog);
  }

  /// Retrieves a live stream of all [Game]s associated with a given [DM].
  ///
  /// This stream updates in real-time whenever the underlying data changes.
  Stream<List<Game>> getGames(DM dm) {
    final query = gameBox.query(Game_.dm.equals(dm.id));
    return query.watch(triggerImmediately: true).map((query) => query.find());
  }

  /// Retrieves a live stream of [GameLogs] of the specified [type] (`"dice"` or `"combat"`)
  /// for the given [Game], sorted by timestamp in descending order (latest first).
  ///
  /// Throws an [Exception] if the [type] is invalid.
  Stream<List<GameLogs>> getLogs(String type, Game game) {
    if (!(type.contains('dice') || type.contains('combat'))) {
      throw Exception("$type is not valid!");
    }

    final query = gameLogsBox
        .query(GameLogs_.game.equals(game.id).and(GameLogs_.type.equals(type)),)
        .order(GameLogs_.timestamp, flags: Order.descending);

    return query.watch(triggerImmediately: true).map((query) => query.find());
  }
}

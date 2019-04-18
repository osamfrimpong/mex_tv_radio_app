import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mextv_app/models/carousel_image.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String imagesTable = "images_table";
  String colUrl = "url";
  String colId = "id";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "images.db";

    var imagesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return imagesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $imagesTable($colUrl TEXT, $colId INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getImagesMapList() async {
    Database db = await this.database;
    var result = await db.query(imagesTable);
    return result;
  }

  Future<int> insertImage(CarouselImage image) async {
    Database db = await this.database;
    var result = await db.insert(imagesTable, image.toMap());
    return result;
  }

  Future<int> updateImage(CarouselImage image) async {
    Database db = await this.database;
    var result = await db.update(imagesTable, image.toMap(),
        where: '$colId = ?', whereArgs: [image.id]);
    return result;
  }
}

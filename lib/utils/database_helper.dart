import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:wapnet/models/item.dart';

class DatabaseHelper {

	static DatabaseHelper? _databaseHelper;    // Singleton DatabaseHelper
	static Database? _database;                // Singleton Database

	String itemTable = 'item_table';
	String colId = 'id';
	String colTitle = 'title';
	String colImagePath = 'imagePath';
	String colFav = 'fav';


	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper!;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database!;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'items.db';

		// Open/create the database at a given path
		var itemsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return itemsDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $itemTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colImagePath STRING, $colFav BOOLEAN)');
	}

	Future<List<Map<String, dynamic>>> getItemMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(itemTable);
		return result;
	}

	Future<int> insertItem(Item item) async {
		Database db = await this.database;
		var result = await db.insert(itemTable, item.toMap());
		return result;
	}

	Future<int> updateItem(Item item) async {
		var db = await this.database;
		var result = await db.update(itemTable, item.toMap(), where: '$colId = ?', whereArgs: [item.id]);
		return result;
	}

	Future<int> deleteItem(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $itemTable WHERE $colId = $id');
		return result;
	}

	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $itemTable');
		int result = Sqflite.firstIntValue(x)!;
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Item>> getItemList() async {

		var itemMapList = await getItemMapList(); // Get 'Map List' from database
		int count = itemMapList.length;         // Count the number of map entries in db table

		List<Item> itemList = <Item>[];
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			itemList.add(Item.fromMapObject(itemMapList[i]));
		}

		return itemList;
	}

}








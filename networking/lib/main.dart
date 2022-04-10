import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // open database &create dogs table
  final database =
      await openDatabase(join(await getDatabasesPath(), 'doggie_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY,name TEXT,age INTEGER)');
  }, version: 1);

  // insert function
  Future<void> insertDog(Dog dog) async {
    final db = await database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // read data from db
  Future<List<Dog>> dogs() async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(
        maps.length,
        (index) => Dog(
            id: maps[index]['id'],
            name: maps[index]['name'],
            age: maps[index]['age']));
  }

  //update
  Future<void> updateDb(Dog dog) async {
    final db = await database;
    await db.update('dogs', dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
  }

  //delete
  Future<void> deleteFromDb(int id) async {
    final db = await database;

    await db.delete('dogs', where: 'id= ?', whereArgs: [id]);
  }

  Dog f = Dog(id: 1, name: 'kjfjg', age: 33);
  Dog f1 = Dog(id: 2, name: 'kjfj', age: 23);
  await insertDog(f);
  await deleteFromDb(0);
  await updateDb(f1);
  print(await dogs());
}

class Dog {
  final int? id;
  final String? name;
  final int? age;
  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Dog{id:$id ,name:$name ,age:$age}';
  }
}

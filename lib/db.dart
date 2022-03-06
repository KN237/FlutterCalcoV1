import 'package:sqflite/sqflite.dart';
import 'operation.dart';

class DB {
  Future<void> insertOperation(OperationModel O, Database? db) async {
    await db!.insert('operations', O.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<OperationModel>> Operations(Database? db) async {
    final List<Map<String, dynamic>> maps = await db!.query('operations');
    return List.generate(maps.length, (i) {
      return OperationModel(
          id: maps[i]['id'].toString(),
          result: maps[i]['result'],
          operation: maps[i]['operation'],
          date: maps[i]['date']);
    });
  }

  Future<void> deleteAll(Database? db) async {
    await db!.rawQuery("DELETE FROM operations");
  }
}

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/usuario.dart'; // Verifique se o caminho está correto

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('local_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(
      join(await getDatabasesPath(), filePath),
      version: 1,
      onCreate: (db, version) {
        return Future.wait([
          db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, nameUser TEXT, email TEXT, password TEXT)',
          ),
          db.execute(
            'CREATE TABLE current_user(id INTEGER PRIMARY KEY, user_id INTEGER)',
          ),
        ]);
      },
    );
  }

  Future<void> insertUser(User user) async {
    final db = await instance.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> fetchUsers() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int?> getLoggedInUserId() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'current_user',
      where: 'id = ?',
      whereArgs: [1], // Assuming only one logged-in user
    );

    if (result.isNotEmpty) {
      return result.first['user_id'] as int?;
    }
    return null; // No user found
  }

  Future<void> saveLoggedInUserId(int userId) async {
    final db = await instance.database;
    await db.insert(
      'current_user',
      {'id': 1, 'user_id': userId}, // Assuming a single logged-in user
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> buscarUsuario(String email, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null; // No user found
  }

  Future<void> updateUser(User user) async {
    final db = await instance.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await instance.database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<User?> buscarUsuarioPorId(int userId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> sincronizarUsuarios() async {
    try {
      final response = await http
          .get(Uri.parse('https://dmega.com.br/api_flutter/sync_users.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          final List<dynamic> usersData = jsonResponse['data'];
          final db = await instance.database;

          // Limpa a tabela de usuários locais antes de sincronizar
          await db.delete('users');

          for (var item in usersData) {
            if (item is Map<String, dynamic>) {
              print('Inserting user: $item');
              final user = User.fromMap(item);
              await insertUser(user);
            }
          }
        } else {
          print('Error in response: ${jsonResponse['message']}');
          throw Exception(
              'Error during synchronization: ${jsonResponse['message']}');
        }
      } else {
        print(
            'Erro ao sincronizar usuários: ${response.statusCode}, ${response.body}');
        throw Exception('Erro ao sincronizar usuários: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during synchronization: $e');
    }
  }
}


import 'dart:developer';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
class GloablVal {
  static int User = 0;


 


}
class DatabaseHelper {
static Future<Database> initializeDB() async {
  String path = await getDatabasesPath();

  return openDatabase(join(path, 'HRMSDatabase.db'), version: 1,
      onCreate: (database, version) async {
  await database.execute(
  "CREATE TABLE IF NOT EXISTS IPAddressInfo(id INTEGER PRIMARY KEY DEFAULT 1, "
  "IP TEXT DEFAULT '', empNo TEXT DEFAULT 'null', Lan TEXT DEFAULT 'EN', password TEXT DEFAULT '',name TEXT DEFAULT 'null',tempname TEXT DEFAULT 'null')"
);
  });
}

static Future<String> getIP() async {
  final db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query(
    'IPAddressInfo',
    where: 'id = ?',
    whereArgs: [1],
  );
  if (maps.isNotEmpty) {
    return maps.first['IP'];
  }
  return '';
}

static Future<void> updateIP(String ip) async {
  if(ip.isNotEmpty && !ip.startsWith("http://") && !ip.startsWith("https://")) {
        ip = "http://$ip";
      } else{
        ip = ip;
      }
  final db = await initializeDB();
  int rowsUpdated = await db.update(
    'IPAddressInfo',
    {'IP': ip},
    where: 'id = ?',
    whereArgs: [1],
  );
    //  log("IP $ip", name: 'DatabaseHelper');

  if (rowsUpdated == 0) {
    // No row was updated, so insert a new row
    await db.insert(
      'IPAddressInfo',
      {'id': 1, 'IP': ip},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //log("IP $ip", name: 'DatabaseHelper');
  }
}

static Future<void> updateEmpNo(String empNo) async {
  final db = await initializeDB();
  int rowsUpdated = await db.update(
    'IPAddressInfo',
    {'empNo': empNo},
    where: 'id = ?',
    whereArgs: [1],
  );
  if (rowsUpdated == 0) {
    await db.insert(
      'IPAddressInfo',
      {'id': 1, 'empNo': empNo},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //log("empNo $empNo", name: 'DatabaseHelper');
  }
}

static Future<void> updatename(String empNo) async {
  final db = await initializeDB();
  int rowsUpdated = await db.update(
    'IPAddressInfo',
    {'name': empNo},
    where: 'id = ?',
    whereArgs: [1],
  );
  if (rowsUpdated == 0) {
    await db.insert(
      'IPAddressInfo',
      {'id': 1, 'empNo': empNo},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  //  log("name $empNo", name: 'DatabaseHelper');
  }
}

static Future<void> updatetempname(String empNo) async {
  final db = await initializeDB();
  await db.update(
    'IPAddressInfo',
    {'tempname': empNo},
    where: 'id = ?',
    whereArgs: [1],
  );
}

static Future<void> updatePassword(String password) async {
  final db = await initializeDB();
  int rowsUpdated = await db.update(
    'IPAddressInfo',
    {'password': password},
    where: 'id = ?',
    whereArgs: [1],
  );
  if (rowsUpdated == 0) {
    await db.insert(
      'IPAddressInfo',
      {'id': 1, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
   // log("Password $password", name: 'DatabaseHelper');
  }
}

static Future<void> updateLang(String lang) async {
  final db = await initializeDB();
  int rowsUpdated = await db.update(
    'IPAddressInfo',
    {'Lan': lang},
    where: 'id = ?',
    whereArgs: [1],
  );
     // log("Lang1111 $lang", name: 'DatabaseHelper');

  if (rowsUpdated == 0) {
    await db.insert(
      'IPAddressInfo',
      {'id': 1, 'Lan': lang},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //log("Lang $lang", name: 'DatabaseHelper');
  }
}

static Future<String> getEmpNo() async {
  final db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query(
    'IPAddressInfo',
    where: 'id = ?',
    whereArgs: [1],
  );
  if (maps.isNotEmpty) {
    return maps.first['empNo'];
  }
  return '';
}

static Future<String> getName() async {
  final db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query(
    'IPAddressInfo',
    where: 'id = ?',
    whereArgs: [1],
  );
  if (maps.isNotEmpty) {
    return maps.first['name'];
  }
  return '';
}

static Future<String> gettempName() async {
  final db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query(
    'IPAddressInfo',
    where: 'id = ?',
    whereArgs: [1],
  );
  if (maps.isNotEmpty) {
    return maps.first['tempname'];
  }
  return '';
}

static Future<String> getPassword() async {
  final db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query(
    'IPAddressInfo',
    where: 'id = ?',
    whereArgs: [1],
  );
  if (maps.isNotEmpty) {
    return maps.first['password'];
  }
  return '';
}

static Future<String> getLang() async {
  final db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query(
    'IPAddressInfo',
    where: 'id = ?',
    whereArgs: [1],
  );

  if (maps.isNotEmpty) {
   // log(maps.first['Lan'] , name: 'DatabaseHelperLang');
    return maps.first['Lan'];
  }
  return '';
}
}


// class GloablVal {
//   static int User =0;

//   static Future<bool> saveIP(String IPSTATIC)async{

//     final SharedPreferences sp = await await GloablVal.prefs!;
//     sp.setString('IPSTATIC', IPSTATIC.toString());


//     return true ;
//   }

//   static String? _ip;

//   static Future<void> initialize() async {
//     final SharedPreferences sp = await await GloablVal.prefs!;
//     _ip = sp.getString('IPSTATIC');
//   }

//   static String getIP() {
//     return _ip ?? ""; // Return a default value if _ip is null
//   }
// }
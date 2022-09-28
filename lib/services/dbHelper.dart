
import 'package:gulferp/model/registrationModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GulfErpDB {
  static final GulfErpDB instance = GulfErpDB._init();
  static Database? _database;
  GulfErpDB._init();
  //////////////////////////////////////

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("gulfErp.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(
      path,
      version: 1, onCreate: _createDB,
      // onUpgrade: _upgradeDB
    );
  }

  Future _createDB(Database db, int version) async {
    ///////////////barcode store table ////////////////

    await db.execute('''
          CREATE TABLE companyRegistrationTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cid TEXT NOT NULL,
            fp TEXT NOT NULL,
            os TEXT NOT NULL,
            type TEXT,
            app_type TEXT,
            cpre TEXT,
            ctype TEXT,
            cnme TEXT,
            ad1 TEXT,
            ad2 TEXT,
            ad3 TEXT,
            pcode TEXT,
            land TEXT,
            mob TEXT,
            em TEXT,
            gst TEXT,
            ccode TEXT,
            scode TEXT,
            msg TEXT
          )
          ''');
//     //////////////////////////////////////////////////////////
//     await db.execute('''
//           CREATE TABLE barcode (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             barcode TEXT,
//             ean TEXT ,
//             product TEXT ,
//             rate REAL
//           )
//           ''');
// ////////////// registration table ////////////
    await db.execute('''
          CREATE TABLE staffDetailsTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sid TEXT NOT NULL,
            sname TEXT,
            uname TEXT,
            pwd TEXT,
            ad1 TEXT,
            ad2 TEXT,
            ad3 TEXT,
            ph TEXT,
            area TEXT    
          )
          ''');
    await db.execute('''
          CREATE TABLE settingsTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            set_id INTEGER NOT NULL,
            set_code TEXT,
            set_value TEXT,
            set_type INTEGER  
          )
          ''');
    // await db.execute('''
    //       CREATE TABLE bagTable (
    //         id INTEGER PRIMARY KEY AUTOINCREMENT,
    //         itemName TEXT NOT NULL,
    //         cartdate TEXT,
    //         carttime TEXT,
    //         srate1 REAL,
    //         srate2 REAL,
    //         cartrowno INTEGER,
    //         batchcode TEXT,
    //         img TEXT,
    //         catid TEXT,
    //         totalamount TEXT,  
    //       )
    //       ''');
  }

/////////////////////////////////////////////////////////////////////////
  Future insertRegistrationDetails(RegistrationData data) async {
    final db = await database;
    var query1 =
        'INSERT INTO companyRegistrationTable(cid, fp, os, type, app_type, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, msg) VALUES("${data.cid}", "${data.fp}", "${data.os}","${data.type}","${data.apptype}","${data.c_d![0].cpre}", "${data.c_d![0].ctype}", "${data.c_d![0].cnme}", "${data.c_d![0].ad1}", "${data.c_d![0].ad2}", "${data.c_d![0].ad3}", "${data.c_d![0].pcode}", "${data.c_d![0].land}", "${data.c_d![0].mob}", "${data.c_d![0].em}", "${data.c_d![0].gst}", "${data.c_d![0].ccode}", "${data.c_d![0].scode}", "${data.msg}" )';
    var res = await db.rawInsert(query1);
    print(query1);
    print("registered ----$res");
    return res;
  }

////////////////////////////////////////////////////////////////////////
  // Future insertsettingsTable(SettingsModel model) async {
  //   final db = await database;
  //   // deleteFromTableCommonQuery('menuTable', "");
  //   var query1 =
  //       'INSERT INTO settingsTable(set_id,set_code,set_value,set_type) VALUES(${model.setId},"${model.setCode}","${model.setValue}",${model.setType})';
  //   var res = await db.rawInsert(query1);
  //   // print("menu----${query1}");
  //   print("settingzz---${query1}");
  //   // print(res);
  //   return res;
  // }

  // //////////////////////////////////////////////////////////////
  // Future insertStaffDetails(StaffDetails sdata) async {
  //   final db = await database;
  //   var query2 =
  //       'INSERT INTO staffDetailsTable(sid, sname, uname, pwd, ad1, ad2, ad3, ph, area) VALUES("${sdata.sid}", "${sdata.sname}", "${sdata.unme}", "${sdata.pwd}", "${sdata.ad1}", "${sdata.ad2}", "${sdata.ad3}", "${sdata.ph}", "${sdata.area}")';
  //   var res = await db.rawInsert(query2);
  //   print(query2);
  //   // print(res);
  //   return res;
  // }

  //////////////////////////////////////////////////////////////////////////////
  // Future insertBagTable(
  //   String itemName,
  //   String cartdate,
  //   String carttime,
  //   String os,
  //   String customerid,
  //   int cartrowno,
  //   String code,
  //   int qty,
  //   String rate,
  //   String totalamount,
  //   int cstatus,
  // ) async {
  //   print("qty--$qty");
  //   print("code...........$code");
  //   final db = await database;
  //   var res;
  //   var query3;
  //   var query2;
  //   List<Map<String, dynamic>> res1 = await db.rawQuery(
  //       'SELECT  * FROM bagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
  //   print("SELECT from ---$res1");
  //   if (res1.length == 1) {
  //     int qty1 = res1[0]["qty"];
  //     int updatedQty = qty1 + qty;
  //     double amount = double.parse(res1[0]["totalamount"]);
  //     print("res1.length----${res1.length}");

  //     print("upadted qty-----$updatedQty");
  //     double amount1 = double.parse(totalamount);
  //     double updatedAmount = amount + amount1;
  //     var res = await db.rawUpdate(
  //         'UPDATE orderBagTable SET qty=$updatedQty , totalamount="${updatedAmount}" WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
  //     print("response-------$res");
  //   } else {
  //     query2 =
  //         'INSERT INTO orderBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate, totalamount, cstatus) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}", $cstatus)';
  //     var res = await db.rawInsert(query2);
  //   }

  //   print("insert query result $res");
  //   print("insert-----$query2");
  //   return res;
  // }

////////////////////////////////////////////////////////////////////////////////
  deleteFromTableCommonQuery(String table, String? condition) async {
    print("table--condition -$table---$condition");
    Database db = await instance.database;
    if (condition == null || condition.isEmpty || condition == "") {
      print("no condition");
      await db.delete('$table');
    } else {
      print("condition");

      await db.rawDelete('DELETE FROM "$table" WHERE $condition');
    }
  }

////////////////////////////////////////////////////////////////////////////////
  selectStaff(String uname, String pwd) async {
    String result = "";
    List<String> resultList = [];
    String? sid;
    print("uname---Password----${uname}--${pwd}");
    resultList.clear();
    print("before kkkk $resultList");
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM staffDetailsTable');
    for (var staff in list) {
      // print(
      //     "staff['uname'] & staff['pwd']------------------${staff['uname']}--${staff['pwd']}");
      if (uname.toLowerCase() == staff["uname"].toLowerCase() &&
          pwd == staff["pwd"]) {
        print("match");
        sid = staff['sid'];
        result = "success";
        print("staffid..$sid");
        print("ok");
        resultList.add(result);
        resultList.add(sid!);
        break;
      } else {
        print("No match");
        result = "failed";
        sid = "";
        // resultList.add(result);
        // resultList.add(sid);
      }
    }
    print("res===${resultList}");

    print("all data ${list}");

    return resultList;
  }
}

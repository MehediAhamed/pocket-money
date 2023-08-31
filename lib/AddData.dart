import 'package:flutter/services.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class AddData {
  static const String tableNameExpense = 'exp2';
  static const String tableNameIncome = 'in2';
  static const String tableNameBudget = 'bd2';
  static const String tableNameCategory = 'cat3';

  static const String dbNameExpense = 'exp2.db';
  static const String dbNameIncome = 'in2.db';
  static const String dbNameBudget = 'bd2.db';
  static const String dbNameCategory = 'cat3.db';

  Future<Database> _openDBCategory() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath!, dbNameCategory);

    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE $tableNameCategory ('
          'text TEXT PRIMARY KEY)');
    });
  }

  Future<Database> _openDBExpense() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath!, dbNameExpense);

    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE $tableNameExpense ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'Type TEXT, '
          'Category TEXT, '
          'Amount NUMERIC, '
          'Remark TEXT, '
          'Month TEXT, '
          'Year TEXT, '
          'Date TEXT)');
    });
  }

  // Future<Database> _openDBIncome() async {
  //   final databasesPath = await getDatabasesPath();
  //   final path = join(databasesPath!, dbNameIncome);
  //
  //   return openDatabase(path, version: 1, onCreate: (db, version) {
  //     db.execute('CREATE TABLE $tableNameIncome ('
  //         'id INTEGER PRIMARY KEY AUTOINCREMENT, '
  //         'Category TEXT, '
  //         'Amount TEXT, '
  //         'Remark TEXT, '
  //         'Month TEXT, '
  //         'Year TEXT, '
  //         'Date TEXT)');
  //   });
  // }

  Future<Database> _openDBBudget() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath!, dbNameBudget);

    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE $tableNameBudget ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'Amount NUMERIC, '
          'Month TEXT, '
          'Year TEXT)');
    });
  }

  Future<void> insertCategoryData(String text) async {
    final db = await _openDBCategory();
    await db.insert(tableNameCategory, {
      'text': text,
    });
  }

  Future<void> storeDataExpense(String Type,String Category, double Amount, String Remark,
      String Month, String Year, String Date) async {
    final db = await _openDBExpense();
    await db.insert(tableNameExpense, {
      'Type': Type,
      'Category': Category,
      'Amount': Amount,
      'Remark': Remark,
      'Month': Month,
      'Year': Year,
      'Date': Date,
    });
  }

  Future<void> storeDataBudget(double Amount, String Month, String Year) async {
    final db = await _openDBBudget();
    await db.insert(tableNameBudget, {
      'Amount': Amount,
      'Month': Month,
      'Year': Year,
    });
  }

  // Future<void> storeDataIncome(String Category, String Amount, String Remark,
  //     String Month, String Year, String Date) async {
  //   final db = await _openDBExpense();
  //   await db.insert(tableNameIncome, {
  //     'Category': Category,
  //     'Amount': Amount,
  //     'Remark': Remark,
  //     'Month': Month,
  //     'Year': Year,
  //     'Date': Date,
  //   });
  // }

  Future<List<String>> retrieveCategoryData() async {
    final db = await _openDBCategory();

    final result = await db.query(tableNameCategory);
    final names = result.map((row) => row['text'] as String).toList();
    return names;
  }

  Future<List<Map<String, dynamic>>> retrieveDataExpense() async {
    final db = await _openDBExpense();
    return await db.query(tableNameExpense);
  }

  Future<List<Map<String, dynamic>>> getExpenseForMonth(
      String month, String year) async {
    final db = await _openDBExpense();

    // Query to retrieve all rows where the date is in January
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM $tableNameExpense WHERE Month = $month and Year= $year and Amount NOT IN(' ')");

    await db.close();

    return result;
  }

  // Future<List<Map<String, dynamic>>> retrieveDataIncome() async {
  //   final db = await _openDBIncome();
  //   return await db.query(tableNameIncome);
  // }

  Future<List<Map<String, dynamic>>> retrieveDataBudget() async {
    final db = await _openDBBudget();
    return await db.query(tableNameBudget);
  }
  //
  // Future<List<Map<String, dynamic>>> getIncomeForMonth(
  //     String month, String year) async {
  //   final db = await _openDBIncome();
  //
  //   // Query to retrieve all rows where the date is in January
  //   List<Map<String, dynamic>> result = await db.rawQuery(
  //       "SELECT * FROM $tableNameIncome WHERE Month = $month and Year= $year and Amount NOT IN(' ')");
  //
  //   await db.close();
  //
  //   return result;
  // }

  Future<int> lengthExpense() async {
    final dataList = await retrieveDataExpense();
    return dataList.length;
  }
  //
  // Future<int> lengthIncome(String month, String year) async {
  //   final dataList = await getIncomeForMonth(month, year);
  //   return dataList.length;
  // }

  Future<int> lengthCategory() async {
    final dataList = await retrieveCategoryData();
    return dataList.length;
  }

  Future<List<Map<String, dynamic>>> getBudgetForThisMonth (String month,String year) async {
    final db = await _openDBBudget();

    // Query to retrieve all rows where the date is in January
    dynamic result = await db.rawQuery(
        "SELECT Amount FROM $tableNameBudget WHERE Month = $month and Year= $year and Amount NOT IN(' ')");

    await db.close();

    return result;
  }

  Future<double> totalExpense(String month,String year) async {
    final db = await _openDBExpense();

    dynamic result = await db.rawQuery(
        "SELECT sum(Amount) FROM $tableNameExpense WHERE Month = $month and Year= $year and Amount NOT IN(' ') and Type='expense'");

    return result;
  }

  Future<double> totalIncome(String month,String year) async {
    final db = await _openDBExpense();

    dynamic result = await db.rawQuery(
        "SELECT sum(Amount) FROM $tableNameExpense WHERE Month = $month and Year= $year and Amount NOT IN(' ') and Type='income'");

    return result;
  }

  void printData() async {
    //final dataList = await retrieveData();
    final dataList = await getExpenseForMonth('6', '2023');

    print('Expense Data:');
    for (var data in dataList) {
      String category = data['Category'];
      String amount = data['Amount'];
      String remark = data['Remark'];
      String month = data['Month'];
      String date = data['Date'];

      print('Category: $category');
      print('Amount: $amount');
      print('Remark: $remark');
      print('Month: $month');
      print('Date: $date');
      int r = dataList.length;
      print('Length:  $r');
      print('------------------------');


    }
  }

  Future<void> printcategory() async {
    final dataList = await retrieveCategoryData();
    for (var data in dataList) {
      String text = data;

      // Use the retrieved image and text
    }
  }

  Future<void> deleteRecordExpense(int id) async {
    final db = await _openDBExpense();
    await db.delete(tableNameExpense, where: 'id = ?', whereArgs: [id]);
  }

  // Future<void> deleteRecordIncome(int id) async {
  //   final db = await _openDBIncome();
  //   await db.delete(tableNameIncome, where: 'id = ?', whereArgs: [id]);
  // }
}

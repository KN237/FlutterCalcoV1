import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:todo/db.dart';
import 'operation.dart';
import 'package:intl/intl.dart';

class Data extends ChangeNotifier {
  Data({this.db});
  String operation = "0";
  String result = "0";
  String? sign;
  Database? db;

  String getFormattedNumber(double nm) {
    var res;
    if (nm % 1 == 0) {
      res = nm.truncate();
    } else {
      res = nm.toString();
    }
    return res.toString();
  }

  addItemToOperation(String temp) {
    if (operation.substring(operation.length - 1, operation.length) != '=' &&
        operation.length < 20) {
      operation == '0' ? operation = temp : operation += temp;
    }
    notifyListeners();
  }

  deleteAllOperations() {
    operation = '0';
    result = '0';
    notifyListeners();
  }

  deleteLastOperation() {
    operation.length < 2
        ? operation = '0'
        : operation = operation.substring(0, operation.length - 1);
    notifyListeners();
  }

  square() {
    //x2
    var temp = double.parse(operation);
    temp = temp * temp;
    result = getFormattedNumber(temp);
    notifyListeners();
  }

  reverse() {
    //1/x
    var temp = double.parse(operation);
    temp = 1 / temp;
    result = getFormattedNumber(temp);
    if (result == "Infinity") {
      result = "Infini";
    }
    notifyListeners();
  }

  pourcent() {
    //%
    var temp = double.parse(operation);
    temp = temp / 100;
    result = getFormattedNumber(temp);
    if (result == "Infinity") {
      result = "Infini";
    }
    notifyListeners();
  }

  add() {
    //+
    if (!(operation.contains('x') ||
        operation.contains('+') ||
        operation.contains('-', 1) ||
        operation.contains('/') ||
        operation.contains('='))) {
      operation += '+';
      sign = '+';
    }
    notifyListeners();
  }

  sust() {
    //+
    if (!(operation.contains('x') ||
        operation.contains('+') ||
        operation.contains('-', 1) ||
        operation.contains('/') ||
        operation.contains('='))) {
      operation += '-';
      sign = '-';
    }
    notifyListeners();
  }

  mult() {
    //x
    if (!(operation.contains('x') ||
        operation.contains('+') ||
        operation.contains('-', 1) ||
        operation.contains('/') ||
        operation.contains('='))) {
      operation += 'x';
      sign = 'x';
    }
    notifyListeners();
  }

  div() {
    // /
    if (!(operation.contains('x') ||
        operation.contains('+') ||
        operation.contains('-', 1) ||
        operation.contains('/') ||
        operation.contains('='))) {
      operation += '/';
      sign = '/';
    }
    notifyListeners();
  }

  egal() {
    //=
    if ((operation.contains('x') ||
            operation.contains('+') ||
            operation.contains('-') ||
            operation.contains('/')) &&
        !operation.contains('=')) {
      operation += '=';

      if (sign == "+") {
        var signIndex = operation.indexOf("+");
        var temp1 = operation.substring(0, signIndex);
        var temp2 = operation.substring(signIndex + 1, operation.length - 1);
        var temp3 = double.parse(temp1) + double.parse(temp2);
        result = getFormattedNumber(temp3);
        DateTime d = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');

        DB().insertOperation(
            OperationModel(
                result: result,
                operation: operation,
                date: formatter.format(d).toString()),
            db);
      }

      if (sign == "x") {
        var signIndex = operation.indexOf("x");
        var temp1 = operation.substring(0, signIndex);
        var temp2 = operation.substring(signIndex + 1, operation.length - 1);
        var temp3 = double.parse(temp1) * double.parse(temp2);
        result = getFormattedNumber(temp3);
        DateTime d = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');

        DB().insertOperation(
            OperationModel(
                result: result,
                operation: operation,
                date: formatter.format(d).toString()),
            db);
      }

      if (sign == "-") {
        var signIndex = operation.indexOf("-");
        if (signIndex != 0) {
          var temp1 = operation.substring(0, signIndex);
          var temp2 = operation.substring(signIndex + 1, operation.length - 1);
          var temp3 = double.parse(temp1) - double.parse(temp2);
          result = getFormattedNumber(temp3);
        } else {
          var peration = operation.substring(1);
          signIndex = peration.indexOf("-");
          print(signIndex);
          print(peration);
          var temp1 = peration.substring(0, signIndex);
          print(temp1);
          var temp2 = peration.substring(signIndex + 1, peration.length - 1);
          print(temp2);
          var temp3 = -double.parse(temp1) - double.parse(temp2);
          print(temp3);
          result = getFormattedNumber(temp3);
        }

        DateTime d = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');

        DB().insertOperation(
            OperationModel(
                result: result,
                operation: operation,
                date: formatter.format(d).toString()),
            db);
      }

      if (sign == "/") {
        var signIndex = operation.indexOf("/");
        var temp1 = operation.substring(0, signIndex);
        var temp2 = operation.substring(signIndex + 1, operation.length - 1);
        var temp3 = double.parse(temp1) / double.parse(temp2);
        result = getFormattedNumber(temp3);
        if (result == "Infinity") {
          result = "Infini";
        }

        DateTime d = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');

        DB().insertOperation(
            OperationModel(
                result: result,
                operation: operation,
                date: formatter.format(d).toString()),
            db);
      }

      notifyListeners();
    }
  }

  numberSign() {
    //+/-
    if (operation.substring(0, 1) != '0') {
      operation.substring(0, 1) != '-'
          ? operation = '-' + operation
          : operation = operation.substring(1, operation.length);
    }
    notifyListeners();
  }

  point() {
    //.
    if (!operation.contains('.')) {
      operation += '.';
    }
    notifyListeners();
  }
}

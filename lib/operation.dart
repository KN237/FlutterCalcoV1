class OperationModel {
  OperationModel(
      {this.id,
      required this.result,
      required this.operation,
      required this.date});
  String? id;
  String result;
  String operation;
  String date;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'result': result,
      'operation': operation,
      'date': date,
    };
  }
}

class LogModel {
  int? id;
  int? itemId;
  int? borrowingId;
  int? returnId;
  Enum? status;

  LogModel({
    required this.id,
    required this.itemId,
    required this.borrowingId,
    required this.returnId,
    required this.status,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'] ?? '',
      itemId: json['item_id'] ?? '',
      borrowingId: json['borrowing_id'] ?? '',
      returnId: json['return_id'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

int? parseInt(dynamic value) {
  if (value == null) return null;
  return int.tryParse(value.toString());
}

class ItemRequest {
  int? id;
  int? borrower_id;
  int? item_id;
  String? reason;
  String? return_date;
  String? approval_status;
  String? ongoing_status;
  int? approved_by;

  //ItemRequest Model is basically the same as BorrowModel,
  //requestController is for sending the borrowRequest data to API
  //BorrowControoler is fro recieving the Borrowing data from API

  ItemRequest({
    this.id,
    required this.borrower_id,
    required this.item_id,
    required this.reason,
    required this.return_date,
    required this.approval_status,
    required this.ongoing_status,
    required this.approved_by,
  });

  factory ItemRequest.fromJson(Map<String, dynamic> json) {
    return ItemRequest(
      id: parseInt(json['id']),
      borrower_id: parseInt(json['borrower_id']),
      item_id: parseInt(json['item_id']),
      reason: json['reason'] ?? '',
      return_date: json['return_date'] ?? '',
      approval_status: json['approval_status'] ?? '',
      ongoing_status: json['ongoing_status'] ?? '',
      approved_by: parseInt(json['approved_by']),
    );
  }
}

class ItemRequest {
  int? borrower_id;
  int? item_id;
  String? reason;
  String? return_date;
  String? approval_status;
  int? approved_by;

  ItemRequest({
    required this.borrower_id,
    required this.item_id,
    required this.reason,
    required this.return_date,
    required this.approval_status,
    required this.approved_by,
  });
}

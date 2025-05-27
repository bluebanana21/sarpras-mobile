class ItemModel {
  int? id;
  String? name;
  String? image;
  String? description;
  String? assignedNum;
  int? itemTypeId;
  int? subcategoryId;
  String? status;

  ItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.assignedNum,
    required this.itemTypeId,
    required this.subcategoryId,
    required this.status,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image_url'] ?? '',
      description: json['description'] ?? '',
      assignedNum: json['assigned_num'] ?? '',
      itemTypeId: json['item_type_id'] ?? 0,
      subcategoryId: json['subcategory_id'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

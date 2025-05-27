import 'package:flutter/material.dart';
import 'package:sarpras_mobile/screens/ItemDetail.dart';

class ItemCard extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  final String assignedNum;
  final String status;
  final int itemTypeId;
  final int subCatId;
  final int id;

  const ItemCard({
    super.key,
    required this.name,
    required this.desc,
    required this.image,
    required this.assignedNum,
    required this.status,
    required this.itemTypeId,
    required this.subCatId,
    required this.id,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://127.0.0.1:8000/${widget.image}',
                height: 60,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          // Availability
          Row(
            children: [
              Icon(Icons.circle, color: Colors.green, size: 10),
              SizedBox(width: 4),
              Text(
                widget.status,
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(4), // Optional: adjust if needed
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 16,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ItemDetail(
                          name: widget.name,
                          desc: widget.desc,
                          image: widget.image,
                          assignedNum: widget.assignedNum,
                          status: widget.status,
                          itemTypeId: widget.itemTypeId,
                          subCatId: widget.subCatId,
                          id: widget.id,
                        );
                      },
                    ),
                  );
                },
                padding:
                    EdgeInsets.zero, // Prevent extra padding from IconButton
                constraints:
                    const BoxConstraints(), // Remove default constraints
              ),
            ),
          ),
        ],
      ),
    );
  }
}

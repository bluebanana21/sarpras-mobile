import 'package:flutter/material.dart';
import 'package:sarpras_mobile/screens/RequestItemForm.dart';

class ItemDetail extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  final String assignedNum;
  final String status;
  final int itemTypeId;
  final int subCatId;
  final int id;

  const ItemDetail({
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
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.red;
    if (widget.status.toLowerCase().contains("available")) {
      statusColor = Colors.green;
    } else if (widget.status.toLowerCase().contains("damaged")) {
      statusColor = Colors.red;
    } else if (widget.status.toLowerCase().contains("borrowed")) {
      statusColor = Colors.yellow;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFDEDEDE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF37A2E5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Text(
                    "Item Detail",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 20),

              Center(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'http://127.0.0.1:8000/${widget.image}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '#${widget.assignedNum}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ID: ${widget.id}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    widget.status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(widget.desc, style: const TextStyle(fontSize: 14)),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: CustomRequestButton(
                  itemId: widget.id,
                  itemStatus: widget.status,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRequestButton extends StatelessWidget {
  final int itemId;
  final String itemStatus;

  const CustomRequestButton({
    super.key,
    required this.itemId,
    required this.itemStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          if (itemStatus == 'available') {
            return SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B70C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RequestItemForm(borrowerId: 1, itemId: itemId);
                      },
                    ),
                  );
                },
                child: const Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else if (itemStatus == 'damaged' || itemStatus == 'borrowed') {
            return SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0004),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  print('cant borrow dude sorry');
                },
                child: const Text(
                  'Not Available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
            return const Text('Status unknown');
          }
        },
      ),
    );
  }
}

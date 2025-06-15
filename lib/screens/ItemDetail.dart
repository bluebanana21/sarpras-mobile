import 'package:flutter/material.dart';
import 'package:sarpras_mobile/controllers/borrowController.dart';
import 'package:sarpras_mobile/controllers/returnController.dart';
import 'package:sarpras_mobile/models/request.dart';
import 'package:sarpras_mobile/screens/RequestItemForm.dart';
import 'package:sarpras_mobile/models/user.dart';
import 'package:get/get.dart';

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
    print('id: ${widget.id}');
    print('name: ${widget.name}');
    print('desc: ${widget.desc}');
    print('image: ${widget.image}');
    print('assignedNum: ${widget.assignedNum}');
    print('status: ${widget.status}');
    print('itemTypeId: ${widget.itemTypeId}');
    print('subCatId: ${widget.subCatId}');

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
                  //widget is equal to item here
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

class CustomRequestButton extends StatefulWidget {
  final int itemId;
  final String itemStatus;

  CustomRequestButton({
    super.key,
    required this.itemId,
    required this.itemStatus,
  });
  @override
  State<CustomRequestButton> createState() => _CustomRequestButtonState();
}

class _CustomRequestButtonState extends State<CustomRequestButton> {
  final Returncontroller returnController = Get.put(Returncontroller());
  final User user = Get.find<User>();
  List<ItemRequest> _itemBorrows = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBorrowData();
  }

  Future<void> _fetchBorrowData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final borrows = await fetchBorrowsByItem(widget.itemId.toInt());

      setState(() {
        _itemBorrows = borrows;
      });
    } catch (e) {
      print('Error fetching borrow data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isBorrowedByCurrentUser() {
    return _itemBorrows.any((borrowsByItem) {
      if (borrowsByItem.borrower_id == user.id &&
          borrowsByItem.item_id == widget.itemId &&
          borrowsByItem.ongoing_status == 'ongoing') {
        return true;
      } else {
        print('borrower id: ${borrowsByItem.borrower_id}');
        print('user id: ${user.id}');
        return false;
      }
    });
  }

  bool _requestByUserAlreadySent() {
    return _itemBorrows.any((borrowsByItem) {
      return borrowsByItem.item_id == widget.itemId &&
          borrowsByItem.borrower_id == user.id &&
          borrowsByItem.approval_status!.toLowerCase() == "pending";
    });
  }

  int? getCurrentBorrowId() {
    int borrowId;
    try {
      final itemBorrows = _itemBorrows.firstWhere(
        (borrowsByItem) =>
            borrowsByItem.borrower_id == user.id &&
            borrowsByItem.item_id == widget.itemId &&
            borrowsByItem.ongoing_status == 'ongoing',
      );

      borrowId = itemBorrows.id!.toInt();

      return borrowId;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final borrowId = getCurrentBorrowId();
    if (borrowId != null) {
      returnController.borrowingId = borrowId;
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_requestByUserAlreadySent()) {
      return _buildRequestSentButton();
    } else if (widget.itemStatus.toLowerCase() == 'available') {
      return _buildRequestButton();
    } else if (_isBorrowedByCurrentUser()) {
      return _buildReturnButton();
    } else {
      return _buildNotAvailableButton();
    }
  }

  Widget _buildRequestButton() {
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
                return RequestItemForm(
                  borrowerId: user.id!.toInt(),
                  itemId: widget.itemId,
                );
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
  }

  Widget _buildRequestSentButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffbdbdbd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          print("Hey you, big star Tell me when it's over (cloud)");
        },
        child: const Text(
          'Request Sent',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildReturnButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff37a2e5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          print('Return item ${widget.itemId}');
          await returnController.submit(context);
        },
        child: const Text(
          'Return',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNotAvailableButton() {
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
          print('user id: ${user.id}');
          print(_isBorrowedByCurrentUser());
          print(widget.itemId);
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
  }
}

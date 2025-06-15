import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarpras_mobile/models/item.dart';
import 'package:sarpras_mobile/models/request.dart';
import 'package:sarpras_mobile/screens/ItemDetail.dart';

class Requestcontroller extends GetxController {
  late int borrowerId;
  late int itemId;
  TextEditingController reason = TextEditingController();
  String returnDate = DateTime.now().toIso8601String();

  final String _requestApi = 'http://127.0.0.1:8000/api/borrow/request';
  String _message = '';

  Future<void> submit(BuildContext context) async {
    final request = ItemRequest(
      borrower_id: borrowerId,
      item_id: itemId,
      reason: reason.text.trim(),
      return_date: returnDate,
      approval_status: 'pending',
      ongoing_status: null,
      approved_by: null,
    );

    print(
      'request data: borrowerid: ${request.borrower_id} , item_id: ${request.item_id} , reason: ${request.reason}, returnDate: ${request.return_date} , approval status: ${request.approval_status} , approvedBy: ${request.approved_by}',
    );

    final validated = validateRequest(request);

    if (validated) {
      final success = await sendRequest(request);
      await showMessage(
        context: context,
        title: success ? 'Request Successful' : 'Request Failed',
        message:
            success
                ? 'The item request was submitted successfully.'
                : 'Failed to send request. Please try again.',
      );
    } else {
      await showMessage(
        context: context,
        title: 'Validation Error',
        message: _message,
      );
    }
  }

  bool validateRequest(ItemRequest request) {
    if (request.reason.toString().isEmpty) {
      _message = 'Reason cannot be empty!';
      return false;
    }
    if (request.return_date == null) {
      _message = 'Return date must be selected!';
      return false;
    }
    return true;
  }

  Future<bool> sendRequest(ItemRequest request) async {
    try {
      final dio = Dio();
      final data = {
        'borrower_id': request.borrower_id,
        'item_id': request.item_id,
        'reason': request.reason,
        'return_date': request.return_date.toString(),
        'approval_status': request.approval_status,
        'approved_by': request.approved_by,
      };

      final response = await dio.post(_requestApi, data: data);
      print(response.data);
      return response.statusCode == 201;
    } catch (e) {
      //print(response.data);
      print('Error sending request: $e');
      return false;
    }
  }

  Future<void> showMessage({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder:
          (dialogContext) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }
}

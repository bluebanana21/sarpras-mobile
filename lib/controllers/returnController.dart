import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sarpras_mobile/models/itemReturns.dart';

class Returncontroller extends GetxController {
  late int borrowingId;
  late String returnStatus;

  final String _returnApi = 'http://127.0.0.1:8000/api/returns/request';
  String _message = '';

  Future<void> submit(BuildContext context) async {
    final request = Itemreturns(
      borrowing_id: borrowingId,
      return_status: "unconfirmed",
    );

    print(
      'return data: borrowing_id: ${request.borrowing_id} , return_status: ${request.return_status}',
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

  bool validateRequest(Itemreturns request) {
    if (request.borrowing_id.toString().isEmpty) {
      _message = 'Something went wrong!';
      return false;
    }
    return true;
  }

  Future<bool> sendRequest(Itemreturns request) async {
    try {
      final dio = Dio();
      final data = {
        'borrowing_id': request.borrowing_id!.toInt(),
        'return_status': request.return_status,
      };

      try {
        final response = await dio.post(_returnApi, data: data);
        print(response.data);
        return response.statusCode == 201;
      } on DioException catch (e) {
        if (e.response?.statusCode == 500) {
          print('internal server error bitch: $e');
          return false;
        } else {
          print('Rquest failed');
          return false;
        }
      }
    } catch (e) {
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

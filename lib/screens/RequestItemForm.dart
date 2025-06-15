import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:sarpras_mobile/controllers/requestController.dart';

class RequestItemForm extends StatefulWidget {
  final int borrowerId;
  final int itemId;

  const RequestItemForm({
    super.key,
    required this.borrowerId,
    required this.itemId,
  });

  @override
  State<RequestItemForm> createState() => _RequestItemForm();
}

class _RequestItemForm extends State<RequestItemForm> {
  final Requestcontroller controller = Get.put(Requestcontroller());

  DateTime returnDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller.borrowerId = widget.borrowerId;
    controller.itemId = widget.itemId;
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF37A2E5),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const Text(
                    'Item Request Form',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 40), // Spacer
                ],
              ),
              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Reason'),
              ),
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  controller: controller.reason,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Enter your reason...',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Date of Return'),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        DateTime.now().hour,
                        DateTime.now().minute,
                      ),
                      maxTime: DateTime(2100, 1, 1),
                      onChanged: (date) {
                        setState(() {
                          returnDate = date;
                        });
                        print('change $date');
                      },
                      onConfirm: (date) {
                        setState(() {
                          returnDate = date;
                        });
                        print('confirm $date');
                      },
                      currentTime: returnDate,

                      locale: LocaleType.en,
                    );
                    String returnDateForm = returnDate.toIso8601String();
                    controller.returnDate = returnDateForm;
                  },
                  child: Text("Date here $returnDate"),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B70C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await controller.submit(context);
                  },
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

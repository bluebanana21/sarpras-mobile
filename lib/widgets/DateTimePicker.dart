import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerExample extends StatefulWidget {
  const DateTimePickerExample({super.key});

  @override
  State<DateTimePickerExample> createState() => _DateTimePickerExampleState();
}

class _DateTimePickerExampleState extends State<DateTimePickerExample> {
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
    );

    if (time == null) return;

    final DateTime combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _selectedDateTime = combined;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDateTime =
        _selectedDateTime != null
            ? DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!)
            : 'No date and time selected';

    return Scaffold(
      appBar: AppBar(title: const Text('Date & Time Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formattedDateTime),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickDateTime(context),
              child: const Text('Pick Date and Time'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sarpras_mobile/models/log.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<LogModel> _logs = [];

  bool _logIsLoading = false;
  String _logResponseMessage = 'fetcthing logs';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Text('test')));
  }
}

import 'package:flutter/material.dart';
import '../models/help.dart';

class HelpProvider with ChangeNotifier {
  final List<Help> _infoHelps = [
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
    Help(
      title: 'Ganti Password',
      detail:
          'loreeiwfbewebwufibewifubewfiewbfeiuwbfewiufbewibfewifubewifbewfi',
    ),
  ];

  List<Help> get infoHelps {
    return [..._infoHelps];
  }
}

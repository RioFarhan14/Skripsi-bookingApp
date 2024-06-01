import 'package:flutter/material.dart';
import '../models/field.dart';

class FieldProvider with ChangeNotifier {
  final List<Field> _fields = [
    Field(
        id: 1,
        name: 'Lapangan A',
        price: 110000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ullamcorper consectetur neque, a feugiat velit malesuada et. Donec gravida ex in arcu bibendum, eu commodo purus rhoncus. Sed lacinia vehicula mi, ac dignissim turpis. Vivamus sed nisi libero. Nullam et mauris eu ante gravida bibendum. Sed nec eleifend risus. Nam posuere felis id vehicula eleifend.'),
    Field(
        id: 2,
        name: 'Lapangan B',
        price: 120000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ullamcorper consectetur neque, a feugiat velit malesuada et. Donec gravida ex in arcu bibendum, eu commodo purus rhoncus. Sed lacinia vehicula mi, ac dignissim turpis. Vivamus sed nisi libero. Nullam et mauris eu ante gravida bibendum. Sed nec eleifend risus. Nam posuere felis id vehicula eleifend.'),
    Field(
        id: 3,
        name: 'Lapangan C',
        price: 130000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ullamcorper consectetur neque, a feugiat velit malesuada et. Donec gravida ex in arcu bibendum, eu commodo purus rhoncus. Sed lacinia vehicula mi, ac dignissim turpis. Vivamus sed nisi libero. Nullam et mauris eu ante gravida bibendum. Sed nec eleifend risus. Nam posuere felis id vehicula eleifend.'),
  ];

  List<Field> get fields {
    return [..._fields];
  }
}

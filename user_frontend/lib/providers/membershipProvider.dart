import 'package:flutter/material.dart';
import '../models/membership.dart';

class MembershipProvider with ChangeNotifier {
  final List<Membership> _memberships = [
    Membership(
        id: 1,
        name: '1 Bulan',
        price: 100000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020'),
    Membership(
        id: 2,
        name: '3 Bulan',
        price: 250000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020'),
  ];

  List<Membership> get memberships {
    return [..._memberships];
  }
}

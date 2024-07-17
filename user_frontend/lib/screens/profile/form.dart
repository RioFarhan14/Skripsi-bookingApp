import 'package:flutter/material.dart';
import 'package:user_frontend/utils/customAppBar.dart';

class FormEditProfile extends StatelessWidget {
  const FormEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Menghindari perubahan tata letak saat keyboard muncul
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: CustomAppBar(title: 'Edit $data'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Field {
  final String nameField;
  final int price;
  final String image;

  Field({
    required this.nameField,
    required this.price,
    required this.image,
  });
}

class BookingFieldPage extends StatelessWidget {
  BookingFieldPage({super.key});
  final List<Field> fields = [
    Field(
        nameField: 'Lapangan A',
        price: 110000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020'),
    Field(
        nameField: 'Lapangan B',
        price: 120000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020'),
    Field(
        nameField: 'Lapangan C',
        price: 130000,
        image:
            'https://lh3.googleusercontent.com/p/AF1QipOo4N0B2Y9zmSY8Wiun0DbN8SNDRJV15_Q5dcp5=s1360-w1360-h1020'),
  ];
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.16,
          leading: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ), // Warna border bulatan
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
                onTap: () {
                  Navigator.pop(context); // Kembali ke menu sebelumnya
                },
              ),
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Text(
            'Pilih Lapangan',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
          child: SizedBox(
        width: sizeWidth * 0.8,
        child: ListView.builder(
          itemCount: fields.length, // Perbaiki properti itemCount
          itemBuilder: (context, index) {
            // Gunakan fungsi yang sesuai untuk itemBuilder
            final field = fields[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detailBook');
              },
              child: Container(
                height: sizeHeight * 0.3,
                margin: EdgeInsets.all(sizeWidth * 0.05),
                padding: EdgeInsets.all(sizeWidth * 0.02),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(sizeWidth * 0.05),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(sizeWidth * 0.02),
                      child: Image.network(
                        field.image, // Gunakan URL gambar dari objek Field
                        width: sizeWidth * 0.78,
                        height: sizeHeight * 0.18,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: sizeHeight * 0.01),
                    Container(
                      margin: EdgeInsets.all(sizeWidth * 0.01),
                      child: Column(
                        children: [
                          Text(
                            field
                                .nameField, // Gunakan nama lapangan dari objek Field
                            style: TextStyle(fontSize: sizeWidth * 0.06),
                          ),
                          SizedBox(height: sizeHeight * 0.005),
                          Text.rich(
                            TextSpan(
                              text: 'Rp.${field.price},- ',
                              style: TextStyle(fontSize: sizeWidth * 0.04),
                              children: [
                                TextSpan(
                                  text: '/ Jam',
                                  style: TextStyle(fontSize: sizeWidth * 0.025),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}

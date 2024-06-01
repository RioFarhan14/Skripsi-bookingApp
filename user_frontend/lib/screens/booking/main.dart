import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/fieldProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/theme.dart';

class BookingFieldPage extends StatelessWidget {
  BookingFieldPage({super.key});
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    final fieldData = Provider.of<FieldProvider>(context);
    final fields = fieldData.fields;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Pilih Lapangan'),
      ),
      body: Center(
          child: SizedBox(
        width: sizeWidth * 0.75,
        child: ListView.builder(
          itemCount: fields.length, // Perbaiki properti itemCount
          itemBuilder: (context, index) {
            // Gunakan fungsi yang sesuai untuk itemBuilder
            final field = fields[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detailBook',
                    arguments: field.id);
              },
              child: Container(
                height: sizeHeight * 0.25,
                margin: EdgeInsets.all(sizeWidth * 0.05),
                decoration: BoxDecoration(
                  color: darkBlueColor,
                  borderRadius: BorderRadius.circular(sizeWidth * 0.09),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final widgetWidth = constraints.maxWidth;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(widgetWidth * 0.1)),
                          child: Image.network(
                            field.image, // Gunakan URL gambar dari objek Field
                            width: widgetWidth,
                            height: sizeHeight * 0.15,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: sizeHeight * 0.01),
                        Container(
                          margin: EdgeInsets.only(left: sizeWidth * 0.05),
                          child: Column(
                            children: [
                              Text(
                                field
                                    .name, // Gunakan nama lapangan dari objek Field
                                style: GoogleFonts.poppins(
                                    fontSize: sizeWidth * 0.06,
                                    color: whiteColor),
                              ),
                              SizedBox(height: sizeHeight * 0.005),
                              Text.rich(
                                TextSpan(
                                  text: 'Rp.${field.price},- ',
                                  style: GoogleFonts.poppins(
                                      fontSize: sizeWidth * 0.04,
                                      color: whiteColor),
                                  children: [
                                    TextSpan(
                                      text: '/ Jam',
                                      style: GoogleFonts.poppins(
                                          fontSize: sizeWidth * 0.025,
                                          color: orangeColor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}

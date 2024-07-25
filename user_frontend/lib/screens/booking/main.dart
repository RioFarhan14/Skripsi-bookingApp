import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/productProvider.dart';
import 'package:user_frontend/utils/constants.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/theme.dart';

class BookingFieldPage extends StatelessWidget {
  const BookingFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    // Mengambil data fields dan status loading
    final productProvider = Provider.of<ProductProvider>(context);
    final fields = productProvider.fields;
    final isLoading = productProvider.isLoading;

    // Memanggil fetchFields jika data belum ada
    if (fields.isEmpty && !isLoading) {
      productProvider.fetchData();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Pilih Lapangan'),
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Menampilkan loading indicator
          : Center(
              child: SizedBox(
                width: sizeWidth * 0.75,
                child: ListView.builder(
                  itemCount: fields.length,
                  itemBuilder: (context, index) {
                    final field = fields[index];
                    final imageUrl = '$BASE_URL/images/${field.image}';
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(sizeWidth * 0.1)),
                              child: Image.network(
                                imageUrl,
                                width: double.infinity,
                                height: sizeHeight * 0.15,
                                fit: BoxFit
                                    .cover, // Mengubah fit untuk menjaga rasio aspek
                              ),
                            ),
                            SizedBox(height: sizeHeight * 0.01),
                            Padding(
                              padding: EdgeInsets.only(left: sizeWidth * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    field.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: sizeWidth * 0.06,
                                      color: whiteColor,
                                    ),
                                  ),
                                  SizedBox(height: sizeHeight * 0.005),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Rp.${field.price},- ',
                                      style: GoogleFonts.poppins(
                                        fontSize: sizeWidth * 0.04,
                                        color: whiteColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '/ Jam',
                                          style: GoogleFonts.poppins(
                                            fontSize: sizeWidth * 0.025,
                                            color: orangeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

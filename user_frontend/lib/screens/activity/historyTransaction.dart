import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/transactionProvider.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:intl/intl.dart'; // Import intl package

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key});

  @override
  _HistoryTransactionState createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false)
          .getUserHistoryTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        if (transactionProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final historys = transactionProvider.transactions;

        if (historys == null || historys.isEmpty) {
          return const Center(child: Text('Riwayat Transaksi Tidak Tersedia'));
        }

        return ListView.builder(
          itemCount: historys.length,
          itemBuilder: (context, index) {
            final history = historys[index];

            final transactionDate = DateTime.parse(history['transaction_date'])
                .toLocal()
                .toString() as String?;

            final status = history['status'] as String?;
            final productDetails =
                history['transaction_details'] as List<dynamic>?;
            final productType =
                productDetails != null && productDetails.isNotEmpty
                    ? (productDetails[0]['product']
                        as Map<String, dynamic>)['product_type'] as String?
                    : null;

            final productName =
                productDetails != null && productDetails.isNotEmpty
                    ? (productType == 'membership'
                        ? 'Membership'
                        : (productDetails[0]['product']
                            as Map<String, dynamic>)['product_name'] as String?)
                    : 'N/A';

            final schedule = transactionDate != null
                ? DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(transactionDate))
                : 'N/A';
            final clock = transactionDate != null
                ? DateFormat('HH:mm').format(DateTime.parse(transactionDate))
                : 'N/A';

            return Container(
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              height: screenHeight * 0.22,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.receipt,
                          size: screenHeight * 0.04,
                          color: orangeColor,
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          'Riwayat Transaksi',
                          style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontSize: screenHeight * 0.025),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Produk',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: screenHeight * 0.02),
                            ),
                            Text(
                              productName ?? 'N/A',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: screenHeight * 0.02),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status Pesanan',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: screenHeight * 0.02),
                            ),
                            Text(
                              status ?? 'N/A',
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: screenHeight * 0.02),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FaIcon(FontAwesomeIcons.solidCalendarDays,
                                color: orangeColor, size: screenHeight * 0.03),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              schedule,
                              style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontSize: screenHeight * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.28,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.clock,
                                color: orangeColor,
                                size: screenHeight * 0.03,
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(
                                clock,
                                style: GoogleFonts.poppins(
                                    color: whiteColor,
                                    fontSize: screenHeight * 0.02),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

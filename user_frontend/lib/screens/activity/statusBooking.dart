import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/models/field.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/providers/bookingProvider.dart';
import 'package:user_frontend/providers/productProvider.dart';
import 'package:user_frontend/services/midtrans-service.dart';
import 'package:user_frontend/utils/constants.dart';
import 'package:user_frontend/utils/customBotton1.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart'; // Pastikan versi dan package sesuai

class StatusBooking extends StatefulWidget {
  const StatusBooking({super.key});

  @override
  _StatusBookingState createState() => _StatusBookingState();
}

class _StatusBookingState extends State<StatusBooking> {
  MidtransSDK? _midtrans;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<BookingProvider>(context, listen: false)
          .fetchUserBookings();
      await Provider.of<ProductProvider>(context, listen: false).fetchData();
      await Provider.of<AuthProvider>(context, listen: false).tryAutoLogin();
      await _initSDK();
    });
  }

  Future<void> _initSDK() async {
    try {
      _midtrans =
          await MidtransService.initializeSDK(context, MIDTRANS_CLIENT_KEY);
      if (_midtrans == null) {
        print('Failed to initialize MidtransSDK');
      } else {
        print('MidtransSDK initialized successfully');
      }
    } catch (e) {
      print('Error initializing MidtransSDK: $e');
      MidtransService.showToast('SDK Initialization Failed', true);
    }
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final isMember = auth.userData?['isMember'] ?? false;
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final bookings = bookingProvider.userBookings;

        if (bookings.isEmpty) {
          return const Center(child: Text('Pesanan Tidak Tersedia'));
        }
        return Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return Scaffold(
              body: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  final product =
                      productProvider.getDataById(booking.product_id) as Field;

                  return Container(
                    decoration: BoxDecoration(
                      color: darkBlueColor,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    height: screenHeight * 0.28,
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final sizeWidth = constraints.maxWidth;
                          final sizeHeight = constraints.maxHeight;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.calendarCheck,
                                    color: orangeColor,
                                    size: sizeWidth * 0.13,
                                  ),
                                  SizedBox(width: sizeWidth * 0.05),
                                  Text(
                                    'Pesanan',
                                    style: GoogleFonts.poppins(
                                      color: whiteColor,
                                      fontSize: sizeHeight * 0.13,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: sizeHeight * 0.04),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nama Lapangan',
                                        style: GoogleFonts.poppins(
                                          color: whiteColor,
                                          fontSize: sizeHeight * 0.09,
                                        ),
                                      ),
                                      Text(
                                        product.name,
                                        style: GoogleFonts.poppins(
                                          color: whiteColor,
                                          fontSize: sizeHeight * 0.09,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status Pesanan',
                                        style: GoogleFonts.poppins(
                                          color: whiteColor,
                                          fontSize: sizeHeight * 0.09,
                                        ),
                                      ),
                                      Text(
                                        booking.statusBook,
                                        style: GoogleFonts.poppins(
                                          color: whiteColor,
                                          fontSize: sizeHeight * 0.09,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: sizeHeight * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidCalendarDays,
                                        color: orangeColor,
                                        size: sizeWidth * 0.08,
                                      ),
                                      SizedBox(width: sizeWidth * 0.02),
                                      Text(
                                        booking.schedule,
                                        style: GoogleFonts.poppins(
                                          color: whiteColor,
                                          fontSize: sizeHeight * 0.09,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: sizeWidth * 0.4,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.clock,
                                          color: orangeColor,
                                          size: sizeWidth * 0.08,
                                        ),
                                        SizedBox(width: sizeWidth * 0.02),
                                        Text(
                                          booking.start_time,
                                          style: GoogleFonts.poppins(
                                            color: whiteColor,
                                            fontSize: sizeHeight * 0.09,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: sizeHeight * 0.05),
                              if (booking.statusBook == 'Booked' &&
                                  isMember == true) ...[
                                CustomButton1(
                                  title: 'Ubah Jadwal',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/changeSchedule',
                                      arguments: booking.id,
                                    );
                                  },
                                  backgroundColor: orangeColor,
                                  colorText: Colors.white,
                                  buttonWidth: 0.37,
                                  buttonHeight: 0.05,
                                ),
                              ],
                              if (booking.statusBook == 'Pending') ...[
                                CustomButton1(
                                  title: 'Bayar',
                                  onPressed: () async {
                                    try {
                                      final token = booking.snap_token;
                                      if (token == null || token.isEmpty) {
                                        print('Snap token is null or empty');
                                        MidtransService.showToast(
                                            'Transaction Failed: Token is missing or empty',
                                            true);
                                        return;
                                      }

                                      if (_midtrans == null) {
                                        print('MidtransSDK is not initialized');
                                        MidtransService.showToast(
                                            'Transaction Failed: SDK is not initialized',
                                            true);
                                        return;
                                      }

                                      await _midtrans?.startPaymentUiFlow(
                                          token: token);
                                    } catch (e) {
                                      print('Error starting payment: $e');
                                      MidtransService.showToast(
                                          'Transaction Failed', true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('${e.toString()}'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  backgroundColor: orangeColor,
                                  colorText: Colors.white,
                                  buttonWidth: 0.37,
                                  buttonHeight: 0.05,
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

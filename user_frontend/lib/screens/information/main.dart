import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/notifProvider.dart';
import 'package:user_frontend/utils/customAppBar.dart';
import 'package:user_frontend/utils/theme.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  // Menyimpan indeks tombol yang aktif
  int _activeCategoryIndex = -1;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    // Gunakan NotificationProvider
    final notificationData = Provider.of<NotificationProvider>(context);
    final notifications = notificationData.notifications;
    final notifCategory = notificationData.notificationCategories;
    final notificationReads = notificationData.notificationReads;
    bool isNotificationRead(
        int notificationId, List<Map<String, dynamic>> notificationReads) {
      // Cari notifikasi dengan ID yang cocok
      final readNotification = notificationReads.firstWhere(
          (item) => item['notification_id'] == notificationId,
          orElse: () => {} // Mengembalikan Map kosong jika tidak ada yang cocok
          );

      // Jika readNotification adalah Map kosong, maka ID notifikasi tidak ditemukan
      return readNotification.isNotEmpty && readNotification['is_read'] == true;
    }

    // Filter notifikasi berdasarkan kategori yang aktif
    final filteredNotifications = _activeCategoryIndex == -1
        ? notifications
        : notifications.where((notification) {
            final categoryId =
                notifCategory[_activeCategoryIndex]["category_id"];
            return notification['category_id'] == categoryId;
          }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(sizeHeight * 0.1),
        child: const CustomAppBar(title: 'Notifikasi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeWidth * 0.02, vertical: sizeHeight * 0.01),
            child: SizedBox(
              height: sizeHeight * 0.05, // Menentukan tinggi untuk ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: notifCategory.length,
                itemBuilder: (context, index) {
                  final notifCat = notifCategory[index];
                  final isButtonPressed = _activeCategoryIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _activeCategoryIndex = isButtonPressed ? -1 : index;
                        });
                      },
                      label: Text(
                        notifCat["category_name"],
                        style: GoogleFonts.poppins(
                            color: notifCat["category_name"] == "info"
                                ? Colors.blue
                                : Colors.orange),
                      ),
                      icon: notifCat["category_name"] == "info"
                          ? const FaIcon(
                              FontAwesomeIcons.circleInfo,
                              color: Colors.blue,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.tags,
                              color: Colors.orange,
                            ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          isButtonPressed ? darkBlueColor : Colors.transparent,
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(
                            color: darkBlueColor, // Border color
                            width: 2, // Border width
                          ),
                        ),
                        elevation: WidgetStateProperty.all(0), // Elevation
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ), // Padding
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Membungkus ListView dengan Expanded
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: sizeHeight * 0.004),
              width: sizeWidth * 0.8,
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notification = filteredNotifications[index];
                  // cek notificationRead
                  final getRead = isNotificationRead(
                      notification['notification_id'], notificationReads);
                  // Ambil pesan dari notifikasi
                  String message = notification['message'] ?? '';

                  // Batasi pesan menjadi 60 karakter
                  String truncatedMessage = message.length > 60
                      ? '${message.substring(0, 60)}...'
                      : message;
                  return Padding(
                    padding: EdgeInsets.only(bottom: sizeHeight * 0.02),
                    child: ElevatedButton(
                      onPressed: () {
                        // Tindakan saat tombol ditekan
                        notificationData
                            .isRead(notification['notification_id']);
                        Navigator.pushNamed(context, '/detailInfo',
                            arguments: notification['notification_id']);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(getRead == true
                            ? const Color(0xffBB9AB1)
                            : darkBlueColor),
                        side: WidgetStateProperty.all(
                          BorderSide(
                            color: getRead == true
                                ? const Color(0xffBB9AB1)
                                : darkBlueColor, // Border color
                            width: 2, // Border width
                          ),
                        ),
                        elevation: WidgetStateProperty.all(0), // Elevation
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: sizeHeight * 0.01),
                        ), // Padding
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(sizeWidth * 0.05),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(sizeWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                notification["category_id"] == 1
                                    ? const FaIcon(
                                        FontAwesomeIcons.circleInfo,
                                        color: Colors.blue,
                                      )
                                    : const FaIcon(
                                        FontAwesomeIcons.tags,
                                        color: Colors.orange,
                                      ),
                                SizedBox(
                                  width: sizeWidth * 0.02,
                                ),
                                Text(
                                  notification['title'],
                                  style: GoogleFonts.poppins(
                                      color: whiteColor,
                                      fontSize: sizeWidth * 0.06),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: sizeHeight * 0.01,
                            ),
                            SizedBox(
                                width: sizeWidth * 0.8,
                                height: sizeHeight * 0.06,
                                child: Text(
                                  truncatedMessage,
                                  style: GoogleFonts.poppins(
                                      color: whiteColor,
                                      fontSize: sizeWidth * 0.035),
                                )),
                            SizedBox(
                              height: sizeHeight * 0.01,
                            ),
                            Text(
                              '${notification['time']}',
                              style: GoogleFonts.poppins(color: whiteColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

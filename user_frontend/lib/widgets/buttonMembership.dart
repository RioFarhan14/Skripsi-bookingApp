import 'package:flutter/material.dart';

class ButtonMembership extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const ButtonMembership({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth * 0.9,
            child: FloatingActionButton.extended(
              elevation: 0,
              onPressed: onPressed,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Upgrade to ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: textColor,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: textColor,
                      size: screenWidth * 0.08,
                    ),
                    Text(
                      ' Membership',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

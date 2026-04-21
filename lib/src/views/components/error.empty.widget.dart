import 'package:flutter/material.dart';

enum ErrorType { error, empty }

class ErrorNoDataWidget extends StatelessWidget {
  final ErrorType type;
  final String message;
  final Function? onRetry;
  const ErrorNoDataWidget({
    super.key,
    required this.type,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    String icon = type == ErrorType.error
        ? "assets/images/error.png"
        : "assets/images/empty.png";
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(icon, width: 70, height: 70),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: () => onRetry!(),

                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.grey.shade200),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  "Retry",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

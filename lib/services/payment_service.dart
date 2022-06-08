import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentHandler {
  final String? payIntentId;
  final bool isError;
  final String message;

  PaymentHandler({
    this.payIntentId,
    required this.isError,
    required this.message,
  });
}

class PaymentService {
  PaymentService();

  Future<PaymentHandler> initPaymentSheet(User user, double totalAmount) async {
    try {
      // 1. create payment intent on the server
      final response =
          await http.post(Uri.parse('YOUR_CLOUD_FUNCTION_URL'), body: {
        'email': user.email,
        'amount': (totalAmount * 100).toString(),
      });

      final jsonResponse = jsonDecode(response.body);

      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
          testEnv: true,
          merchantCountryCode: 'US',
        ),
      );
      // 3. Present to the user and await the result
      await Stripe.instance.presentPaymentSheet();
      return PaymentHandler(
          isError: false,
          message: "Success",
          payIntentId: jsonResponse['paymentIntent']);
      // Note: This is better done through our cloud functions

    } catch (e) {
      if (e is StripeException) {
        return PaymentHandler(
            isError: true,
            message: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        return PaymentHandler(isError: true, message: 'Error: ${e}');
      }
    }
  }
}

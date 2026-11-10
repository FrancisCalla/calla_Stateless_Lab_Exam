import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stateless_lab_exam/calla_main.dart';

void main() {
  testWidgets('Shopping cart page renders all sections and handles button clicks',
      (WidgetTester tester) async {
    final List<String> logMessages = [];
    final debugPrintCallback = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) {
        logMessages.add(message);
      }
    };

    try {
      await tester.pumpWidget(const MyApp());

      // 1. AppBar
      expect(find.text('My Cart'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.text('3'), findsOneWidget); // Badge '3'

      // 2. Introduction Section
      expect(find.text('CAMPUS STORE'), findsOneWidget);
      expect(find.text('Ready for checkout'), findsOneWidget);
      expect(
        find.text('Review your items before placing your order.'),
        findsOneWidget,
      );

      // 3. Delivery Card
      expect(find.text('Deliver to Laurence Calla'), findsOneWidget);
      expect(find.text('Matina, Davao City'), findsOneWidget);
      expect(find.text('Change'), findsOneWidget);

      // 4. Products
      expect(find.text('Order Items'), findsOneWidget);
      expect(find.text('3 items'), findsOneWidget);
      expect(find.text('Wireless Mouse'), findsOneWidget);
      expect(find.text('PHP 450.00'), findsOneWidget);
      expect(find.text('USB-C Hub'), findsOneWidget);
      expect(find.text('PHP 850.00'), findsOneWidget);
      expect(find.text('Laptop Stand'), findsOneWidget);
      expect(find.text('PHP 700.00'), findsOneWidget);

      // 5. Discount Banner
      expect(find.text('STUDENT10 applied'), findsOneWidget);
      expect(find.text('10% discount on items'), findsOneWidget);

      // 6. Payment Summary
      expect(find.text('Payment Summary'), findsOneWidget);
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('PHP 2,000.00'), findsOneWidget);
      expect(find.text('Discount (10%)'), findsOneWidget);
      expect(find.text('- PHP 200.00'), findsOneWidget);
      expect(find.text('Delivery Fee'), findsOneWidget);
      expect(find.text('PHP 50.00'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('PHP 1,850.00'), findsOneWidget);

      // 7. Place Order
      expect(find.text('Place Order'), findsOneWidget);

      // Button taps and console output verification
      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(logMessages.contains('Back clicked'), isTrue);

      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      expect(logMessages.contains('Cart clicked'), isTrue);

      await tester.tap(find.text('Change'));
      expect(logMessages.contains('Change delivery address clicked'), isTrue);

      await tester.tap(find.byIcon(Icons.add).first);
      expect(logMessages.contains('Increase quantity: Wireless Mouse'), isTrue);

      await tester.tap(find.byIcon(Icons.remove).first);
      expect(logMessages.contains('Decrease quantity: Wireless Mouse'), isTrue);

      await tester.tap(find.byIcon(Icons.delete_outline_rounded).first);
      expect(logMessages.contains('Remove item: Wireless Mouse'), isTrue);

      await tester.scrollUntilVisible(find.text('Place Order'), 500);
      await tester.tap(find.text('Place Order'));
      expect(
        logMessages.contains('Place order clicked! Total: PHP 1850.00'),
        isTrue,
      );
    } finally {
      debugPrint = debugPrintCallback;
    }
  });
}

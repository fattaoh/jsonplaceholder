// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jsonplaceholder/model/users.dart';
import 'package:jsonplaceholder/widget/user_widget.dart';

void main() {
  testWidgets('user card displays profile and contact details', (
    WidgetTester tester,
  ) async {
    final user = Users(
      id: 1,
      name: 'Leanne Graham',
      username: 'Bret',
      email: 'leanne@example.com',
      address: Address(
        street: 'Kulas Light',
        suite: 'Apt. 556',
        city: 'Gwenborough',
        zipcode: '92998-3874',
        geo: Geo(lat: '-37.3159', lng: '81.1496'),
      ),
      phone: '1-770-736-8031 x56442',
      website: 'hildegard.org',
      company: Company(
        name: 'Romaguera-Crona',
        catchPhrase: 'Multi-layered client-server neural-net',
        bs: 'harness real-time e-markets',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: UserWidget(user: user)),
      ),
    );

    expect(find.text('Leanne Graham'), findsOneWidget);
    expect(find.text('@Bret'), findsOneWidget);
    expect(find.text('leanne@example.com'), findsOneWidget);
    expect(
      find.text('Kulas Light, Apt. 556, Gwenborough 92998-3874'),
      findsOneWidget,
    );
    expect(find.text('Koordinat: -37.3159, 81.1496'), findsOneWidget);
    expect(find.text('Romaguera-Crona'), findsOneWidget);
    expect(find.text('harness real-time e-markets'), findsOneWidget);
  });
}

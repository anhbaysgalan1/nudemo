import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nudemo/signup/views/signup_view.dart';
import 'package:nudemo/signup/presenter/signup_presenter.dart';

void main() {
  group('[Widget -> Sign Up page]', () {
    final String title = 'Sign Up';
    testWidgets('Smoke test - ${title}', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: SignupPage(
            presenter: SignupPresenter(),
            title: title,
          ),
        ),
      );

      /// verify if have a widget with key `signup-page`
      /// (route `/`) with unlogged user.
      expect(find.byKey(Key('signup-page')), findsOneWidget);

      /// verify if have text `Sign Up`.
      expect(find.text(title.toUpperCase()), findsOneWidget);

      /// verify if have any `IconButton` widget to go back.
      expect(find.byKey(Key('go-back-button')), findsWidgets);

      /// verify if have a `Image` widget.
      expect(find.byType(Image), findsOneWidget);

      /// verify if have a `RichText` widget with `text-1` key.
      expect(find.byKey(Key('text-1')), findsOneWidget);

      /// verify if have a `RichText` widget with `text-2` key.
      expect(find.byKey(Key('text-2')), findsOneWidget);

      /// tap the `⬅️` arrow_back icon and trigger a frame.
      await tester.tap(find.byKey(Key('go-back-button')));

      /// rebuild the widget with the new value.
      await tester.pump();
    });
  });
}

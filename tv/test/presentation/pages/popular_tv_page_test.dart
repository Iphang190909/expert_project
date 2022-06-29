import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvsBloc extends MockBloc<PopularTVEvent, PopularTVState>
    implements PopularTVBloc {}

class PopularTvsEventFake extends Fake implements PopularTVEvent {}

class PopularTvsStateFake extends Fake implements PopularTVState {}

@GenerateMocks([PopularTVBloc])
void main() {
  late MockPopularTvsBloc mockPopularTvsBloc;

  setUp(() {
    mockPopularTvsBloc = MockPopularTvsBloc();
  });

  setUpAll(() {
    registerFallbackValue(PopularTvsEventFake());
    registerFallbackValue(PopularTvsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVBloc>.value(
      value: mockPopularTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.state).thenReturn(PopularTVLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.state).thenReturn(PopularTVHasData(tTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.state)
        .thenReturn(const PopularTVError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

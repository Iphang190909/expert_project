import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTVBloc extends MockBloc<WatchlistTVEvent, WatchlistTVState>
    implements WatchlistTVBloc {}

class WatchlistTVEventFake extends Fake implements WatchlistTVEvent {}

class WatchlistTVStateFake extends Fake implements WatchlistTVState {}

@GenerateMocks([WatchlistTVBloc])
void main() {
  late MockWatchlistTVBloc mockWatchlistTVBloc;

  setUp(() {
    mockWatchlistTVBloc = MockWatchlistTVBloc();
  });

  setUpAll(() {
    registerFallbackValue(WatchlistTVEventFake());
    registerFallbackValue(WatchlistTVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTVBloc>.value(
      value: mockWatchlistTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTVBloc.state).thenReturn(WatchlistTVLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistTVBloc.state)
        .thenReturn(WatchlistTVHasData(tTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTVBloc.state)
        .thenReturn(const WatchlistTVError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

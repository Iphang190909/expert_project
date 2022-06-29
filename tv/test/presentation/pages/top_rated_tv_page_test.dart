import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTVBloc extends MockBloc<TopRatedTVEvent, TopRatedTVState>
    implements TopRatedTVBloc {}

class TopRatedTVEventFake extends Fake implements TopRatedTVEvent {}

class TopRatedTVStateFake extends Fake implements TopRatedTVState {}

@GenerateMocks([TopRatedTVBloc])
void main() {
  late MockTopRatedTVBloc mockTopRatedTVBloc;

  setUp(() {
    mockTopRatedTVBloc = MockTopRatedTVBloc();
  });

  setUpAll(() {
    registerFallbackValue(TopRatedTVEventFake());
    registerFallbackValue(TopRatedTVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVBloc>.value(
      value: mockTopRatedTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVBloc.state).thenReturn(TopRatedTVLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVBloc.state).thenReturn(TopRatedTVHasData(tTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVBloc.state)
        .thenReturn(const TopRatedTVError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

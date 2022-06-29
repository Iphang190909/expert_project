import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailTVBloc extends MockBloc<DetailTVEvent, DetailTVState>
    implements DetailTVBloc {}

class DetailTVEventFake extends Fake implements DetailTVEvent {}

class DetailTVStateFake extends Fake implements DetailTVState {}

class MockRecommendationTVBloc
    extends MockBloc<RecommendationTVEvent, RecommendationTVState>
    implements RecommendationTVBloc {}

class RecommendationTVEventFake extends Fake implements RecommendationTVEvent {}

class RecommendationTVStateFake extends Fake implements RecommendationTVState {}

class MockWatchlistTVBloc extends MockBloc<WatchlistTVEvent, WatchlistTVState>
    implements WatchlistTVBloc {}

class WatchlistTVEventFake extends Fake implements WatchlistTVEvent {}

class WatchlistTVStateFake extends Fake implements WatchlistTVState {}

@GenerateMocks([DetailTVBloc])
void main() {
  late MockDetailTVBloc mockDetailTVBloc;
  late MockRecommendationTVBloc mockRecommendationTVBloc;
  late MockWatchlistTVBloc mockWatchlistTVBloc;

  setUpAll(() {
    registerFallbackValue(DetailTVEventFake());
    registerFallbackValue(DetailTVStateFake());
    registerFallbackValue(RecommendationTVEventFake());
    registerFallbackValue(RecommendationTVStateFake());
    registerFallbackValue(WatchlistTVEventFake());
    registerFallbackValue(WatchlistTVStateFake());
  });

  setUp(() {
    mockDetailTVBloc = MockDetailTVBloc();
    mockRecommendationTVBloc = MockRecommendationTVBloc();
    mockWatchlistTVBloc = MockWatchlistTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTVBloc>(create: (context) => mockDetailTVBloc),
        BlocProvider<RecommendationTVBloc>(
            create: (context) => mockRecommendationTVBloc),
        BlocProvider<WatchlistTVBloc>(create: (context) => mockWatchlistTVBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTVBloc.state).thenReturn(DetailTVHasData(tTVDetail));
    when(() => mockRecommendationTVBloc.state)
        .thenReturn(RecommendationTVHasData(tTvList));
    when(() => mockWatchlistTVBloc.state)
        .thenReturn(const WatchlistTVStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTVBloc.state).thenReturn(DetailTVHasData(tTVDetail));
    when(() => mockRecommendationTVBloc.state)
        .thenReturn(RecommendationTVHasData(tTvList));
    when(() => mockWatchlistTVBloc.state)
        .thenReturn(const WatchlistTVStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}

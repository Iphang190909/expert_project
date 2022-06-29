import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class TVDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv';

  final int id;

  const TVDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TVDetailPage> createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DetailTVBloc>().add(FetchDetailTV(widget.id));
      context.read<WatchlistTVBloc>().add(LoadWatchlistStatusTV(widget.id));
      context
          .read<RecommendationTVBloc>()
          .add(FetchRecommendationTV(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTVBloc, DetailTVState>(builder: (context, state) {
        if (state is DetailTVLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailTVHasData) {
          return SafeArea(
              child: DetailContentTVDetail(
            tvDetail: state.result,
          ));
        } else if (state is DetailTVError) {
          return Center(child: Text(state.message));
        } else {
          return const Text("Failed");
        }
      }),
    );
  }
}

class DetailContentTVDetail extends StatelessWidget {
  final TvDetail tvDetail;

  const DetailContentTVDetail({
    Key? key,
    required this.tvDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistTVBloc, WatchlistTVState>(
                                listener: (context, state) {
                              if (state is WatchlistTVSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              } else if (state is WatchlistTVFailure) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    });
                              }
                            }, builder: (context, state) {
                              return ElevatedButton(
                                  onPressed: () async {
                                    if (state is WatchlistTVStatus) {
                                      if (!state.isAddedToWatchlist) {
                                        context
                                            .read<WatchlistTVBloc>()
                                            .add(AddWatchlistTV(tvDetail));
                                      } else {
                                        context
                                            .read<WatchlistTVBloc>()
                                            .add(RemoveWatchlistTV(tvDetail));
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state is WatchlistTVStatus)
                                        if (!state.isAddedToWatchlist)
                                          const Icon(Icons.add)
                                        else if (state.isAddedToWatchlist)
                                          const Icon(Icons.check),
                                      const Text('Watchlist'),
                                    ],
                                  ));
                            }),
                            Text(_showGenres(tvDetail.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAvarage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAvarage}')
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Text("Overview", style: kHeading6),
                            Text(tvDetail.overview),
                            const SizedBox(height: 16.0),
                            Text('Recommendation', style: kHeading6),
                            BlocBuilder<RecommendationTVBloc,
                                    RecommendationTVState>(
                                builder: (context, state) {
                              if (state is RecommendationTVLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is RecommendationTVError) {
                                return Center(child: Text(state.message));
                              } else if (state is RecommendationTVHasData) {
                                return SizedBox(
                                    height: 150.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvRecommendation =
                                            state.result[index];

                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  TVDetailPage.routeName,
                                                  arguments:
                                                      tvRecommendation.id);
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${tvRecommendation.posterPath}',
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error)),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ));
                              } else {
                                return Container();
                              }
                            })
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      height: 4.0,
                      width: 48.0,
                    ),
                  )
                ]),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<GenreTv> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ", ";
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

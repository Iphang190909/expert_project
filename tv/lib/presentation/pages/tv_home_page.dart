import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class HomeTVPage extends StatefulWidget {
  static const routeName = '/home-page-tv';

  const HomeTVPage({Key? key}) : super(key: key);

  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnTheAirTVBloc>().add(FetchOnTheAirTV());
    context.read<PopularTVBloc>().add(FetchPopularTV());
    context.read<TopRatedTVBloc>().add(FetchTopRatedTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'On The Air TV Series',
                  style: kHeading6,
                ),
              ),
              BlocBuilder<OnTheAirTVBloc, OnTheAirTVState>(
                  builder: (context, state) {
                if (state is OnTheAirTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OnTheAirTVHasData) {
                  return TVList(state.result);
                } else {
                  return const Center(
                    child: Text('Failed to load Data!'),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.routeName),
              ),
              BlocBuilder<PopularTVBloc, PopularTVState>(
                  builder: (context, state) {
                if (state is PopularTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTVHasData) {
                  return TVList(state.result);
                } else if (state is PopularTVError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVPage.routeName),
              ),
              BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
                  builder: (context, state) {
                if (state is TopRatedTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTVHasData) {
                  return TVList(state.result);
                } else if (state is TopRatedTVError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

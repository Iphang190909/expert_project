import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class PopularTVPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PopularTVBloc>().add(FetchPopularTV()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVBloc, PopularTVState>(
          builder: (context, state) {
            if (state is PopularTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTVError) {
              return Center(
                  key: const Key("error_message"), child: Text(state.message));
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}

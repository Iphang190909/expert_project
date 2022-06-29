import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/home_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/tv.dart';

import '../pages/about_page.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({Key? key, required this.content}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double slide = 240.0 * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);

            return Stack(children: [
              Column(
                children: [
                  const UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/circle-g.png'),
                    ),
                    accountName: Text('Ditonton'),
                    accountEmail: Text('ditonton@dicoding.com'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.live_tv_rounded),
                    title: const Text('Watching TV'),
                    onTap: () {
                      Navigator.pushNamed(context, HomePage.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.tv_rounded),
                    title: const Text('Watching TV Series'),
                    onTap: () {
                      Navigator.pushNamed(context, HomeTVPage.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.save_alt_rounded),
                    title: const Text('Watchlist Movie'),
                    onTap: () {
                      Navigator.pushNamed(
                          context, WatchlistMoviesPage.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.save_alt_rounded),
                    title: const Text('Watchlist TV'),
                    onTap: () {
                      Navigator.pushNamed(context, WatchlistTVPage.routeName);
                    },
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AboutPage.routeName);
                    },
                    leading: const Icon(Icons.info_outline_rounded),
                    title: const Text('About'),
                  ),
                ],
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ]);
          }),
    );
  }
}

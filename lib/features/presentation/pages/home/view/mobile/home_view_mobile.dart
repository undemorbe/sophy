import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/features/presentation/pages/home/widgets/track_card.dart';
import 'package:sophy/features/presentation/widgets/icon_button.dart';
import 'package:sophy/l10n/app_localizations.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600 ? '1' : '2';
    return Scaffold(
      backgroundColor: themeof.colorScheme.surface,

      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeof.colorScheme.surface,

        title: Text(
          AppLocalizations.of(context)!.homepage_appbar(isMobile),
          style: themeof.textTheme.titleLarge?.copyWith(),
          // TODO add subscription related main title
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: MyIconButton(
              width: 35,
              height: 35,
              icon: Center(
                child: Icon(
                  Icons.person,
                  size: 35 / 2,
                  color: themeof.colorScheme.onPrimary,
                ),
              ),
              onPressed: () {
                context.push('/profile');
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TrackCard(
            trackName: 'Track $index',
            artistName: 'Artist $index',
            musicImageUrl:
                'https://www.rollingstone.com/wp-content/uploads/2024/10/sh2.jpg?w=1581&h=1054&crop=1',
            datePublishedFormated: '2025-02-12',
          );
        },
      ),
    );
  }
}

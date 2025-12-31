import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/pages/home/widgets/track_card.dart';
import 'package:sophy/features/presentation/widgets/icon_button.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return Scaffold(
      backgroundColor: themeof.colorScheme.background,
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeof.colorScheme.background,

        title: Text(
          'New Drops',
          style: themeof.textTheme.titleLarge?.copyWith(
          ),

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
                // TODO add upload action
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
            datePublishedFormated: '2023-01-01',
          );
        },
      ),
    );
  }
}

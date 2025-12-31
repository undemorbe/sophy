import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/pages/home/widgets/track_card.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        leading: Text('NEW DROPS'),
        title: Text(
          'S O P H Y?',
          // TODO add subscription related main title
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              // TODO add upload action
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // TODO add profile action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TrackCard(
            trackName: 'Track $index',
            artistName: 'Artist $index',
            trackImageUrl: 'https://picsum.photos/200/300',
            datePublishedFormated: '2023-01-01',
          );
        },
      ),
    );
  }
}

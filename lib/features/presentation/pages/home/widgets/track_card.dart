import 'package:flutter/material.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.trackName,
    required this.artistName,
    required this.trackImageUrl,
    this.datePublishedFormated,
  });

  final String trackName;
  final String artistName;
  final String trackImageUrl;
  final String? datePublishedFormated;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final themeof = Theme.of(context);
    return Container(
      height: mediaQuery.size.height * 0.3,
      width: mediaQuery.size.width,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(child: Image.network(trackImageUrl)),
          Container(
            color: themeof.colorScheme.primary,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      trackName,
                      style: themeof.textTheme.titleMedium?.copyWith(
                        color: themeof.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      artistName,
                      style: themeof.textTheme.bodyMedium?.copyWith(
                        color: themeof.colorScheme.onPrimary,
                      ),
                    ),
                    if (datePublishedFormated != null)
                      Text(
                        datePublishedFormated!,
                        style: themeof.textTheme.bodySmall?.copyWith(
                          color: themeof.colorScheme.onPrimary,
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.outlined(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      // TODO add favoritism + check is favorite
                      constraints: BoxConstraints.tightFor(
                        width: 30,
                        height: 30,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        // TODO add play action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

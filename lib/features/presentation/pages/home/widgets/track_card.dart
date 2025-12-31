import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/widgets/cached_image.dart';
import 'package:sophy/features/presentation/widgets/icon_button.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.trackName,
    required this.artistName,
    required this.musicImageUrl,
    this.datePublishedFormated,
  });

  final String trackName;
  final String artistName;
  final String musicImageUrl;
  final String? datePublishedFormated;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final themeof = Theme.of(context);
    return Container(
      height: mediaQuery.size.height * 0.4,
      width: mediaQuery.size.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: MyCachedImage(
              imageUrl: musicImageUrl,
              duration: Duration(milliseconds: 500),
              fit: BoxFit.cover,
              height: mediaQuery.size.height * 0.39,
              width: mediaQuery.size.width,
            ),
          ),
          Container(
            height: mediaQuery.size.height * 0.1,
            width: mediaQuery.size.width,
            decoration: BoxDecoration(
              color: themeof.colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyIconButton(
                        width: 35,
                        height: 35,
                        icon: Center(
                          child: Icon(
                            Icons.favorite,
                            size: 35 / 2,
                            color: themeof.colorScheme.onPrimary,
                          ),
                        ),
                        onPressed: () {
                          // TODO add favorite action
                        },
                      ),
                      SizedBox(width: 6),
                      MyIconButton(
                        width: 70,
                        height: 70,
                        icon: Icon(
                          Icons.play_arrow,
                          size: 45,
                          color: themeof.colorScheme.primary,
                        ),
                        onPressed: () {
                          // TODO add play action
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

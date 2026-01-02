import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/search/widgets/my_search_bar.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';
import 'package:sophy/l10n/app_localizations.dart';

class SearchPageLaptop extends StatefulWidget {
  const SearchPageLaptop({super.key});

  @override
  State<SearchPageLaptop> createState() => _SearchPageLaptopState();
}

class _SearchPageLaptopState extends State<SearchPageLaptop> {
  final MusicStore _musicStore = getIt<MusicStore>();
  final PlayerStore _playerStore = getIt<PlayerStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.searchpage_appbar('2'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            width: 600,
            child: MySearchBar(
              paddingFromEdges: 0,
              hintText: AppLocalizations.of(
                context,
              )!.searchwidget_hint_text('1'),
              onChanged: (value) {
                _musicStore.setSearchQuery(value);
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Observer(
              builder: (context) {
                final tracks = _musicStore.filteredTracks;

                if (tracks.isEmpty) {
                   return Center(child: Text('No tracks found', style: Theme.of(context).textTheme.headlineSmall));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final track = tracks[index];
                    return TrackCard(
                      trackName: track.name,
                      artistName: track.artist,
                      musicImageUrl: track.imageUrl,
                      datePublishedFormated: "${track.createdAt.year}-${track.createdAt.month}-${track.createdAt.day}",
                      isFavorite: _musicStore.isFavorite(track),
                      onFavorite: () => _musicStore.toggleFavorite(track),
                      onPlay: () {
                        _playerStore.playTrack(track);
                        context.push('/player');
                      },
                    );
                  }
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}

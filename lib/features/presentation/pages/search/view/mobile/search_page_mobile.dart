import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/search/widgets/category_grid.dart';
import 'package:sophy/features/presentation/pages/search/widgets/my_search_bar.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';
import 'package:sophy/l10n/app_localizations.dart';

class SearchPageMobile extends StatefulWidget {
  const SearchPageMobile({super.key});

  @override
  State<SearchPageMobile> createState() => _SearchPageMobileState();
}

class _SearchPageMobileState extends State<SearchPageMobile> {
  final TextEditingController _searchController = TextEditingController();
  final MusicStore _musicStore = getIt<MusicStore>();
  final PlayerStore _playerStore = getIt<PlayerStore>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                AppLocalizations.of(context)!.searchpage_appbar('1'),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MySearchBar(
              controller: _searchController,
              paddingFromEdges: 16,
              hintText: AppLocalizations.of(
                context,
              )!.searchwidget_hint_text('1'),
              onChanged: (value) {
                _musicStore.setSearchQuery(value);
              },
            ),
            const SizedBox(height: 24),

            Expanded(
              child: Observer(
                builder: (context) {
                  final showResults =
                      _musicStore.searchQuery.isNotEmpty ||
                      _musicStore.selectedCategory != null;

                  if (!showResults) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Browse All",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: CategoryGrid(
                            onCategorySelected: (category) {
                              _musicStore.setCategory(category);
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    final tracks = _musicStore.filteredTracks;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_musicStore.selectedCategory != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: InputChip(
                              label: Text(_musicStore.selectedCategory!),
                              onDeleted: () => _musicStore.setCategory(null),
                            ),
                          ),
                        if (tracks.isEmpty)
                          Expanded(
                            child: Center(
                              child: Text(
                                'No tracks found',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: ListView.builder(
                              itemCount: tracks.length,
                              itemBuilder: (context, index) {
                                final track = tracks[index];
                                return TrackCard(
                                  trackName: track.name,
                                  artistName: track.artist,
                                  musicImageUrl: track.imageUrl,
                                  datePublishedFormated:
                                      "${track.createdAt.year}-${track.createdAt.month}-${track.createdAt.day}",
                                  isFavorite: _musicStore.isFavorite(track),
                                  onFavorite: () =>
                                      _musicStore.toggleFavorite(track),
                                  onPlay: () {
                                    _playerStore.playTrack(track);
                                    context.push('/player');
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

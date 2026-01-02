import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/library/widgets/upload_track_dialog.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';
import 'package:sophy/features/presentation/widgets/icon_button.dart';
import 'package:sophy/l10n/app_localizations.dart';

class LibraryPageLaptop extends StatelessWidget {
  const LibraryPageLaptop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final musicStore = getIt<MusicStore>();
    final playerStore = getIt<PlayerStore>();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const UploadTrackDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Upload Track'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: theme.colorScheme.surface,
            title: Text(
              AppLocalizations.of(context)!.liblarypage_appbar('2'),
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            floating: true,
            snap: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: MyIconButton(
                  icon: const Icon(Icons.person),
                  width: 50,
                  height: 50,
                  onPressed: () {
                    context.push('/profile');
                  },
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                AppLocalizations.of(context)!.library_music_favorites,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: Observer(
                builder: (context) {
                  final favorites = musicStore.favorites;
                  if (favorites.isEmpty) {
                    return Center(child: Text("No favorites yet", style: theme.textTheme.titleMedium));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final track = favorites[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: TrackCard(
                          width: 280,
                          height: 350,
                          trackName: track.name,
                          artistName: track.artist,
                          musicImageUrl: track.imageUrl,
                          datePublishedFormated: "${track.createdAt.year}-${track.createdAt.month}-${track.createdAt.day}",
                          isFavorite: true,
                          onFavorite: () => musicStore.toggleFavorite(track),
                          onPlay: () {
                            playerStore.playTrack(track);
                            context.push('/player');
                          },
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                AppLocalizations.of(context)!.library_music_trending,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: Observer(
                builder: (context) {
                  final trending = musicStore.tracks.take(10).toList();
                   if (trending.isEmpty) {
                    return Center(child: Text("No trending tracks", style: theme.textTheme.titleMedium));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    itemCount: trending.length,
                    itemBuilder: (context, index) {
                      final track = trending[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: TrackCard(
                          width: 280,
                          height: 350,
                          trackName: track.name,
                          artistName: track.artist,
                          musicImageUrl: track.imageUrl,
                          datePublishedFormated: "${track.createdAt.year}-${track.createdAt.month}-${track.createdAt.day}",
                          isFavorite: musicStore.isFavorite(track),
                          onFavorite: () => musicStore.toggleFavorite(track),
                          onPlay: () {
                            playerStore.playTrack(track);
                            context.push('/player');
                          },
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                AppLocalizations.of(context)!.library_music_categories,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(32.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int index,
              ) {
                final categories = ['Pop', 'Rock', 'Jazz', 'Classical', 'Hip Hop', 'Electronic', 'Indie', 'Metal'];
                if (index >= categories.length) return null;
                return Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://www.rollingstone.com/wp-content/uploads/2024/10/sh2.jpg?w=1581&h=1054&crop=1',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }, childCount: 8),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

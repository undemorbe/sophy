import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/widgets/cached_image.dart';
import 'package:sophy/features/presentation/widgets/icon_button.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              indent: MediaQuery.of(context).size.width * 0.45,
              endIndent: MediaQuery.of(context).size.width * 0.45,
            ),

            // Top Actions
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.repeat_rounded),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Circle Avatar with Track Image
            Container(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.005,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      241,
                      0,
                      0,
                    ).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 90 + MediaQuery.of(context).size.width * 0.1,
                backgroundImage: CachedNetworkImageProvider(
                  'https://upload.wikimedia.org/wikipedia/commons/e/ee/Xxxtentacion_%28cropped%29.jpg',
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Track Info (Optional but good for context)
            Text(
              'Track Title',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Artist Name',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const Spacer(),
            // Controls: Previous, Stop/Play, Next
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 48.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyIconButton(
                    width: 60,
                    height: 60,
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous, size: 32),
                  ),
                  MyIconButton(
                    width: 80,
                    height: 80,
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  MyIconButton(
                    width: 60,
                    height: 60,
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next, size: 32),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

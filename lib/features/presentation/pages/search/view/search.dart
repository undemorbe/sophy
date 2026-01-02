import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/pages/search/widgets/my_search_bar.dart';
import 'package:sophy/l10n/app_localizations.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600 ? "1" : "2";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.searchpage_appbar(isMobile),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        MySearchBar(
          paddingFromEdges: 25,
          hintText: AppLocalizations.of(context)!.searchwidget_hint_text('1'),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        ),
      ],
    );
  }
}

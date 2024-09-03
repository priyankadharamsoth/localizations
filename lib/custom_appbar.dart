import 'package:flutter/material.dart';
import 'package:localization/app_loc_extention.dart';
import 'package:localization/locale_provicer.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLoc;

    return AppBar(
      title: Text(
        l10n.localization,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.white),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        IconButton(
          icon: const Icon(Icons.language, color: Colors.white),
          onPressed: () {
            final provider =
                Provider.of<LocaleProvider>(context, listen: false);
            provider.toggle();
            // switch (locale.languageCode) {
            //   case 'en':
            //     provider.setLocale(const Locale('tr'));
            //     break;
            //   case 'tr':
            //     provider.setLocale(const Locale('de'));
            //     break;
            //   case 'de':
            //     provider.setLocale(const Locale('en'));
            //     break;
            //   default:
            //     provider.setLocale(const Locale('en'));
            //     break;
            // }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

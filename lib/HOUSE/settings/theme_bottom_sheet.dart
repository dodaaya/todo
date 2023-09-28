import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
          onTap: () {
            provider.changeTheme(ThemeMode.light);
          },
          child: provider.appTheme == ThemeMode.light
              ? getSelected(AppLocalizations.of(context)!.light)
              : getUnselected(AppLocalizations.of(context)!.light),
        ),
        InkWell(
          onTap: () {
            provider.changeTheme(ThemeMode.dark);
          },
          child: provider.appTheme == ThemeMode.dark
              ? getSelected(AppLocalizations.of(context)!.dark)
              : getUnselected(AppLocalizations.of(context)!.dark),
        ),
      ]),
    );
  }

  Widget getSelected(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          Icon(Icons.check)
        ],
      ),
    );
  }

  Widget getUnselected(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

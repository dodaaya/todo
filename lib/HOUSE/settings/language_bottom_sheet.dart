import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
          onTap: () {
            provider.changeLanguage('en');
          },
          child: provider.appLanguage == 'en'
              ? getSelected(AppLocalizations.of(context)!.english)
              : getUnselected(AppLocalizations.of(context)!.english),
        ),
        InkWell(
          onTap: () {
            provider.changeLanguage('ar');
          },
          child: provider.appLanguage == 'ar'
              ? getSelected(AppLocalizations.of(context)!.arabic)
              : getUnselected(AppLocalizations.of(context)!.arabic),
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

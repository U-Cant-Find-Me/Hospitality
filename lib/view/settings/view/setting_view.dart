import 'package:hospitality/core/components/lisstile/changer_listtile_with_dropdown.dart';
import 'package:hospitality/core/components/dropdown/theme_change_dropdown.dart';
import 'package:hospitality/core/constants/icon/icon_constants.dart';
import 'package:hospitality/main.dart';
import 'package:hospitality/product/init/lang/locale_keys.g.dart';
import 'package:hospitality/product/widget/appbar/setting_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingAppbar(),
      body: Column(
        children: [
          // theme listtile
          ChangerListtileWithDropdown(
            icon: IconConstants.themeIcon,
            title: LocaleKeys.themeTheme.tr(),
            alertTitle: LocaleKeys.themeThemeChoose.tr(),
            child: const ThemeChangeDropdown(),
          ),
          // localiziton listtile
          ChangerListtileWithDropdown(
            icon: IconConstants.localizationIcon,
            title: LocaleKeys.localizationAppLang.tr(),
            alertTitle: LocaleKeys.localizationLangChoose.tr(),
            child: changeLocalWithDropdown(context),
          ),
        ],
      ),
    );
  }

  DropdownButton<dynamic> changeLocalWithDropdown(BuildContext context) {
    return DropdownButton(
      value: context.locale,
      items: LocaleVariables.localItems(),
      onChanged: (value) {
        context.setLocale(value);
        Navigator.pop(context);
      },
    );
  }
}

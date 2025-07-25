import 'package:hospitality/product/enum/intro_enums.dart';
import 'package:hospitality/product/init/lang/locale_keys.g.dart';
import 'package:hospitality/view/introduction/model/page_model.dart';
import 'package:easy_localization/easy_localization.dart';

class IntroPages {
  const IntroPages._();

  static Page get insurancePage => Page(
        path: 'assets/intro/Insurance.json',
        title: LocaleKeys.introIntroTitleFourth.tr(),
        body: LocaleKeys.introIntroDescriptionFourth.tr(),
      );

  static Page get billingPage => Page(
        path: 'assets/intro/bill.json',
        title: LocaleKeys.introIntroTitleFifth.tr(),
        body: LocaleKeys.introIntroDescriptionFifth.tr(),
      );

  static Page get inventoryPage => Page(
        path: 'assets/intro/Inventory.json',
        title: LocaleKeys.introIntroTitleSixth.tr(),
        body: LocaleKeys.introIntroDescriptionSixth.tr(),
      );

  // Legacy support - keeping these for compatibility during transition
  static Page get fourthPage => insurancePage;
  static Page get fifthPage => billingPage;
  static Page get sixthPage => inventoryPage;

  static List<Page> get pageList => [
        insurancePage,
        billingPage,
        inventoryPage,
      ];
}

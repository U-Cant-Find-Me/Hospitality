import 'package:hospitality/core/components/dots/dots_decoration.dart';
import 'package:hospitality/core/components/text/text_with_theme_color.dart';
import 'package:hospitality/core/init/cache/onboarding/intro_caching.dart';
import 'package:hospitality/core/init/navigation/navigation_route.dart';
import 'package:hospitality/product/init/lang/locale_keys.g.dart';
import 'package:hospitality/view/_product/enum/route_enum.dart';
import 'package:hospitality/view/introduction/view-model/intro_pages.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3; // Only 3 pages: Insurance, Billing, Inventory

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSkip() {
    IntroCaching.watchIntro();
    NavigationRoute.goRouteClear(RouteEnum.setting.rawValue);
  }

  void _onNext() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onDone();
    }
  }

  void _onDone() {
    IntroCaching.watchIntro();
    NavigationRoute.goRouteClear(RouteEnum.setting.rawValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                _buildInsurancePage(),
                _buildBillingPage(),
                _buildInventoryPage(),
              ],
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildInsurancePage() {
    return _buildPage(
      animationPath: IntroPages.insurancePage.path,
      title: IntroPages.insurancePage.title,
      description: IntroPages.insurancePage.body,
    );
  }

  Widget _buildBillingPage() {
    return _buildPage(
      animationPath: IntroPages.billingPage.path,
      title: IntroPages.billingPage.title,
      description: IntroPages.billingPage.body,
    );
  }

  Widget _buildInventoryPage() {
    return _buildPage(
      animationPath: IntroPages.inventoryPage.path,
      title: IntroPages.inventoryPage.title,
      description: IntroPages.inventoryPage.body,
    );
  }

  Widget _buildPage({
    required String animationPath,
    required String title,
    required String description,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            // Custom animation container
            Expanded(
              flex: 3,
              child: _buildCustomAnimation(animationPath),
            ),
            const SizedBox(height: 32),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    height: 1.5,
                  ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAnimation(String animationPath) {
    // Custom animation widget that will replace Lottie
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _buildAnimationContent(animationPath),
      ),
    );
  }

  Widget _buildAnimationContent(String animationPath) {
    return Lottie.asset(
      animationPath,
      fit: BoxFit.contain,
      repeat: true,
      animate: true,
    );
  }

  Widget _buildBottomControls() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _totalPages,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Buttons
            Row(
              children: [
                // Skip button
                TextButton(
                  onPressed: _onSkip,
                  child: Text(
                    LocaleKeys.buttonSkip.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                // Next/Done button
                ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    _currentPage == _totalPages - 1 ? LocaleKeys.buttonDone.tr() : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Introduction {
  const Introduction._();
  static const intro = IntroductionScreen();
}

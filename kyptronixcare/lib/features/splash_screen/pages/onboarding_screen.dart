import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../user_role/pages/user_role_selector.dart';
import '../widgets/onboarding_button.dart';
import '../widgets/onboarding_text_card.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController1 = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20.0),
            Expanded(
              flex: 5,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: onBoardinglist.length,
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController1,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingCard(
                      onBoardingModel: onBoardinglist[index],
                    );
                  }),
            ),
            const Gap(40.0),
            Center(
              child: DotsIndicator(
                dotsCount: onBoardinglist.length,
                position: _currentIndex,
                decorator: DotsDecorator(
                  color: colorScheme.primary.withOpacity(0.4),
                  size: const Size.square(8.0),
                  activeSize: const Size(20.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeColor: colorScheme.primary,
                ),
              ),
            ),
            const Gap(40.0),
            Expanded(
              flex: 2,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: onBoardinglist.length,
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController2,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingTextCard(
                      onBoardingModel: onBoardinglist[index],
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    );
                  }),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButton(
                  elevation: 0,
                  onTap: () {
                    if (_currentIndex == onBoardinglist.length - 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserRoleSelector(),
                        ),
                      );
                    } else {
                      _pageController1.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                      _pageController2.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  text: _currentIndex == onBoardinglist.length - 1
                      ? 'Get Started'
                      : 'Next',
                  bgColor: colorScheme.primary,
                  borderRadius: 20,
                  height: 46,
                  width: 327,
                  textColor: Colors.white,
                  textTheme: textTheme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingCard extends StatefulWidget {
  const OnBoardingCard({
    super.key,
    required this.onBoardingModel,
  });
  final OnBoarding onBoardingModel;

  @override
  State<OnBoardingCard> createState() => _OnBoardingCardState();
}

class _OnBoardingCardState extends State<OnBoardingCard> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.onBoardingModel.image,
      height: 300,
      width: double.maxFinite,
      fit: BoxFit.fitWidth,
    );
  }
}

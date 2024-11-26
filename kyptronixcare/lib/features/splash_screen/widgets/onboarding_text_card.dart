import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingTextCard extends StatelessWidget {
  final OnBoarding onBoardingModel;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const OnboardingTextCard({
    super.key,
    required this.onBoardingModel,
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              onBoardingModel.title,
              style: textTheme.titleLarge!.copyWith(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(16.0),
            Text(
              onBoardingModel.description,
              style: textTheme.bodyLarge!.copyWith(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoarding {
  String title;
  String description;
  String image;

  OnBoarding({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoarding> onBoardinglist = [
  OnBoarding(
    title: ' Can be accessed from anywhere at any time',
    image: ImagesPath.kOnboarding1,
    description:
        'The essential language learning tools and resources you need to seamlessly transition into mastering a new language',
  ),
  OnBoarding(
      title: 'Offers a dynamic and interactive experience',
      image: ImagesPath.kOnboarding2,
      description:
          'Engaging features including test, story telling, and conversations that motivate and inspire language learners to unlock their full potential'),
  OnBoarding(
      title: "Experience the Premium Features with Our App",
      image: ImagesPath.kOnboarding3,
      description:
          'Updated TalkGpt with premium materials and a dedicated following, providing language learners with immersive content for effective learning'),
];

class ImagesPath {
  static String kOnboarding1 = 'assets/images/onboarding1.png';
  static String kOnboarding2 = 'assets/images/onBoarding2.png';
  static String kOnboarding3 = 'assets/images/onBoarding3.png';
}

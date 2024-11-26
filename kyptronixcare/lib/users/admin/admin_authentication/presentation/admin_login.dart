import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyptronixcare/users/admin/admin_authentication/widgets/admin_email_field.dart';
import 'package:kyptronixcare/users/admin/admin_authentication/widgets/admin_password_field.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../dashboard/presentation/admin_dashboard.dart';
import '../widgets/admin_auth_button.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(24.0),
                Text(
                  'Hi, Welcome Back! 👋',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge!.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8.0),
                Text(
                  'We happy to see you. Sign In to your account',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 36),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(8.0),
                    AdminEmailField(
                      borderRadius: BorderRadius.circular(24),
                      hintText: 'Email',
                      controller: emailC,
                      isDarkMode: isDarkMode,
                      textTheme: theme.textTheme,
                    )
                  ],
                ),
                const Gap(16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(8.0),
                    AdminPasswordField(
                      borderRadius: BorderRadius.circular(24),
                      hintText: 'Password',
                      controller: passwordC,
                      isDarkMode: isDarkMode,
                      textTheme: theme.textTheme,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryTextButton(
                      onPressed: () {},
                      title: 'Forgot Password?',
                      textStyle:
                          theme.textTheme.bodyLarge!.copyWith(fontSize: 12.0),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    AdminAuthButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDashboardPage(),
                          ),
                        );
                      },
                      text: 'LogIn',
                      textTheme: theme.textTheme,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: CustomRichText(
                        title: 'Don’t have an account?',
                        subtitle: ' Create here',
                        onTab: () {},
                        subtitleTextStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.kWhite)
                            .copyWith(
                                color: AppColor.kPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    children: [
                      const DividerRow(title: 'Or Sign In with'),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 55.0,
                        width: double.infinity,
                        child: SignInButton(
                          Buttons.google,
                          text: "Sign up with Google",
                          onPressed: () {},
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TermsAndPrivacyText(
                    isDarkMode: isDarkMode,
                    title1: '  By signing up you agree to our',
                    title2: ' Terms ',
                    title3: '  and',
                    title4: ' Conditions of Use',
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.isDarkMode,
      required this.title4});
  final bool isDarkMode;
  final String title1, title2, title3, title4;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite)
            .copyWith(
                color: isDarkMode ? Colors.white60 : Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 14),
        children: [
          TextSpan(
            text: title1,
          ),
          TextSpan(
            text: title2,
            style: GoogleFonts.plusJakartaSans().copyWith(
                color: isDarkMode ? Colors.blue.shade600 : Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          TextSpan(
            text: title3,
            style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.kWhite)
                .copyWith(
                    color: isDarkMode ? Colors.white60 : Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
          ),
          TextSpan(
            text: title4,
            style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.kWhite)
                .copyWith(
                    color: isDarkMode ? Colors.blue.shade600 : Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class SecondaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final double borderRadius;
  final double? fontSize;
  final Color textColor, bgColor;
  const SecondaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.width,
      required this.height,
      // required this.icons,
      required this.borderRadius,
      this.fontSize,
      required this.textColor,
      required this.bgColor});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          height: widget.height,
          alignment: Alignment.center,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: AppColor.kLine),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              // Image.asset(widget.icons, width: 23.85, height: 23.04),
              const SizedBox(width: 12),
              Text(widget.text,
                  style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.kWhite)
                      .copyWith(
                    color: widget.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerRow extends StatelessWidget {
  final String title;
  const DividerRow({
    required this.title,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Divider(
              color: AppColor.kLine,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.kWhite)
                .copyWith(
                    color: AppColor.kGrayscale40,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
          ),
        ),
        Expanded(
            flex: 2,
            child: Divider(
              color: AppColor.kLine,
            ))
      ],
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTab,
    required this.subtitleTextStyle,
  });
  final String title, subtitle;
  final TextStyle subtitleTextStyle;
  final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.kWhite)
              .copyWith(
                  color: AppColor.kGrayscale40,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.textStyle});
  final Function() onPressed;
  final String title;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

class AppColor {
  static Color kPrimary = const Color(0XFF1460F2);
  static Color kWhite = const Color(0XFFFFFFFF);
  static Color kBackground = const Color(0XFFFAFAFA);
  static Color kGrayscaleDark100 = const Color(0XFF1C1C1E);
  static Color kLine = const Color(0XFFEBEBEB);
  static Color kBackground2 = const Color(0XFFF6F6F6);
  static Color kGrayscale40 = const Color(0XFFAEAEB2);
}

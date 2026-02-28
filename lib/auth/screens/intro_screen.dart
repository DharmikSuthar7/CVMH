import 'package:flutter/material.dart';
import 'package:splitease_test/core/theme/laser_theme.dart';
import 'package:splitease_test/shared/widgets/animated_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _buttonController;
  late AnimationController _orbController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _buttonFade;
  late Animation<Offset> _buttonSlide;
  late Animation<double> _orbAnim;

  @override
  void initState() {
    super.initState();

    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOutBack),
    );
    _orbAnim = Tween<double>(begin: 0, end: 1).animate(_orbController);

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 150));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 450));
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    _orbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LaserColors.darkBg,
      body: Stack(
        children: [
          // ── Dark gradient background ─────────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: LaserColors.introGradient,
                ),
              ),
            ),
          ),

          // ── Animated floating orbs ───────────────────────────────────────
          AnimatedBuilder(
            animation: _orbAnim,
            builder: (context2, child2) {
              return Stack(
                children: [
                  Positioned(
                    top: 60 + _orbAnim.value * 20,
                    right: -40,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            LaserColors.primaryStart.withValues(alpha: 0.18),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 120 - _orbAnim.value * 15,
                    left: -50,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            LaserColors.primaryEnd.withValues(alpha: 0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // ── Main content ─────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Logo section
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: _buildLogo(),
                    ),
                  ),

                  const SizedBox(height: 44),

                  // Tagline
                  FadeTransition(
                    opacity: _textFade,
                    child: SlideTransition(
                      position: _textSlide,
                      child: _buildTagline(),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // CTA Buttons
                  FadeTransition(
                    opacity: _buttonFade,
                    child: SlideTransition(
                      position: _buttonSlide,
                      child: _buildButtons(context),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // Glow container
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            gradient: LaserColors.primaryLinearGradient,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: LaserColors.primary.withValues(alpha: 0.5),
                blurRadius: 30,
                spreadRadius: 4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.currency_rupee_rounded,
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(height: 22),
        ShaderMask(
          shaderCallback: (bounds) =>
              LaserColors.primaryLinearGradient.createShader(bounds),
          child: const Text(
            'SplitEase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Column(
      children: [
        // Gradient divider
        Container(
          width: 50,
          height: 3,
          decoration: BoxDecoration(
            gradient: LaserColors.primaryLinearGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Split Smart.\nPay Easy.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.4,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Share expenses effortlessly with\nfriends, family, and roommates.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 14,
            height: 1.65,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        AnimatedAppButton(
          text: 'Get Started',
          icon: Icons.arrow_forward_rounded,
          onTap: () =>
              Navigator.pushNamed(context, '/login', arguments: {'isSignUp': true}),
          height: 56,
          borderRadius: 18,
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/login'),
          child: Text(
            'Already have an account? Sign in',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:splitease_test/core/models/dummy_data.dart';
import 'package:splitease_test/core/theme/laser_theme.dart';
import 'package:splitease_test/shared/widgets/animated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isSignUp = false;
  bool _initDone = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initDone) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['isSignUp'] == true) {
        _isSignUp = true;
      }
      _initDone = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);

    final isAdmin = DummyData.isAdminEmail(_emailController.text);
    if (isAdmin) {
      Navigator.pushReplacementNamed(context, '/admin');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [LaserColors.darkBg, const Color(0xFF0A1C1C)]
                : [LaserColors.lightBg, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // ── Back button ─────────────────────────────────────────
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isDark
                              ? LaserColors.darkSurface
                              : LaserColors.lightSurface,
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: isDark
                                ? LaserColors.darkSurfaceVariant
                                : LaserColors.lightSurfaceVariant,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: isDark
                              ? LaserColors.textLight
                              : LaserColors.lightText,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Logo row ─────────────────────────────────────────────
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: LaserColors.primaryLinearGradient,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: LaserColors.primary
                                    .withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.currency_rupee_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              LaserColors.primaryLinearGradient
                                  .createShader(bounds),
                          child: Text(
                            'SplitEase',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Title ────────────────────────────────────────────────
                    Text(
                      _isSignUp ? 'Create Account' : 'Welcome Back 👋',
                      style: TextStyle(
                        color: isDark
                            ? LaserColors.textLight
                            : LaserColors.lightText,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isSignUp
                          ? 'Sign up to start splitting expenses'
                          : 'Sign in to your SplitEase account',
                      style: TextStyle(
                        color: isDark
                            ? LaserColors.subtextLight
                            : LaserColors.lightSubtext,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Form Card ────────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDark
                            ? LaserColors.darkCard
                            : LaserColors.lightSurface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark
                              ? LaserColors.darkSurfaceVariant
                              : LaserColors.lightSurfaceVariant,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (_isSignUp) ...[
                              _buildField(
                                isDark: isDark,
                                hint: 'Full Name',
                                icon: Icons.person_outline_rounded,
                                validator: (v) =>
                                    v!.isEmpty ? 'Enter your name' : null,
                              ),
                              const SizedBox(height: 14),
                            ],
                            _buildEmailField(isDark),
                            const SizedBox(height: 14),
                            _buildPasswordField(isDark),
                            const SizedBox(height: 24),
                            AnimatedAppButton(
                              text: _isSignUp ? 'Create Account' : 'Sign In',
                              icon: _isSignUp
                                  ? Icons.person_add_rounded
                                  : Icons.login_rounded,
                              onTap: _handleLogin,
                              isLoading: _isLoading,
                              height: 54,
                              borderRadius: 16,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Switch mode ────────────────────────────────────────
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            setState(() => _isSignUp = !_isSignUp),
                        child: RichText(
                          text: TextSpan(
                            text: _isSignUp
                                ? 'Already have an account? '
                                : "Don't have an account? ",
                            style: TextStyle(
                              color: isDark
                                  ? LaserColors.subtextLight
                                  : LaserColors.lightSubtext,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: _isSignUp ? 'Sign In' : 'Create Account',
                                style: const TextStyle(
                                  color: LaserColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(bool isDark) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: isDark ? LaserColors.textLight : LaserColors.lightText,
      ),
      decoration: const InputDecoration(
        hintText: 'Email address',
        prefixIcon: Icon(Icons.mail_outline_rounded, size: 20),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Enter your email';
        if (!v.contains('@')) return 'Enter a valid email';
        return null;
      },
    );
  }

  Widget _buildPasswordField(bool isDark) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: TextStyle(
        color: isDark ? LaserColors.textLight : LaserColors.lightText,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: LaserColors.primary,
          ),
          onPressed: () =>
              setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      validator: (v) =>
          v!.length < 4 ? 'Password must be at least 4 characters' : null,
    );
  }

  Widget _buildField({
    required bool isDark,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      style: TextStyle(
        color: isDark ? LaserColors.textLight : LaserColors.lightText,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
      ),
      validator: validator,
    );
  }
}

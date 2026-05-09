import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_preset.dart';
import '../../../profile/presentation/providers/theme_mode_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preset = ref.watch(themePresetPreferenceProvider);

    if (preset == AppThemePreset.hawaii) {
      return _HawaiiLoginScaffold(
        emailCtrl: _emailCtrl,
        passwordCtrl: _passwordCtrl,
        obscure: _obscure,
        onToggleObscure: () => setState(() => _obscure = !_obscure),
        onEnter: () => context.go('/home'),
      );
    }

    return _DefaultLoginScaffold(
      emailCtrl: _emailCtrl,
      passwordCtrl: _passwordCtrl,
      obscure: _obscure,
      onToggleObscure: () => setState(() => _obscure = !_obscure),
      onEnter: () => context.go('/home'),
    );
  }
}

// ─── DEFAULT (clean white) ────────────────────────────────────────────────────

class _DefaultLoginScaffold extends StatelessWidget {
  const _DefaultLoginScaffold({
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.obscure,
    required this.onToggleObscure,
    required this.onEnter,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 64),
              const Column(
                children: [
                  Icon(Icons.shopping_cart_rounded, size: 56, color: AppColors.emerald600),
                  SizedBox(height: 10),
                  Text(
                    'Abasto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.emerald600,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Bienvenido a tu feria local',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.slate500),
              ),
              const SizedBox(height: 40),
              _InputField(
                controller: emailCtrl,
                hint: 'Correo electrónico',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              _InputField(
                controller: passwordCtrl,
                hint: 'Contraseña',
                obscure: obscure,
                suffix: GestureDetector(
                  onTap: onToggleObscure,
                  child: Icon(
                    obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: AppColors.slate400,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _OrangeButton(label: 'ENTRAR', onTap: onEnter),
              const SizedBox(height: 32),
              const Row(
                children: [
                  Expanded(child: Divider(color: AppColors.slate200)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text('o conéctate con', style: TextStyle(fontSize: 13, color: AppColors.slate400)),
                  ),
                  Expanded(child: Divider(color: AppColors.slate200)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(onTap: onEnter, child: _GoogleLogo()),
                  const SizedBox(width: 16),
                  _SocialButton(
                    onTap: onEnter,
                    child: const Icon(Icons.facebook, size: 26, color: Color(0xFF1877F2)),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: onEnter,
                child: const Text(
                  'Continuar como invitado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.slate400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── HAWAII ───────────────────────────────────────────────────────────────────

class _HawaiiLoginScaffold extends StatelessWidget {
  const _HawaiiLoginScaffold({
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.obscure,
    required this.onToggleObscure,
    required this.onEnter,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final VoidCallback onEnter;

  static const _gradientTop    = Color(0xFFBF4B0A);
  static const _gradientBottom = Color(0xFFF5A843);
  static const _teal           = Color(0xFF006B6B);
  static const _tealLight      = Color(0xFF008C8C);
  static const _wood           = Color(0xFF7A4A2D);
  static const _woodDark       = Color(0xFF4E2D13);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _gradientTop,
      body: Stack(
        children: [
          // Gradient background
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_gradientTop, _gradientBottom],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          // Palm leaf decoration (bottom right)
          Positioned(
            right: -20,
            bottom: 60,
            child: Opacity(
              opacity: 0.18,
              child: Transform.rotate(
                angle: -0.3,
                child: const Icon(Icons.eco_rounded, size: 180, color: Colors.white),
              ),
            ),
          ),
          // Palm leaf decoration (top left)
          Positioned(
            left: -24,
            top: 80,
            child: Opacity(
              opacity: 0.12,
              child: Transform.rotate(
                angle: 0.4,
                child: const Icon(Icons.eco_rounded, size: 140, color: Colors.white),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),

                  // Tiki logo
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _woodDark,
                        border: Border.all(color: _wood, width: 4),
                        boxShadow: const [
                          BoxShadow(color: Color(0x50000000), blurRadius: 16, offset: Offset(0, 6)),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.shopping_cart_rounded, size: 46, color: Color(0xFFFFF0D0)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Title
                  const Text(
                    'BIENVENIDO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.5,
                      shadows: [Shadow(color: Color(0x60000000), blurRadius: 8, offset: Offset(0, 2))],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Badge
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                      decoration: BoxDecoration(
                        color: _teal,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _tealLight, width: 1.5),
                      ),
                      child: const Text(
                        'ABASTO',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Email field
                  _HawaiiField(
                    controller: emailCtrl,
                    hint: 'Correo electrónico',
                    prefixIcon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 14),

                  // Password field
                  _HawaiiField(
                    controller: passwordCtrl,
                    hint: 'Contraseña',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscure: obscure,
                    onToggleObscure: onToggleObscure,
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white54,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Teal login button
                  GestureDetector(
                    onTap: onEnter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      decoration: BoxDecoration(
                        color: _teal,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(color: Color(0x50000000), blurRadius: 12, offset: Offset(0, 5)),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Social divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.4))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'o continúa con',
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.4))),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Social buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HawaiiSocialButton(onTap: onEnter, child: _GoogleLogo()),
                      const SizedBox(width: 16),
                      _HawaiiSocialButton(
                        onTap: onEnter,
                        child: const Icon(Icons.facebook, size: 26, color: Color(0xFF1877F2)),
                      ),
                      const SizedBox(width: 16),
                      _HawaiiSocialButton(
                        onTap: onEnter,
                        child: const Icon(Icons.apple, size: 26, color: Colors.black87),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Guest
                  GestureDetector(
                    onTap: onEnter,
                    child: Text(
                      'Continuar como invitado',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.7),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white38,
                      ),
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
}

class _HawaiiField extends StatelessWidget {
  const _HawaiiField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.keyboardType,
    this.obscure = false,
    this.onToggleObscure,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscure;
  final VoidCallback? onToggleObscure;

  static const _cream = Color(0xFFFFF0D0);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15, color: Color(0xFF2D1A00)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFAA8860), fontSize: 15),
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF7A5230), size: 20),
        suffixIcon: onToggleObscure != null
            ? GestureDetector(
                onTap: onToggleObscure,
                child: Icon(
                  obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                  color: const Color(0xFF7A5230),
                ),
              )
            : null,
        filled: true,
        fillColor: _cream,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Color(0xFF006B6B), width: 2),
        ),
      ),
    );
  }
}

class _HawaiiSocialButton extends StatelessWidget {
  const _HawaiiSocialButton({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFFF0D0),
          boxShadow: const [
            BoxShadow(color: Color(0x30000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

// ─── SHARED WIDGETS ───────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15, color: AppColors.slate900),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.slate400, fontSize: 15),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.slate50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.emerald600, width: 1.5),
        ),
      ),
    );
  }
}

class _OrangeButton extends StatelessWidget {
  const _OrangeButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 17),
        decoration: BoxDecoration(
          color: AppColors.orange500,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x40F97316), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: const Center(
          child: Text(
            'ENTRAR',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: AppColors.slate200),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4285F4)),
    );
  }
}

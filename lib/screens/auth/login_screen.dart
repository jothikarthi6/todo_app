import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import 'signup_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true, _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      await ref.read(authServiceProvider).login(
        _emailCtrl.text.trim(), _passCtrl.text.trim());
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar like reference UI
                  Container(
                    width: 44, height: 44,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryBlue, shape: BoxShape.circle),
                    child: const Center(
                      child: Text('JP', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 24),
                  const Text('Get Started now',
                    style: TextStyle(color: Colors.white,
                      fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Create an account or log in to manage your tasks',
                    style: TextStyle(color: AppTheme.textGrey, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tab row
                      Row(
                        children: [
                          TextButton(onPressed: () {},
                            child: const Text('Login',
                              style: TextStyle(color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.bold))),
                          TextButton(
                            onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) =>  SignUpScreen())),
                            child: const Text('SignUp',
                              style: TextStyle(color: AppTheme.textGrey))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _label('Email'),
                      _field(_emailCtrl, 'Enter your email address',
                        Icons.email_outlined, false),
                      const SizedBox(height: 16),
                      _label('Password'),
                      _field(_passCtrl, 'Enter your password',
                        Icons.lock_outline, _obscure,
                        suffix: IconButton(
                          icon: Icon(_obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        )),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Remember me'),
                          TextButton(onPressed: () {},
                            child: const Text('Forgot Password?',
                              style: TextStyle(color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(width: double.infinity, height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                          onPressed: _loading ? null : _login,
                          child: _loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Log In', style: TextStyle(
                                color: Colors.white, fontSize: 16,
                                fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _field(TextEditingController ctrl, String hint, IconData icon,
      bool obscure, {Widget? suffix}) =>
    TextField(
      controller: ctrl, obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint, prefixIcon: Icon(icon),
        suffixIcon: suffix,
        filled: true, fillColor: const Color(0xFFF5F6FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none),
      ),
    );
}

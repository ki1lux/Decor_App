import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

// ─── Reuse app color palette ────────────────────────────────────────────────
const Color _kBackground = Color(0xFFF5F0E8);
const Color _kMutedGreen = Color(0xFF8B9E7C);
const Color _kDarkGreen = Color(0xFF5C6B50);
const Color _kAccentOrange = Color(0xFFE8863A);
const Color _kDarkText = Color(0xFF2C2C2C);
const Color _kSubText = Color(0xFF6B6B6B);
const Color _kCardBeige = Color(0xFFF0EADD);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _floatController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;

  late Animation<double> _floatAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      title: 'Discover Unique\nFurniture',
      subtitle:
          'Browse curated collections of premium furniture pieces designed to transform your living space.',
      icon: Icons.weekend_rounded,
      accentIcon: Icons.search_rounded,
      gradientColors: [Color(0xFF8B9E7C), Color(0xFFA3B596)],
      floatingIcons: [
        Icons.chair_rounded,
        Icons.bed_rounded,
        Icons.table_restaurant_rounded,
      ],
    ),
    _OnboardingPageData(
      title: 'Design Your\nDream Space',
      subtitle:
          'Visualize how each piece fits in your home with our intelligent room planner and AR preview.',
      icon: Icons.design_services_rounded,
      accentIcon: Icons.auto_awesome_rounded,
      gradientColors: [Color(0xFFD4A574), Color(0xFFE8C4A0)],
      floatingIcons: [
        Icons.palette_rounded,
        Icons.grid_view_rounded,
        Icons.auto_fix_high_rounded,
      ],
    ),
    _OnboardingPageData(
      title: 'Shop With\nConfidence',
      subtitle:
          'Enjoy free delivery, easy returns, and exclusive member discounts on every order.',
      icon: Icons.shopping_bag_rounded,
      accentIcon: Icons.verified_rounded,
      gradientColors: [Color(0xFFE8863A), Color(0xFFF5A623)],
      floatingIcons: [
        Icons.local_shipping_rounded,
        Icons.loyalty_rounded,
        Icons.star_rounded,
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -12, end: 12).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackground,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            // ── Background decorative circles ──
            _buildBackgroundDecor(),

            // ── Page content ──
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildPage(_pages[index], index);
              },
            ),

            // ── Skip button ──
            if (_currentPage < _pages.length - 1)
              Positioned(
                top: MediaQuery.of(context).padding.top + 12,
                right: 20,
                child: AnimatedOpacity(
                  opacity: _currentPage < _pages.length - 1 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: _completeOnboarding,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _kSubText.withOpacity(0.15),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _kSubText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // ── Bottom controls ──
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomControls(),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BACKGROUND DECOR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBackgroundDecor() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -60 + _floatAnimation.value * 0.5,
              right: -80,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _pages[_currentPage]
                          .gradientColors[0]
                          .withOpacity(0.12),
                      _pages[_currentPage]
                          .gradientColors[0]
                          .withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100 + _floatAnimation.value * 0.3,
              left: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _pages[_currentPage]
                          .gradientColors[1]
                          .withOpacity(0.10),
                      _pages[_currentPage]
                          .gradientColors[1]
                          .withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE CONTENT
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPage(_OnboardingPageData data, int index) {
    final topPad = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: topPad + 60, left: 28, right: 28),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // ── Hero illustration ──
          _buildHeroIllustration(data, index),
          const SizedBox(height: 48),
          // ── Title ──
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: _kDarkText,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          // ── Subtitle ──
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: _kSubText,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HERO ILLUSTRATION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeroIllustration(_OnboardingPageData data, int index) {
    return SizedBox(
      height: 280,
      width: 280,
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatController, _pulseController]),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // ── Outer glow ring ──
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: data.gradientColors[0].withOpacity(0.15),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              // ── Middle ring ──
              Transform.scale(
                scale: 1.05 - (_pulseAnimation.value - 0.85) * 0.3,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: data.gradientColors[0].withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
              ),

              // ── Main circle with gradient ──
              Transform.translate(
                offset: Offset(0, _floatAnimation.value * 0.4),
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: data.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: data.gradientColors[0].withOpacity(0.35),
                        blurRadius: 40,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Icon(
                    data.icon,
                    size: 64,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
              ),

              // ── Accent badge ──
              Transform.translate(
                offset: Offset(
                  80 + _floatAnimation.value * 0.3,
                  -60 - _floatAnimation.value * 0.5,
                ),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    data.accentIcon,
                    size: 22,
                    color: data.gradientColors[0],
                  ),
                ),
              ),

              // ── Floating icons ──
              ...List.generate(data.floatingIcons.length, (i) {
                final angle = (i * 2 * math.pi / data.floatingIcons.length) -
                    math.pi / 2;
                final radius = 120.0;
                final dx = math.cos(angle) * radius;
                final dy = math.sin(angle) * radius;
                final floatOffset = _floatAnimation.value * (i.isEven ? 1 : -1);

                return Transform.translate(
                  offset: Offset(dx + floatOffset * 0.4, dy + floatOffset * 0.6),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _kCardBeige,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      data.floatingIcons[i],
                      size: 20,
                      color: data.gradientColors[0].withOpacity(0.7),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOTTOM CONTROLS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBottomControls() {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final isLast = _currentPage == _pages.length - 1;

    return Container(
      padding: EdgeInsets.only(
        bottom: bottomPad + 28,
        top: 24,
        left: 28,
        right: 28,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _kBackground.withOpacity(0.0),
            _kBackground.withOpacity(0.9),
            _kBackground,
          ],
          stops: const [0.0, 0.3, 0.6],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Dot indicators ──
          _buildDotIndicators(),
          const SizedBox(height: 32),
          // ── Action button ──
          _buildActionButton(isLast),
        ],
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? _pages[_currentPage].gradientColors[0]
                : _kSubText.withOpacity(0.2),
          ),
        );
      }),
    );
  }

  Widget _buildActionButton(bool isLast) {
    return GestureDetector(
      onTap: _nextPage,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        width: isLast ? 260 : 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLast
                ? [_kMutedGreen, _kDarkGreen]
                : [
                    _pages[_currentPage].gradientColors[0],
                    _pages[_currentPage].gradientColors[1],
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(isLast ? 32 : 22),
          boxShadow: [
            BoxShadow(
              color: (isLast
                      ? _kMutedGreen
                      : _pages[_currentPage].gradientColors[0])
                  .withOpacity(0.4),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLast
                ? Row(
                    key: const ValueKey('getstarted'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  )
                : const Icon(
                    Icons.arrow_forward_rounded,
                    key: ValueKey('arrow'),
                    color: Colors.white,
                    size: 26,
                  ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DATA MODEL
// ═══════════════════════════════════════════════════════════════════════════════
class _OnboardingPageData {
  final String title;
  final String subtitle;
  final IconData icon;
  final IconData accentIcon;
  final List<Color> gradientColors;
  final List<IconData> floatingIcons;

  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentIcon,
    required this.gradientColors,
    required this.floatingIcons,
  });
}

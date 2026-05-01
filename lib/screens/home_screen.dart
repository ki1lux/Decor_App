import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Color Palette ──────────────────────────────────────────────────────────
const Color kBackground = Color(0xFFF5F0E8);
const Color kCardBeige = Color(0xFFF0EADD);
const Color kMutedGreen = Color(0xFF8B9E7C);
const Color kDarkGreen = Color(0xFF5C6B50);
const Color kAccentOrange = Color(0xFFE8863A);
const Color kDarkText = Color(0xFF2C2C2C);
const Color kSubText = Color(0xFF6B6B6B);
const Color kSearchBg = Color(0xFFEDE8DF);
const Color kGlass = Color(0x28FFFFFF);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentNav = 0;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          // ── Scrollable content ──
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: topPad + 8, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildHeadline(),
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildPromoBanner(),
                const SizedBox(height: 28),
                _buildCategories(),
                const SizedBox(height: 28),
                _buildSaleBanner(),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // ── Bottom Nav ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 1 ─ HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu icon
          _glassButton(
            child: const Icon(Icons.grid_view_rounded, size: 20, color: kDarkGreen),
            onTap: () {},
          ),
          // Scan icon
          _glassButton(
            color: kMutedGreen,
            child: const Icon(Icons.qr_code_scanner_rounded, size: 20, color: Colors.white),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 2 ─ HEADLINE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Discover unique\nfurniture for\nyour home',
        style: GoogleFonts.inter(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          height: 1.2,
          color: kDarkText,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 3 ─ SEARCH BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Search input
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: kSearchBg,
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: kSubText, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Search furniture',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: kSubText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter button
          GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: kMutedGreen,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: kMutedGreen.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 4 ─ PROMO BANNER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF8B9E7C), Color(0xFFA3B596)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: kMutedGreen.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Curved decorative shape
            Positioned(
              right: -10,
              top: -10,
              bottom: -10,
              child: CustomPaint(
                size: const Size(200, 240),
                painter: _CurvePainter(),
              ),
            ),
            // Chair image
            Positioned(
              right: 10,
              top: -30,
              child: Image.network(
                'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=300&q=80',
                width: 180,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    color: kDarkGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.chair_rounded, size: 80, color: Colors.white54),
                ),
              ),
            ),
            // Text content
            Positioned(
              left: 24,
              top: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    '70% OFF',
                    style: GoogleFonts.inter(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Use code',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'SUMMER22',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // CTA arrow
            Positioned(
              left: 24,
              bottom: 20,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, color: kDarkGreen, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 5 ─ CATEGORIES ROW
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.weekend_rounded, 'label': 'Armchair'},
      {'icon': Icons.chair_alt_rounded, 'label': 'Sofa'},
      {'icon': Icons.bed_rounded, 'label': 'Bed'},
      {'icon': Icons.chair_rounded, 'label': 'Chair'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((cat) {
          return _CategoryItem(
            icon: cat['icon'] as IconData,
            label: cat['label'] as String,
          );
        }).toList(),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 6 ─ SALE BANNER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSaleBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFFD4CCBB), Color(0xFFBFBBAF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Interior scene image
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=400&q=80',
                  width: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 200,
                    color: kMutedGreen.withOpacity(0.15),
                    child: const Icon(Icons.living_rounded, size: 60, color: kMutedGreen),
                  ),
                ),
              ),
            ),
            // Gradient overlay for text readability
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFD4CCBB),
                      const Color(0xFFD4CCBB).withOpacity(0.85),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 0.75],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            // Text
            Positioned(
              left: 24,
              top: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clearance Sale',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: kDarkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get up to 50% off!',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: kSubText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: kBackground,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: kSubText.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Shop now',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: kDarkText,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 16, color: kDarkText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 7 ─ BOTTOM NAV
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBottomNav() {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: bottomPad + 8, top: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: kBackground.withOpacity(0.85),
        // Frosted glass effect
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home_rounded, 'Home', 0),
                _navItem(Icons.explore_outlined, 'Explore', 1),
                // Center FAB
                _buildFab(),
                _navItem(Icons.favorite_border_rounded, 'Wishlist', 2),
                _navItem(Icons.person_outline_rounded, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _currentNav == index;
    return GestureDetector(
      onTap: () => setState(() => _currentNav = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? kMutedGreen : kSubText,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? kMutedGreen : kSubText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 52,
        height: 52,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF5A623), Color(0xFFE8863A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: kAccentOrange.withOpacity(0.45),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 24),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER ─ Glass Button
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _glassButton({
    required Widget child,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color ?? kCardBeige,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CATEGORY ITEM WIDGET
// ═══════════════════════════════════════════════════════════════════════════
class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: kCardBeige,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              // Outer shadow (neumorphism dark)
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(3, 3),
              ),
              // Inner highlight (neumorphism light)
              const BoxShadow(
                color: Colors.white,
                blurRadius: 8,
                offset: Offset(-3, -3),
              ),
            ],
          ),
          child: Icon(icon, size: 32, color: kMutedGreen),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: kSubText,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER ─ Curved blob behind the chair
// ═══════════════════════════════════════════════════════════════════════════
class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7A8E6D).withOpacity(0.35)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.35, 0)
      ..quadraticBezierTo(size.width * 0.05, size.height * 0.25, size.width * 0.15, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.75, size.width * 0.1, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

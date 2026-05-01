import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Reuse shared palette
const Color _kBackground = Color(0xFFF5F0E8);
const Color _kCardBeige = Color(0xFFF0EADD);
const Color _kMutedGreen = Color(0xFF8B9E7C);
const Color _kDarkGreen = Color(0xFF5C6B50);
const Color _kAccentOrange = Color(0xFFE8863A);
const Color _kDarkText = Color(0xFF2C2C2C);
const Color _kSubText = Color(0xFF6B6B6B);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: _kBackground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: topPad + 8, bottom: 100),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 28),
            _buildQuickActions(),
            const SizedBox(height: 28),
            _buildMenuSection(),
            const SizedBox(height: 24),
            _buildSettingsSection(),
            const SizedBox(height: 24),
            _buildLogoutButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PROFILE HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildProfileHeader() {
    final fadeIn = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Settings gear
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _kCardBeige,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.settings_outlined,
                      size: 22, color: _kDarkGreen),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B9E7C), Color(0xFFA3B596)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _kMutedGreen.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'AM',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Alex Morgan',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _kDarkText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'alex.morgan@email.com',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: _kSubText,
              ),
            ),
            const SizedBox(height: 12),
            // Member badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF5A623), Color(0xFFE8863A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _kAccentOrange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.workspace_premium_rounded,
                      size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    'Gold Member',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
  // STATS ROW
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStatsRow() {
    final slideIn = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.15, 0.6, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: slideIn,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(slideIn),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _statItem('12', 'Orders'),
                _divider(),
                _statItem('5', 'Wishlist'),
                _divider(),
                _statItem('3', 'Reviews'),
                _divider(),
                _statItem('\$240', 'Saved'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _kDarkGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: _kSubText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 36,
      color: _kSubText.withOpacity(0.15),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // QUICK ACTIONS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildQuickActions() {
    final fadeIn = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.25, 0.7, curve: Curves.easeOutCubic),
    );

    final actions = [
      {
        'icon': Icons.local_shipping_outlined,
        'label': 'My Orders',
        'color': const Color(0xFF7BBFB5),
      },
      {
        'icon': Icons.credit_card_rounded,
        'label': 'Payment',
        'color': const Color(0xFFA78BFA),
      },
      {
        'icon': Icons.location_on_outlined,
        'label': 'Address',
        'color': const Color(0xFFFF8A80),
      },
      {
        'icon': Icons.card_giftcard_rounded,
        'label': 'Rewards',
        'color': const Color(0xFFFFB74D),
      },
    ];

    return FadeTransition(
      opacity: fadeIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions.map((action) {
            return _QuickActionItem(
              icon: action['icon'] as IconData,
              label: action['label'] as String,
              color: action['color'] as Color,
            );
          }).toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MENU SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMenuSection() {
    final fadeIn = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.35, 0.8, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _menuTile(
                Icons.receipt_long_rounded,
                'Order History',
                '12 orders',
                _kMutedGreen,
              ),
              _menuDivider(),
              _menuTile(
                Icons.favorite_border_rounded,
                'Wishlist',
                '5 items',
                const Color(0xFFFF8A80),
              ),
              _menuDivider(),
              _menuTile(
                Icons.star_border_rounded,
                'My Reviews',
                '3 reviews',
                const Color(0xFFFFB74D),
              ),
              _menuDivider(),
              _menuTile(
                Icons.percent_rounded,
                'Coupons',
                '2 available',
                const Color(0xFFA78BFA),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuTile(
      IconData icon, String title, String subtitle, Color accentColor) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 22, color: accentColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _kDarkText,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: _kSubText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 22, color: _kSubText),
          ],
        ),
      ),
    );
  }

  Widget _menuDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Divider(
        height: 1,
        color: _kSubText.withOpacity(0.1),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SETTINGS SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSettingsSection() {
    final fadeIn = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.45, 0.9, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _settingsTile(
                Icons.notifications_none_rounded,
                'Notifications',
                true,
              ),
              _menuDivider(),
              _settingsTile(
                Icons.dark_mode_outlined,
                'Dark Mode',
                false,
              ),
              _menuDivider(),
              _menuTile(
                Icons.language_rounded,
                'Language',
                'English',
                _kMutedGreen,
              ),
              _menuDivider(),
              _menuTile(
                Icons.help_outline_rounded,
                'Help & Support',
                'FAQ, Contact',
                const Color(0xFF7BBFB5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, bool isOn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _kMutedGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 22, color: _kMutedGreen),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _kDarkText,
              ),
            ),
          ),
          Switch.adaptive(
            value: isOn,
            activeColor: _kMutedGreen,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOGOUT BUTTON
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLogoutButton() {
    final fadeIn = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red.withOpacity(0.15)),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout_rounded,
                      size: 20, color: Colors.red.shade400),
                  const SizedBox(width: 10),
                  Text(
                    'Log Out',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// QUICK ACTION ITEM WIDGET
// ═══════════════════════════════════════════════════════════════════════════
class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 8,
                  offset: Offset(-2, -2),
                ),
              ],
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _kSubText,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
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

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with TickerProviderStateMixin {
  late final AnimationController _staggerController;

  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'name': 'Minimalist Armchair',
      'price': 299.00,
      'oldPrice': 499.00,
      'image':
          'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=300&q=80',
      'color': 'Olive Green',
      'rating': 4.8,
      'inStock': true,
    },
    {
      'name': 'Scandinavian Sofa',
      'price': 899.00,
      'oldPrice': 1299.00,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300&q=80',
      'color': 'Ash Grey',
      'rating': 4.9,
      'inStock': true,
    },
    {
      'name': 'Wooden Coffee Table',
      'price': 199.00,
      'oldPrice': 349.00,
      'image':
          'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?w=300&q=80',
      'color': 'Natural Oak',
      'rating': 4.6,
      'inStock': false,
    },
    {
      'name': 'Modern Floor Lamp',
      'price': 149.00,
      'oldPrice': 249.00,
      'image':
          'https://images.unsplash.com/photo-1507473885765-e6ed057ab6fe?w=300&q=80',
      'color': 'Matte Black',
      'rating': 4.7,
      'inStock': true,
    },
    {
      'name': 'Velvet Dining Chair',
      'price': 179.00,
      'oldPrice': 279.00,
      'image':
          'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=300&q=80',
      'color': 'Dusty Rose',
      'rating': 4.5,
      'inStock': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  void _removeItem(int index) {
    setState(() {
      _wishlistItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: _kBackground,
      body: Column(
        children: [
          SizedBox(height: topPad + 8),
          _buildHeader(),
          const SizedBox(height: 20),
          _buildSummaryBar(),
          const SizedBox(height: 16),
          Expanded(
            child: _wishlistItems.isEmpty
                ? _buildEmptyState()
                : _buildWishlistList(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Wishlist',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_wishlistItems.length} items saved',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: _kSubText,
                ),
              ),
            ],
          ),
          // Sort button
          Container(
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
              child:
                  Icon(Icons.sort_rounded, size: 22, color: _kDarkGreen),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSummaryBar() {
    double totalSaved = 0;
    for (final item in _wishlistItems) {
      totalSaved +=
          (item['oldPrice'] as double) - (item['price'] as double);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _kMutedGreen.withOpacity(0.15),
              _kMutedGreen.withOpacity(0.08),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _kMutedGreen.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _kMutedGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.savings_rounded,
                  size: 20, color: _kDarkGreen),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total savings',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: _kSubText,
                    ),
                  ),
                  Text(
                    '\$${totalSaved.toStringAsFixed(0)} off',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _kDarkGreen,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _kMutedGreen,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _kMutedGreen.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Add all to cart',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // WISHLIST LIST
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildWishlistList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100, top: 4),
      itemCount: _wishlistItems.length,
      itemBuilder: (context, index) {
        final delay = (index * 0.15).clamp(0.0, 1.0);
        final end = (delay + 0.4).clamp(0.0, 1.0);
        final animation = CurvedAnimation(
          parent: _staggerController,
          curve: Interval(delay, end, curve: Curves.easeOutCubic),
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(animation),
            child: _buildWishlistCard(index),
          ),
        );
      },
    );
  }

  Widget _buildWishlistCard(int index) {
    final item = _wishlistItems[index];
    final bool inStock = item['inStock'] as bool;
    final discount =
        (((item['oldPrice'] as double) - (item['price'] as double)) /
                (item['oldPrice'] as double) *
                100)
            .round();

    return Dismissible(
      key: ValueKey(item['name']),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _removeItem(index),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 28),
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.white, size: 28),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.6)),
        ),
        child: Row(
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    item['image'] as String,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _kCardBeige,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.image_rounded,
                          size: 40, color: _kSubText),
                    ),
                  ),
                ),
                // Discount badge
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _kAccentOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '-$discount%',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _kDarkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['color'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: _kSubText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 16, color: Color(0xFFF5A623)),
                      const SizedBox(width: 4),
                      Text(
                        '${item['rating']}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _kDarkText,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: inStock
                              ? _kMutedGreen.withOpacity(0.15)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          inStock ? 'In Stock' : 'Out of Stock',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: inStock ? _kDarkGreen : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${(item['price'] as double).toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _kDarkGreen,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${(item['oldPrice'] as double).toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: _kSubText,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Add to cart button
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: inStock
                      ? const LinearGradient(
                          colors: [Color(0xFF8B9E7C), Color(0xFF6B8060)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: inStock ? null : _kCardBeige,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: inStock
                      ? [
                          BoxShadow(
                            color: _kMutedGreen.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  inStock
                      ? Icons.shopping_bag_rounded
                      : Icons.notifications_none_rounded,
                  size: 20,
                  color: inStock ? Colors.white : _kSubText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // EMPTY STATE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _kMutedGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 48,
              color: _kMutedGreen,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your wishlist is empty',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: _kDarkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Items you save will appear here',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: _kSubText,
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            decoration: BoxDecoration(
              color: _kMutedGreen,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: _kMutedGreen.withOpacity(0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              'Start exploring',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

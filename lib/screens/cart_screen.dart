import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Shared Palette ─────────────────────────────────────────────────────────
const Color _kBackground = Color(0xFFF5F0E8);
const Color _kCardBeige = Color(0xFFF0EADD);
const Color _kMutedGreen = Color(0xFF8B9E7C);
const Color _kDarkGreen = Color(0xFF5C6B50);
const Color _kAccentOrange = Color(0xFFE8863A);
const Color _kDarkText = Color(0xFF2C2C2C);
const Color _kSubText = Color(0xFF6B6B6B);

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Oslo Lounge Chair',
      'price': 349.00,
      'image':
          'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=300&q=80',
      'color': 'Olive Green',
      'qty': 1,
    },
    {
      'name': 'Cloud Sofa Set',
      'price': 1299.00,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300&q=80',
      'color': 'Ash Grey',
      'qty': 1,
    },
    {
      'name': 'Arc Floor Lamp',
      'price': 189.00,
      'image':
          'https://images.unsplash.com/photo-1507473885765-e6ed057ab6fe?w=300&q=80',
      'color': 'Matte Black',
      'qty': 2,
    },
  ];

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

  double get _subtotal {
    double total = 0;
    for (final item in _cartItems) {
      total += (item['price'] as double) * (item['qty'] as int);
    }
    return total;
  }

  double get _shipping => _subtotal > 500 ? 0 : 29.99;
  double get _total => _subtotal + _shipping;

  void _updateQty(int index, int delta) {
    setState(() {
      final newQty = (_cartItems[index]['qty'] as int) + delta;
      if (newQty <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index]['qty'] = newQty;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
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
          Expanded(
            child: _cartItems.isEmpty
                ? _buildEmptyState()
                : _buildCartContent(),
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
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
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
                child: Icon(Icons.arrow_back_rounded,
                    size: 22, color: _kDarkGreen),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shopping Cart',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: _kDarkText,
                  ),
                ),
                Text(
                  '${_cartItems.length} items',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: _kSubText,
                  ),
                ),
              ],
            ),
          ),
          if (_cartItems.isNotEmpty)
            GestureDetector(
              onTap: () => setState(() => _cartItems.clear()),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.red.withOpacity(0.15)),
                ),
                child: Text(
                  'Clear',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CART CONTENT
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCartContent() {
    return Column(
      children: [
        // Free shipping banner
        if (_subtotal < 500) _buildFreeShippingBanner(),
        // Items list
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 8),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final delay = (index * 0.15).clamp(0.0, 0.8);
              final end = (delay + 0.4).clamp(0.0, 1.0);
              final animation = CurvedAnimation(
                parent: _animController,
                curve:
                    Interval(delay, end, curve: Curves.easeOutCubic),
              );
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: _buildCartItem(index),
                ),
              );
            },
          ),
        ),
        // Bottom checkout
        _buildCheckoutSection(),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FREE SHIPPING BANNER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFreeShippingBanner() {
    final progress = (_subtotal / 500).clamp(0.0, 1.0);
    final remaining = (500 - _subtotal).clamp(0.0, 500.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _kMutedGreen.withOpacity(0.1),
              _kMutedGreen.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kMutedGreen.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.local_shipping_outlined,
                    size: 18, color: _kDarkGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Add \$${remaining.toStringAsFixed(0)} more for free shipping',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _kDarkGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: _kMutedGreen.withOpacity(0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(
                    _kMutedGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CART ITEM CARD
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCartItem(int index) {
    final item = _cartItems[index];
    final int qty = item['qty'] as int;
    final double price = item['price'] as double;

    return Dismissible(
      key: ValueKey('${item['name']}_$index'),
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
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                item['image'] as String,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: _kCardBeige,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.image_rounded,
                      size: 36, color: _kSubText),
                ),
              ),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _kDarkText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['color'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: _kSubText,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Qty controls
                      Container(
                        decoration: BoxDecoration(
                          color: _kCardBeige,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            _qtyButton(
                              Icons.remove_rounded,
                              () => _updateQty(index, -1),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14),
                              child: Text(
                                '$qty',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: _kDarkText,
                                ),
                              ),
                            ),
                            _qtyButton(
                              Icons.add_rounded,
                              () => _updateQty(index, 1),
                            ),
                          ],
                        ),
                      ),
                      // Line total
                      Text(
                        '\$${(price * qty).toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: _kDarkGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: _kDarkGreen),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CHECKOUT SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCheckoutSection() {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 24, bottomPad + 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Promo code
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: _kCardBeige,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.discount_outlined,
                    size: 20, color: _kAccentOrange),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Enter promo code',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: _kSubText,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _kDarkGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Apply',
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
          const SizedBox(height: 18),
          // Price breakdown
          _priceRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _priceRow(
            'Shipping',
            _shipping == 0
                ? 'Free'
                : '\$${_shipping.toStringAsFixed(2)}',
            isHighlight: _shipping == 0,
          ),
          const SizedBox(height: 12),
          Divider(color: _kSubText.withOpacity(0.15)),
          const SizedBox(height: 12),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText,
                ),
              ),
              Text(
                '\$${_total.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _kDarkGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Checkout button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B9E7C), Color(0xFF6B8060)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _kMutedGreen.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_rounded,
                      size: 18, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Checkout',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded,
                      size: 18, color: Colors.white70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: _kSubText,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isHighlight ? _kDarkGreen : _kDarkText,
          ),
        ),
      ],
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
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: _kAccentOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 52,
              color: _kAccentOrange,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: _kDarkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Looks like you haven\'t added\nanything to your cart yet',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: _kSubText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF5A623), Color(0xFFE8863A)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _kAccentOrange.withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.explore_rounded,
                      size: 18, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Start shopping',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

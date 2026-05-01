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
const Color _kSearchBg = Color(0xFFEDE8DF);

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  int _selectedCategory = 0;
  late final AnimationController _staggerController;

  final List<String> _categories = [
    'All',
    'Living Room',
    'Bedroom',
    'Dining',
    'Office',
    'Outdoor',
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Oslo Lounge Chair',
      'price': 349.00,
      'image':
          'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=400&q=80',
      'rating': 4.8,
      'reviews': 124,
      'isNew': true,
      'isFavorite': false,
      'category': 'Living Room',
    },
    {
      'name': 'Maple Side Table',
      'price': 129.00,
      'image':
          'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?w=400&q=80',
      'rating': 4.6,
      'reviews': 89,
      'isNew': false,
      'isFavorite': true,
      'category': 'Living Room',
    },
    {
      'name': 'Cloud Sofa Set',
      'price': 1299.00,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&q=80',
      'rating': 4.9,
      'reviews': 256,
      'isNew': true,
      'isFavorite': false,
      'category': 'Living Room',
    },
    {
      'name': 'Arc Floor Lamp',
      'price': 189.00,
      'image':
          'https://images.unsplash.com/photo-1507473885765-e6ed057ab6fe?w=400&q=80',
      'rating': 4.7,
      'reviews': 73,
      'isNew': false,
      'isFavorite': false,
      'category': 'Bedroom',
    },
    {
      'name': 'Walnut Dining Set',
      'price': 899.00,
      'image':
          'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=400&q=80',
      'rating': 4.8,
      'reviews': 195,
      'isNew': false,
      'isFavorite': true,
      'category': 'Dining',
    },
    {
      'name': 'Velvet Accent Chair',
      'price': 279.00,
      'image':
          'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=400&q=80',
      'rating': 4.5,
      'reviews': 67,
      'isNew': true,
      'isFavorite': false,
      'category': 'Office',
    },
  ];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProducts {
    if (_selectedCategory == 0) return _products;
    final cat = _categories[_selectedCategory];
    return _products.where((p) => p['category'] == cat).toList();
  }

  void _toggleFavorite(int index) {
    setState(() {
      final product = _filteredProducts[index];
      final realIndex = _products.indexOf(product);
      _products[realIndex]['isFavorite'] =
          !(product['isFavorite'] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: _kBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: topPad + 8),
          _buildHeader(),
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildCategoryChips(),
          const SizedBox(height: 20),
          _buildResultsHeader(),
          const SizedBox(height: 12),
          Expanded(child: _buildProductGrid()),
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
                'Explore',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Find your perfect piece',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: _kSubText,
                ),
              ),
            ],
          ),
          // Filter badge
          Stack(
            children: [
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
                  child: Icon(Icons.tune_rounded,
                      size: 22, color: _kDarkGreen),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _kAccentOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEARCH BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: _kSearchBg,
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: _kSubText, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search products, brands...',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: _kSubText,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 24,
              color: _kSubText.withOpacity(0.2),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.mic_none_rounded,
                color: _kDarkGreen, size: 22),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CATEGORY CHIPS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCategoryChips() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
                _staggerController.reset();
                _staggerController.forward();
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? _kMutedGreen : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? _kMutedGreen
                      : _kSubText.withOpacity(0.2),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: _kMutedGreen.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                _categories[index],
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : _kSubText,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RESULTS HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildResultsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredProducts.length} items found',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kDarkText,
            ),
          ),
          Row(
            children: [
              Icon(Icons.grid_view_rounded,
                  size: 20, color: _kDarkGreen),
              const SizedBox(width: 12),
              Icon(Icons.view_list_rounded,
                  size: 20, color: _kSubText.withOpacity(0.5)),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PRODUCT GRID
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildProductGrid() {
    final products = _filteredProducts;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.62,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final delay = (index * 0.12).clamp(0.0, 0.8);
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
            child: _buildProductCard(products[index], index),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    final bool isNew = product['isNew'] as bool;
    final bool isFavorite = product['isFavorite'] as bool;

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        product['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: _kCardBeige,
                          child: const Center(
                            child: Icon(Icons.image_rounded,
                                size: 40, color: _kSubText),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(index),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                          color: isFavorite
                              ? Colors.red.shade400
                              : _kSubText,
                        ),
                      ),
                    ),
                  ),
                  // "New" badge
                  if (isNew)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _kDarkGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Info section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _kDarkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 14, color: Color(0xFFF5A623)),
                        const SizedBox(width: 3),
                        Text(
                          '${product['rating']}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _kDarkText,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product['reviews']})',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: _kSubText,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Price + cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${(product['price'] as double).toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _kDarkGreen,
                          ),
                        ),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF8B9E7C),
                                Color(0xFF6B8060)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(11),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    _kMutedGreen.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.add_rounded,
                              size: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

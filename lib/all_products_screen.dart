import 'package:flutter/material.dart';
import 'makeup_theme.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = allProducts.where((p) {
      if (_query.trim().isEmpty) return true;
      final q = _query.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: kLightPink,
      appBar: AppBar(
        backgroundColor: kLightPink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Normal Skin',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            color: Colors.black87,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Search bar =====
            TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _query = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search product for normal skin...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filtered.length} Product results',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sort,
                    size: 18,
                    color: Colors.grey,
                  ),
                  label: const Text(
                    'Sort by',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ===== GRID OF PRODUCTS =====
            Expanded(
              child: GridView.builder(
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  final isFav = FavoritesModel.items.contains(p);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(product: p),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, kCardPink],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ===== IMAGE + HEART =====
                          SizedBox(
                            height: 130,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kLightPink,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(26),
                                      topRight: Radius.circular(26),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Center(
                                    child: Image.asset(
                                      p.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isFav) {
                                          FavoritesModel.items.remove(p);
                                        } else {
                                          FavoritesModel.items.add(p);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.white.withOpacity(0.95),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 18,
                                        color: kPrimaryPink,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // ===== NAME =====
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              p.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),

                          // ===== BRAND =====
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              p.brand,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Spacer(),

                          // ===== PRICE =====
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10),
                            child: Text(
                              "\$${p.price.toStringAsFixed(1)}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryPink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

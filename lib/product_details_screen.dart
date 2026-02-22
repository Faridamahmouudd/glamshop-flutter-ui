import 'package:flutter/material.dart';
import 'makeup_theme.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  String selectedSize = "";

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.size;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final isFav = FavoritesModel.items.contains(p);
    final total = p.price * quantity;

    return Scaffold(
      backgroundColor: kLightPink,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kLightPink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          p.brand,
          style: const TextStyle(
            letterSpacing: 1.0,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: kPrimaryPink,
            ),
            onPressed: () {
              setState(() {
                if (isFav) {
                  FavoritesModel.items.remove(p);
                } else {
                  FavoritesModel.items.add(p);
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== صورة المنتج الكبيرة =====
                  Container(
                    height: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, kCardPink],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Image.asset(
                          p.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // dots تحت الصورة (شكل فقط)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(true),
                      const SizedBox(width: 6),
                      _dot(false),
                      const SizedBox(width: 6),
                      _dot(false),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ===== الاسم + السعر الأساسي =====
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Brightly Serum",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tabs (Description / How to use / Reviews)
                  Row(
                    children: [
                      _tabChip("Description", true),
                      const SizedBox(width: 8),
                      _tabChip("How to use", false),
                      const SizedBox(width: 8),
                      _tabChip("Reviews", false),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Brightly Ever After serum with Niacinamide, Vitamin C "
                        "and Glutathione that helps brighten the skin, fade dark "
                        "spots and even out skin tone. Use daily for best results.",
                    style:
                    TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                  ),
                  const SizedBox(height: 18),

                  // ===== اختيار الحجم =====
                  const Text(
                    "Size",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _sizeChip(widget.product.size),
                      const SizedBox(width: 8),
                      _sizeChip("25 ml"),
                      const SizedBox(width: 8),
                      _sizeChip("35 ml"),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ===== اختيار الكمية =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () {
                                setState(() => quantity++);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Total: \$${total.toStringAsFixed(1)}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryPink,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // ===== Bottom bar (price + add to cart) =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Price",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryPink,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      for (int i = 0; i < quantity; i++) {
                        CartModel.items.add(p);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Added to cart"),
                          duration: Duration(milliseconds: 900),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      backgroundColor: kPrimaryPink,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      width: active ? 18 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? kPrimaryPink : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _tabChip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? kPrimaryPink : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: selected ? Colors.white : Colors.grey[700],
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _sizeChip(String text) {
    final selected = selectedSize == text;
    return GestureDetector(
      onTap: () {
        setState(() => selectedSize = text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? kPrimaryPink.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? kPrimaryPink : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: selected ? kPrimaryPink : Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

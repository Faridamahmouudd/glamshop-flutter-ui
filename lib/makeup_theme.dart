import 'package:flutter/material.dart';

const Color kPrimaryPink = Color(0xFFFF6DAA);
const Color kLightPink   = Color(0xFFFFF7FB);
const Color kCardPink    = Color(0xFFFFE9F4);

String currentUserName = "Glam Girl";

class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String image;       // asset path
  final String description;
  final String size;        // eg. "15 ml"

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.description,
    required this.size,
  });
}

const List<Product> allProducts = [
  Product(
    id: "scarlett_serum",
    name: "Scarlett Whitening Serum",
    brand: "Scarlett",
    price: 10.3,
    image: "assets/images/serum_scarlett.png",
    description:
    "Brightening serum with Niacinamide and Vitamin C that helps fade dark spots and give a healthy glow.",
    size: "15 ml",
  ),
  Product(
    id: "emina_bright",
    name: "Emina Bright Stuff",
    brand: "Emina",
    price: 11.6,
    image: "assets/images/serum_emina.png",
    description:
    "Lightweight brightening serum for daily use, suitable for normal and combination skin.",
    size: "15 ml",
  ),
  Product(
    id: "glow_toner",
    name: "Glow Skin Toner",
    brand: "Scarlett",
    price: 10.0,
    image: "assets/images/toner_glow.png",
    description:
    "Refreshing toner that helps prepare the skin and boost absorption of your next skincare steps.",
    size: "100 ml",
  ),
  Product(
    id: "whip_collagen",
    name: "Whip Collagen Cleanser",
    brand: "Whip",
    price: 3.4,
    image: "assets/images/cleanser.jpg",
    description:
    "Gentle foam cleanser with collagen to clean the skin without stripping moisture.",
    size: "100 ml",
  ),
  Product(
    id: "sakura_mask",
    name: "Sakura White Clay Mask",
    brand: "Garnier",
    price: 4.6,
    image: "assets/images/sakura_mask.jpg",
    description:
    "Clay mask with sakura extract that helps brighten and smooth the skin texture.",
    size: "50 ml",
  ),
];

/// ====== BUNDLES (Kits) ======

const Product bundleGlowRitual = Product(
  id: "bundle_glow_ritual",
  name: "Glow Ritual Bundle",
  brand: "GlamShop Bundle",
  price: 39.9,
  image: "assets/images/bundle1.jpg",   // تأكدي إن الصورة بنفس الاسم
  description:
  "Complete pink skincare ritual with cleansers, toners, creams and mists to give your skin a soft radiant glow.",
  size: "8 products set",
);

const Product bundleSakuraWhite = Product(
  id: "bundle_sakura_white",
  name: "Sakura White Collection",
  brand: "Garnier Sakura",
  price: 34.5,
  image: "assets/images/bundle2.jpg",
  description:
  "Brightening routine with Sakura White cleanser, toner, serum, cream and mask for luminous, even-toned skin.",
  size: "7 products set",
);

const Product bundleSoftPinkCare = Product(
  id: "bundle_soft_pink",
  name: "Soft Pink Care Set",
  brand: "Skin1004 Centella",
  price: 42.0,
  image: "assets/images/bundle3.jpg",
  description:
  "Gentle Centella-based routine including cleanser, toner, ampoule and cream to calm and hydrate sensitive skin.",
  size: "5 products set",
);

/// List of bundles used in Home (Kit Product section)
const List<Product> bundleProducts = [
  bundleGlowRitual,
  bundleSakuraWhite,
  bundleSoftPinkCare,
];


class CartModel {
  static final List<Product> items = [];
}

class FavoritesModel {
  static final List<Product> items = [];
}

ThemeData glamTheme = ThemeData(
  primaryColor: kPrimaryPink,
  scaffoldBackgroundColor: kLightPink,
  useMaterial3: true,
  fontFamily: 'Roboto',
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryPink,
    primary: kPrimaryPink,
    background: kLightPink,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryPink,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  ),
);




class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kCardPink],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ===== IMAGE AREA =====
            SizedBox(
              height: 140,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kLightPink,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: GestureDetector(
                      onTap: onToggleFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: kPrimaryPink,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===== NAME =====
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            // ===== BRAND =====
            Text(
              product.brand,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            // ===== PRICE + ADD BUTTON =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price.toStringAsFixed(1)}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryPink,
                  ),
                ),
                GestureDetector(
                  onTap: onAddToCart,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: kPrimaryPink,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

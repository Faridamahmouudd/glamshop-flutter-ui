import 'package:flutter/material.dart';
import 'makeup_theme.dart';
import 'product_details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final items = FavoritesModel.items;

    return Scaffold(
      backgroundColor: kLightPink,
      appBar: AppBar(
        backgroundColor: kLightPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: items.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet 💗",
          style: TextStyle(color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final p = items[index];
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
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: kCardPink,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      p.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          p.brand,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        FavoritesModel.items.remove(p);
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: kPrimaryPink,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

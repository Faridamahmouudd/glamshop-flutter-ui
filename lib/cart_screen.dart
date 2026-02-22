import 'package:flutter/material.dart';
import 'makeup_theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get total =>
      CartModel.items.fold(0, (sum, p) => sum + p.price);

  @override
  Widget build(BuildContext context) {
    final Map<Product, int> grouped = {};
    for (final p in CartModel.items) {
      grouped[p] = (grouped[p] ?? 0) + 1;
    }
    final entries = grouped.entries.toList();

    return Scaffold(
      backgroundColor: kLightPink,
      appBar: AppBar(
        title: const Text("Cart"),
        leading: Navigator.canPop(context)
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        )
            : null,
      ),
      body: entries.isEmpty
          ? const Center(
        child: Text("Your cart is empty 🛍️"),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: entries.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final entry = entries[index];
                final product = entry.key;
                final qty = entry.value;

                return Dismissible(
                  key: ValueKey(product.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    setState(() {
                      CartModel.items
                          .removeWhere((p) => p == product);
                    });
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.redAccent.withOpacity(0.8),
                    child: const Icon(Icons.delete,
                        color: Colors.white),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: kCardPink,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.brand,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: kLightPink,
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove,
                                              size: 18),
                                          onPressed: () {
                                            setState(() {
                                              final idx = CartModel.items
                                                  .indexOf(product);
                                              if (idx != -1) {
                                                CartModel.items
                                                    .removeAt(idx);
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          qty.toString(),
                                          style: const TextStyle(
                                              fontSize: 14),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add,
                                              size: 18),
                                          onPressed: () {
                                            setState(() {
                                              CartModel.items
                                                  .add(product);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${product.price.toStringAsFixed(1)}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${(product.price * qty).toStringAsFixed(1)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: kPrimaryPink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ====== bottom total + checkout ======
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 18),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Amount Price",
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    AnimatedSwitcher(
                      duration:
                      const Duration(milliseconds: 250),
                      transitionBuilder:
                          (child, animation) =>
                          ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                      child: Text(
                        "\$${total.toStringAsFixed(2)}",
                        key: ValueKey(total),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CheckoutScreen(total: total),
                        ),
                      );
                    },
                    child: const Text("Check Out"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

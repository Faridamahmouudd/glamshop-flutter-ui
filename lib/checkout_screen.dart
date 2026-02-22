import 'package:flutter/material.dart';
import 'makeup_theme.dart';

class CheckoutScreen extends StatelessWidget {
  final double total;

  const CheckoutScreen({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightPink,
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping address",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: kPrimaryPink),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Add your shipping address here\nCity, Country",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: kPrimaryPink),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Payment method",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                _PaymentTile(
                  icon: Icons.credit_card,
                  title: "Credit / Debit card",
                  subtitle: "**** **** **** 1234",
                  selected: true,
                ),
                const SizedBox(height: 8),
                _PaymentTile(
                  icon: Icons.paypal,
                  title: "PayPal",
                  subtitle: "example@mail.com",
                  selected: false,
                ),
                const SizedBox(height: 8),
                _PaymentTile(
                  icon: Icons.attach_money,
                  title: "Cash on delivery",
                  subtitle: "Pay with cash",
                  selected: false,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Order summary",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _SummaryRow(label: "Subtotal", value: total),
            const SizedBox(height: 4),
            _SummaryRow(label: "Shipping", value: 3.50),
            const SizedBox(height: 4),
            _SummaryRow(label: "Tax", value: total * 0.05),
            const Divider(height: 24),
            _SummaryRow(
              label: "Total",
              value: total + 3.50 + total * 0.05,
              isBold: true,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // UI فقط – نعتبر الأوردر اتعمل
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: const Text("Order placed 🎉"),
                      content: const Text(
                        "Your glam products are on the way!",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx); // يقفل الـ Dialog
                            Navigator.pop(context); // يرجع للـ Cart
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Place order"),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                "This is UI only (no real payment).",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;

  const _PaymentTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? kPrimaryPink : Colors.grey.shade300,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: kCardPink,
            child: Icon(icon, color: kPrimaryPink, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle, color: kPrimaryPink)
          else
            const Icon(Icons.radio_button_off,
                color: Colors.grey),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: style,
        ),
      ],
    );
  }
}

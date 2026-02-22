import 'package:flutter/material.dart';
import 'makeup_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightPink,
      appBar: AppBar(
        backgroundColor: kLightPink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // ===== Avatar + name =====
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, kCardPink],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: const CircleAvatar(
                  radius: 48,
                  backgroundColor: kLightPink,
                  backgroundImage:
                  AssetImage('assets/images/profile_avatar.jpeg'),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: kPrimaryPink,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            currentUserName.isEmpty ? "Glam Girl" : currentUserName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle, size: 8, color: kPrimaryPink),
              SizedBox(width: 6),
              Text(
                "Normal Skin",
                style: TextStyle(
                  fontSize: 12,
                  color: kPrimaryPink,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ===== List options =====
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ListView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                children: [
                  _ProfileItem(
                    icon: Icons.lock_outline,
                    label: "Privacy & Setting",
                  ),
                  _ProfileItem(
                    icon: Icons.notifications_none,
                    label: "Notifications",
                  ),
                  _ProfileItem(
                    icon: Icons.face_retouching_natural_outlined,
                    label: "Skin Type Quiz",
                  ),
                  _ProfileItem(
                    icon: Icons.history,
                    label: "Order History",
                  ),
                  _ProfileItem(
                    icon: Icons.location_on_outlined,
                    label: "Shipping Address",
                  ),
                  const SizedBox(height: 24),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                            (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout, color: Colors.redAccent),
                    label: const Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      alignment: Alignment.centerLeft,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: kLightPink,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: kPrimaryPink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

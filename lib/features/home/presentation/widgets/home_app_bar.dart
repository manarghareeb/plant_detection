import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.name, required this.onSelected});
  final String name;
  final void Function(String T) onSelected;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/default_profile.png"),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.menu, color: Colors.black),
            onSelected: onSelected,
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: "Home",
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.black),
                    title: Text("Home"),
                  ),
                ),
                PopupMenuItem(
                  value: "Edit Profile",
                  child: ListTile(
                    leading: Icon(Icons.person_rounded, color: Colors.black),
                    title: Text("Edit Profile"),
                  ),
                ),
                PopupMenuItem(
                  value: "Logout",
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text("Logout"),
                  ),
                ),
              ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

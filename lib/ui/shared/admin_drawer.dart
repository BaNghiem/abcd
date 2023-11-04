import 'package:flutter/material.dart';
import 'package:myshop/ui/products/admin_products_screen.dart';
import '../auth/auth_manager.dart';
import 'package:provider/provider.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Admin!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manager Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AdminProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}

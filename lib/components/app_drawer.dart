import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thel_dawasa/components/widgets/developer_info.dart';
import 'package:thel_dawasa/providers/theme_provider.dart';
import 'package:thel_dawasa/providers/language_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LanguageProvider>(context);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.yellow[800]),
            accountName: Text(
              langProvider.getText('app_title'),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            accountEmail: const Text(
              "Fuel Day Checker for Sri Lankans",
              style: TextStyle(color: Colors.black87),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.local_gas_station,
                color: Colors.yellow,
                size: 40,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text('Dark Mode'),
            trailing: Switch.adaptive(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          const Divider(height: 0.1),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(langProvider.getText('language')),
            trailing: DropdownButton<AppLanguage>(
              value: langProvider.currentLanguage,
              underline: const SizedBox(),
              onChanged: (AppLanguage? newValue) {
                if (newValue != null) {
                  langProvider.setLanguage(newValue);
                }
              },
              items: [
                DropdownMenuItem(
                  value: AppLanguage.sinhala,
                  child: Text('සිංහල'),
                ),
                DropdownMenuItem(
                  value: AppLanguage.tamil,
                  child: Text('தமிழ்'),
                ),
                DropdownMenuItem(
                  value: AppLanguage.english,
                  child: Text('English'),
                ),
              ],
            ),
          ),
          const Divider(height: 0.1),
          const Spacer(),
          const Divider(height: 0.1),
          Padding(padding: const EdgeInsets.all(16.0), child: DeveloperInfo()),
        ],
      ),
    );
  }
}

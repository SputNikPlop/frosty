import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frosty/core/auth/auth_store.dart';
import 'package:frosty/screens/settings/stores/settings_store.dart';
import 'package:frosty/screens/settings/widgets/blocked_users.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AccountSettings extends StatelessWidget {
  final SettingsStore settingsStore;
  final AuthStore authStore;

  const AccountSettings({
    Key? key,
    required this.settingsStore,
    required this.authStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => ExpansionTile(
        leading: const Icon(Icons.account_circle),
        title: const Text(
          'Account',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          ProfileCard(authStore: authStore),
          if (authStore.isLoggedIn) ...[
            ListTile(
              title: const Text('Blocked Users'),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlockedUsers(
                    authStore: authStore,
                  ),
                ),
              ),
            ),
            ListTile(
              isThreeLine: true,
              title: const Text('Log in to WebView'),
              subtitle: const Text('Lets you avoid ads on your subscribed streamers or if you have Turbo.'),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Log in to WebView'),
                      ),
                      body: const WebView(
                        initialUrl: 'https://www.twitch.tv/login',
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final AuthStore authStore;

  const ProfileCard({Key? key, required this.authStore}) : super(key: key);

  Future<void> _showLoginDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          ColoredBox(
            color: const Color.fromRGBO(145, 70, 255, 0.8),
            child: SimpleDialogOption(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/TwitchGlitchWhite.png',
                    height: 25,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Connect with Twitch',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                authStore.login();
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              'Or',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 5.0),
          SimpleDialogOption(
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Token',
              ),
              onSubmitted: (token) {
                authStore.login(customToken: token);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              authStore.logout();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Observer(
        builder: (context) {
          if (authStore.error != null) {
            return ListTile(
              title: const Text('Failed to Connect'),
              trailing: OutlinedButton(
                onPressed: authStore.init,
                child: const Text('Try Again'),
              ),
            );
          }
          if (authStore.isLoggedIn && authStore.user.details != null) {
            return ListTile(
              leading: CircleAvatar(
                foregroundImage: CachedNetworkImageProvider(authStore.user.details!.profileImageUrl),
              ),
              title: Text(authStore.user.details!.displayName),
              trailing: ElevatedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Log Out'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            );
          }
          return ListTile(
            isThreeLine: true,
            leading: const Icon(
              Icons.no_accounts,
              size: 40,
            ),
            title: const Text('Anonymous User'),
            subtitle: const Text('Log in to chat, view followed streams, and more.'),
            trailing: OutlinedButton(
              onPressed: () => _showLoginDialog(context),
              child: const Text('Log In'),
            ),
          );
        },
      ),
    );
  }
}

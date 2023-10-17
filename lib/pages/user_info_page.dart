import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sevensalta/generated/locale_keys.g.dart';
import '../model/user.dart';

class UserInfoPage extends StatelessWidget {
  final User userInfo;
  const UserInfoPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_info.tr()),
        centerTitle: true,
        leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                        Navigator.pop(context);
                    },
                ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            _buildUserInfoTile(
              icon: Icons.account_circle_outlined,
              title: userInfo.name ?? 'Не указано',
              subtitle: userInfo.story,
              trailing: userInfo.country,
            ),
            Divider(),
            _buildUserInfoTile(
              icon: Icons.phone_enabled_outlined,
              title: userInfo.phone ?? 'Не указано',
            ),
            const Divider(),
            _buildUserInfoTile(
              icon: Icons.mail_outline,
              title: (userInfo.email?.isEmpty ?? true) ? 'Не указано' : userInfo.email!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTile({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing != null ? Text(trailing) : null,
    );
  }
}

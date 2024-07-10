import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/model/user_model.dart';

class InforUser extends StatelessWidget {
  const InforUser({super.key, required this.users});
  final UserModel users;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          users.image ?? '',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(users.name ?? ''),
      subtitle: Text(users.mail ?? ''),
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.showInfor, arguments: users);
      },
    );
  }
}

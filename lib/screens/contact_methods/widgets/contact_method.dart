import 'package:flutter/material.dart';

class ContactMethodItem extends StatelessWidget {
  final String name, number;
  final String? email;

  const ContactMethodItem({
    super.key,
    required this.name,
    required this.number,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 17,
      ),
      title: Text(
        name,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFFAAAAAA)),
      ),
      subtitle: Text(
        number,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(color: Color(0xFFAAAAAA)),
      ),
      leading: CircleAvatar(
        backgroundColor: const Color(0xffD9D9D9),
        child: Image.asset(
          'assets/notificaions.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

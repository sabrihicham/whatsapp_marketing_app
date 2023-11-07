import 'package:flutter/material.dart';
import '../../../util/helper/media_query.dart';

class GroupItem extends StatelessWidget {
  final String name, numberOfUsers;
  final String? email;
  final void Function()? onTap;
  const GroupItem(
      {super.key,
      required this.name,
      required this.numberOfUsers,
      this.email,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 17,
      ),
      title: Text(
        name,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      trailing: SizedBox(
        width: context.getWidth() / 5,
        child: IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.message_rounded),
        ),
        // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ),
      leading: const Icon(Icons.person_rounded),
      subtitle: Text(
        '$numberOfUsers   المستلمون',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(color: Color(0xFFAAAAAA)),
      ),
    );
  }
}

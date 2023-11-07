import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_marketing/screens/packages_screen/screens/add_discount_code.dart';
import 'package:whatsapp_marketing/util/helper/media_query.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../../controller/langs.dart';

class PackageItem extends StatelessWidget {
  final int index;
  final String type, price, details;
  const PackageItem({
    super.key,
    required this.index,
    required this.type,
    required this.price,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return SizedBox(
      width: context.getWidth() / 1.88,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),
          color:
              index.isEven ? const Color(0xff4AA5EF) : const Color(0xffF9DB09),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Column(
              children: [
                Text(
                  '$type\n$price',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  details,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFD9D9D9),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                ElevatedButton(
                  onPressed: () => context.goTo(DiscoundCode(
                    packageName: type,
                    packagePrice: price,
                  )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffF97C09),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          9,
                        ),
                      ),
                    ),
                  ),
                  child: Text(langsController
                      .langs[langsController.lang ?? 'ar']!['enable']!),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

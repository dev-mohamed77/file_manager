import 'package:exfile/shared/utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoriesSectionItems extends StatelessWidget {
  const CategoriesSectionItems({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    required this.tap,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String title;
  final void Function()? tap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(ctx: context);
    return InkWell(
      onTap: tap,
      child: Row(
        children: [
          Container(
            width: SizeConfig.defaultSize! * 4.9,
            height: SizeConfig.defaultSize! * 4.9,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          SizedBox(
            width: SizeConfig.defaultSize! * 2,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 17,
                ),
          )
        ],
      ),
    );
  }
}

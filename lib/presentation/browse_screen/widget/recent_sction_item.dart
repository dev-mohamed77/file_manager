import 'package:exfile/shared/utils/size_config.dart';
import 'package:flutter/material.dart';

class RecentSectionItems extends StatelessWidget {
  const RecentSectionItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(ctx: context);
    return SizedBox(
      height: SizeConfig.defaultSize! * 8,
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: const Color(0xff222F53).withOpacity(.4),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Container(
                width: SizeConfig.defaultSize! * 5.9,
                height: SizeConfig.defaultSize! * 5.9,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  border: Border.all(
                      color: const Color(0xff222F53).withOpacity(.2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.image,
                  size: 30,
                  color: Colors.purple,
                ),
              ),
              SizedBox(
                width: SizeConfig.defaultSize! * 1.5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Eldoksh.jpg",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "24MB",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 12),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "21 JUNE, 2021",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

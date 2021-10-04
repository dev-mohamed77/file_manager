import 'package:exfile/presentation/browse_screen/widget/section_storage_item.dart';
import 'package:exfile/shared/cubit/exfile_cubit/exfile_cubit.dart';
import 'package:exfile/shared/utils/size_config.dart';
import 'package:flutter/material.dart';

class StoregeSection extends StatelessWidget {
  const StoregeSection({Key? key, required this.xeFileCubit}) : super(key: key);
  final XeFileCubit xeFileCubit;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(ctx: context);
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.defaultSize! * 13,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index) {
          var item = xeFileCubit.availableStorage[index];
          var path = item.path.split("Android")[0];

          return SectionStorageItem(
            icon: index == 0 ? Icons.phone_android : Icons.sd_card,
            iconColor: Colors.red,
            storageName: index == 0 ? "Internal Storage" : "SD Card",
            totalStoarge: 32,
            usedStorage: 12,
            parcent: 0.6,
            path: path,
          );
        },
        itemCount: XeFileCubit.get(context).availableStorage.length,
      ),
    );
  }

  calculatePercent(int usedSpace, int totalSpace) {
    return double.parse((usedSpace / totalSpace * 100).toStringAsFixed(0)) /
        100;
  }
}

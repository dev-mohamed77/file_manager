import 'package:exfile/presentation/browse_screen/widget/recent_sction_item.dart';
import 'package:flutter/material.dart';

class RecentSection extends StatelessWidget {
  const RecentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return const RecentSectionItems();
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 1,
        );
      },
    );
  }
}

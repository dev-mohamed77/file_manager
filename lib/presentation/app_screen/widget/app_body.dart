import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeAppIcons: true,
        includeSystemApps: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Application>? data = snapshot.data;
          data!.sort((app1, app2) =>
              app1.appName.toLowerCase().compareTo(app2.appName.toLowerCase()));
          snapshot.data;
          return ListView.separated(
              itemBuilder: (context, index) {
                Application app = data[index];
                return ListTile(
                  leading: app is ApplicationWithIcon
                      ? Image.memory(
                          app.icon,
                          height: 40,
                          width: 40,
                        )
                      : null,
                  title: Text(app.appName),
                  subtitle: Text(app.packageName),
                  onTap: () => DeviceApps.openApp(app.packageName),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemCount: data.length);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

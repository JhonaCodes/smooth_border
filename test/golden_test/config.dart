import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void runGoldenTest(
  List<Widget> scenarios, {
  required String groupName,
  required String goldenName,
  required String fileName,
  int? columns,
  double? fixedWidth,
}) {
  group(groupName, () {
    TestWidgetsFlutterBinding.ensureInitialized();

    setUpAll(() async {
      final fontLoader = FontLoader('Roboto');
      await fontLoader.load();
    });

    return AlchemistConfig.runWithConfig(
      config: AlchemistConfig(
        forceUpdateGoldenFiles: true,
        theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
        goldenTestTheme: GoldenTestTheme(
          backgroundColor: Colors.white,
          borderColor: Colors.grey.shade300,
          nameTextStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 10,
            color: Colors.black87,
          ),
        ),
        platformGoldensConfig: const PlatformGoldensConfig(
          enabled: true,
          renderShadows: true,
        ),
        ciGoldensConfig: const CiGoldensConfig(enabled: false),
      ),
      run: () {
        goldenTest(
          goldenName,
          fileName: fileName,
          pumpBeforeTest: precacheImages,
          builder: () => GoldenTestGroup(
            columns: columns,
            columnWidthBuilder:
                fixedWidth != null ? (_) => FixedColumnWidth(fixedWidth) : null,
            children: scenarios,
          ),
        );
      },
    );
  });
}

GoldenTestScenario scenario(String name, Widget child) => GoldenTestScenario(
  name: name,
  child: Padding(padding: const EdgeInsets.all(16), child: child),
);

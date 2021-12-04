import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../services/firebase/auth_service.dart';
import '../../generated/locale_keys.g.dart';
import '../screens/drawer/contant_us_screen.dart';
import '../../data/local/local_data.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: Colors.cyan),
            child: Column(
              children: [
                Flexible(
                  child: Image.asset("assets/images/logo.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                    child: Text(
                  LocaleKeys.title.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontStyle: FontStyle.italic),
                ))
              ],
            )),
        const SizedBox(
          height: 30,
        ),
        _listTiles(
            label: LocaleKeys.contantUs.tr(),
            function: () {
              _navigateToTaskScreen(context);
            },
            icon: Icons.contact_page),
        const Divider(
          thickness: 1,
        ),
        _listTiles(
            label: LocaleKeys.logoutPage.tr(),
            function: () {
              _logout(context);
            },
            icon: Icons.logout_outlined),
        const Divider(
          thickness: 1,
        ),
        _listTiles(
          function: () {},
          icon: Icons.language,
          label: 'language',
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              LanguageButton(
                locale: context.locale.languageCode,
                value: 'ar',
              ),
              const SizedBox(width: 30),
              LanguageButton(
                locale: context.locale.languageCode,
                value: 'en',
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        Consumer(
          builder: (context, ref, child) {
            final theme = ref.watch(themeProvider);
            return Center(
              child: ListTileSwitch(
                value: theme.darkTheme!,
                leading: const Icon(
                  Icons.nightlight_round_outlined,
                ),
                onChanged: (value) => theme.toggleTheme(),
                visualDensity: VisualDensity.comfortable,
                switchType: SwitchType.cupertino,
                switchActiveColor: Colors.indigo,
                title: const Text('Dark theme'),
              ),
            );
          },
        ),
      ],
    ));
  }

  void _navigateToTaskScreen(context) {
      Navigator.pushNamed(
                                  context, ContantUsScreen.id);
     
  }

  void _logout(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://image.flaticon.com/icons/png/128/1252/1252006.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleKeys.signup.tr(),
                  ),
                ),
              ],
            ),
            content: Text(
              LocaleKeys.doYou.tr(),
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await AuthService.signOut(context);
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Text(
                    LocaleKeys.yes.tr(),
                    style: const TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  Widget _listTiles(
      {required String label,
      required Function function,
      required IconData icon}) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Icon(
        icon,
        color: Colors.pink.shade500,
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    Key? key,
    required this.locale,
    required this.value,
  }) : super(key: key);
  final String locale;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 40,
        child: MaterialButton(
          color: Colors.white,
          onPressed: () {
            context.setLocale(Locale(value));
          },
          child: Text(
            tr(value),
            style: TextStyle(
              color: locale == value ? Colors.red : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

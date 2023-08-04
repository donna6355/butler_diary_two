import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../../data/hive_storage.dart';
import '../../data/model/profile.dart';

class NoCat extends StatelessWidget {
  const NoCat({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Image.asset(Img.noCat, width: 150)),
          ), // need to change
          const Text(Lang.noCat, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.profile, {super.key});
  final Profile profile;

  Future<void> _removeProfile({
    required BuildContext context,
    required Profile profile,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => DeleteAlert(profile),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(NamedRoutes.profile, arguments: profile);
            },
            child: Text(profile.name, style: const TextStyle(fontSize: 20)),
          ),
          IconButton(
            onPressed: () => _removeProfile(context: context, profile: profile),
            icon: const Icon(
              Icons.cancel,
              size: 15,
              color: CommonStyle.primaryGray,
            ),
          )
        ],
      ),
    );
  }
}

class DeleteAlert extends StatelessWidget {
  const DeleteAlert(this.profile, {super.key});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${profile.name} 프로필 지우기'),
      content: const Text(Lang.cantRestore),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text(Lang.cancel),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await HiveStore.deleteCatProfile(profile.id);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(NamedRoutes.home, (route) => false);
          },
          child: const Text(Lang.confirm),
        ),
      ],
    );
  }
}

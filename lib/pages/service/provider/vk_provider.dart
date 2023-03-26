import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';

class VK_Provider {
  final plugin = VKLogin(debug: true);
  final vk = VKLogin();
  var appId = '7503887';

  String? _sdkVersion;
  VKAccessToken? _token;
  VKUserProfile? _profile;
  String? _email;
  bool _sdkInitialized = false;

  getVKLogin() async {
    final res = await vk.initSdk();
    await vk.logIn(scope: [
      VKScope.email,
      VKScope.friends,
    ]);

    if (res.isError) {
      print(res.asError);
    } else {}
  }

  Future<void> _onPressedLogInButton(BuildContext context, setState) async {
    final res = await plugin.logIn(scope: [
      VKScope.email,
    ]);

    if (res.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log In failed: ${res.asError!.error}'),
        ),
      );
    } else {
      final loginResult = res.asValue!.value;
      if (!loginResult.isCanceled) await _updateLoginInfo(setState);
    }
  }

  Future<void> _onPressedLogOutButton(setState) async {
    await plugin.logOut();
    await _updateLoginInfo(setState);
  }

  Future<void> _initSdk(setState) async {
    await plugin.initSdk();
    _sdkInitialized = true;
    await _updateLoginInfo(setState);
  }

  Future<void> _getSdkVersion(setState) async {
    final sdkVersion = await plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo(setState) async {
    if (!_sdkInitialized) return;
    final token = await plugin.accessToken;
    final profileRes = token != null ? await plugin.getUserProfile() : null;
    final email = token != null ? await plugin.getUserEmail() : null;

    setState(() {
      _token = token;
      _profile = profileRes?.asValue?.value;
      _email = email;
    });
  }
}

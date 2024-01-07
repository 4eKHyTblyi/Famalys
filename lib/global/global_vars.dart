//NOTIFICATIONS

import 'package:shared_preferences/shared_preferences.dart';

bool SWITCH = true;
bool COMMENTS = true;
bool REACTIONS = true;
bool PUBLICATION = true;
bool CHATS = true;
bool MESSENGER = true;

SharedPreferences? sharedPreferences;

String global_fio = '';
String global_avatar = '';
String global_nickname = '';
String global_description = '';
String global_email = '';
String global_phone = '';

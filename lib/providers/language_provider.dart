import 'package:flutter/material.dart';

enum AppLanguage { sinhala, tamil, english }

class LanguageProvider with ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.sinhala;

  AppLanguage get currentLanguage => _currentLanguage;

  void setLanguage(AppLanguage language) {
    _currentLanguage = language;
    notifyListeners();
  }

  String getText(String key) {
    return _localizedValues[_currentLanguage]?[key] ?? key;
  }

  static const Map<AppLanguage, Map<String, String>> _localizedValues = {
    AppLanguage.sinhala: {
      'app_title': 'තෙල් දවස ⛽',
      'app_description': 'මාර පෝලිමක්නේ මේක....',
      'eligibility_question': 'අද ඔයාට තෙල් ගහන්න\nපුලුවන්ද බලමුද?',

      'tamil': 'தமிழ்',
      'english': 'English',
      'language': 'භාෂාව',

      'scan_button': 'අංක තහඩුව ස්කෑන් කරන්න!',
      'camera_permission_denied':
          'කැමරා Permission නැතුව Scan කරන්න බෑ මහත්තයෝ!',

      'fuel_success_title': 'හුරේ....!\nඅද ඔයාට තෙල් ගහන්න පුළුවන් ',
      'fuel_success_description': 'යන්න, ගිහින් තෙල් ගහන් එන්න',
      'fuel_fail_title': 'කණගාටුයි!\nඅද ඔයාට තෙල් ගහන්න බෑ',
      'fuel_fail_description': 'අද ඔයාට තෙල් නෑ. ගිහින් තේ එකක් බොන්න. ☕',

      'eligibility_dates': 'ඉදිරියට ඔබට තෙල් ගහන්න පුළුවන් දවස්',

      'add_to_calendar': 'දින දර්ශනයට එක් කරන්න',
      'remind_me': 'මතක් කරන්න (Notification)',
      'remind_success': 'මතක් කිරීම සාර්ථකයි! උදේ 6ට කියන්නම්.',
      'calendar_success': 'දින දර්ශනයට එක් කළා!',
      'fuel_day': 'තෙල් ගහන දවස',

      'capture_btn_text': 'හරි ✅',
      'capture_error_text': 'හතලිස් ඇඳිරියද කොහෙද මට පේන්නෑ හරියට',
      'finish': 'ඉවර කරන්න',
    },
    AppLanguage.tamil: {},
    AppLanguage.english: {},
  };
}

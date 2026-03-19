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
    AppLanguage.tamil: {
      'app_title': 'தெல் தவஸ ⛽',
      'app_description': 'என்ன ஒரு நீண்ட வரிசை....',
      'eligibility_question':
          'இன்று நீங்கள் எரிபொருள் நிரப்ப முடியுமா என்று பார்ப்போமா?',

      'tamil': 'தமிழ்',
      'english': 'English',
      'language': 'மொழி',

      'scan_button': 'எண் பலகையை ஸ்கேன் செய்யுங்கள்!',
      'camera_permission_denied':
          'கேமரா அனுமதி இல்லாமல் ஸ்கேன் செய்ய முடியாது ஐயா!',

      'fuel_success_title': 'ஹுரே....!\nஇன்று நீங்கள் எரிபொருள் நிரப்பலாம்',
      'fuel_success_description': 'போய் எரிபொருள் நிரப்பிவிட்டு வாருங்கள்',
      'fuel_fail_title':
          'வருந்துகிறோம்!\nஇன்று நீங்கள் எரிபொருள் நிரப்ப முடியாது',
      'fuel_fail_description':
          'இன்று உங்களுக்கு எரிபொருள் இல்லை. போய் ஒரு தேநீர் குடியுங்கள். ☕',

      'eligibility_dates': 'நீங்கள் எரிபொருள் நிரப்பக்கூடிய எதிர்வரும் நாட்கள்',

      'add_to_calendar': 'நாட்காட்டியில் சேர்க்கவும்',
      'remind_me': 'எனக்கு நினைவூட்டு (அறிவிப்பு)',
      'remind_success':
          'நினைவூட்டல் வெற்றிகரமாக அமைக்கப்பட்டது! காலை 6 மணிக்குச் சொல்கிறேன்.',
      'calendar_success': 'நாட்காட்டியில் சேர்க்கப்பட்டது!',
      'fuel_day': 'எரிபொருள் தினம்',

      'capture_btn_text': 'சரி ✅',
      'capture_error_text':
          'எனது கண்பார்வை சரியில்லையா அல்லது என்னவென்று தெரியவில்லை, சரியாகத் தெரியவில்லை',
      'finish': 'முடிக்கவும்',
    },
    AppLanguage.english: {
      'app_title': 'Thel Dawasa ⛽',
      'app_description': 'What a long queue this is....',
      'eligibility_question': 'Shall we see if you can pump fuel today?',

      'tamil': 'தமிழ்',
      'english': 'English',
      'language': 'Language',

      'scan_button': 'Scan the Number Plate!',
      'camera_permission_denied': 'Cannot scan without camera permission, sir!',

      'fuel_success_title': 'Hurray....!\nYou can pump fuel today',
      'fuel_success_description': 'Go, go and pump some fuel',
      'fuel_fail_title': 'Sorry!\nYou cannot pump fuel today',
      'fuel_fail_description': 'No fuel for you today. Go and have a tea. ☕',

      'eligibility_dates': 'Upcoming days you can pump fuel',

      'add_to_calendar': 'Add to Calendar',
      'remind_me': 'Remind Me (Notification)',
      'remind_success': 'Reminder set successfully! I will tell you at 6 AM.',
      'calendar_success': 'Added to Calendar!',
      'fuel_day': 'Fuel Day',

      'capture_btn_text': 'Okay ✅',
      'capture_error_text': 'Is it my eyesight or what, I can\'t see properly',
      'finish': 'Finish',
    },
  };
}

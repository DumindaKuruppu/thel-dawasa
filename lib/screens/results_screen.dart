import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';
import 'package:thel_dawasa/providers/language_provider.dart';
import 'package:thel_dawasa/services/notification_service.dart';

import '../core/widgets/app_bar.dart';

class ResultScreen extends StatelessWidget {
  final bool success;
  final int lastDigit;

  const ResultScreen({
    super.key,
    required this.success,
    required this.lastDigit,
  });

  List<DateTime> _getNextEligibilityDates() {
    List<DateTime> dates = [];
    DateTime now = DateTime.now();
    bool isDigitEven = lastDigit % 2 == 0;

    for (int i = 0; i < 30; i++) {
      DateTime date = now.add(Duration(days: i));
      // Only show future dates (starting from today if eligible, or tomorrow)
      if (i == 0 && !success) continue;

      bool isDateEven = date.day % 2 == 0;
      if (isDigitEven == isDateEven) {
        dates.add(date);
      }
      if (dates.length >= 3) break;
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final theme = Theme.of(context);
    final futureDates = _getNextEligibilityDates();

    return Scaffold(
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              // Result Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: success
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: success ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      success
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      size: 80,
                      color: success ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      success
                          ? langProvider.getText('fuel_success_title')
                          : langProvider.getText('fuel_fail_title'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: success ? Colors.green : Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      success
                          ? langProvider.getText('fuel_success_description')
                          : langProvider.getText('fuel_fail_description'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Future Dates Header
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  langProvider.getText('eligibility_dates'),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Dates List
              ...futureDates.map((date) {
                String formattedDate = DateFormat('EEEE, MMM d').format(date);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, size: 20),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          formattedDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Add to Calendar
                      IconButton(
                        icon: const Icon(Icons.add_task),
                        tooltip: langProvider.getText('add_to_calendar'),
                        onPressed: () {
                          final Event event = Event(
                            title: 'Thel Dawasa (Fuel Day)',
                            description:
                                'Malli, ada oyaata thel gahanna puluwan dawasa!',
                            location: 'Fuel Station',
                            startDate: DateTime(
                              date.year,
                              date.month,
                              date.day,
                              6,
                              0,
                            ),
                            endDate: DateTime(
                              date.year,
                              date.month,
                              date.day,
                              22,
                              0,
                            ),
                          );
                          Add2Calendar.addEvent2Cal(event);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content: Text(
                                langProvider.getText('calendar_success'),
                              ),
                            ),
                          );
                        },
                      ),
                      // Remind Me
                      IconButton(
                        icon: const Icon(Icons.notifications_active),
                        tooltip: langProvider.getText('remind_me'),
                        onPressed: () async {
                          await NotificationService().scheduleFuelNotification(
                            date,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content: Text(
                                langProvider.getText('remind_success'),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(langProvider.getText('finish')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

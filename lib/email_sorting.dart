// email_sorting.dart

import 'models/emaildata.dart';

class EmailSorting {
  static List<EmailData> sortEmails(List<EmailData> emails, String category) {
    List<EmailData> filteredList = [];

    switch (category) {
      case 'academics':
        filteredList = emails.where((email) =>
        email.sender.contains('HOD') ||
            email.sender.contains('Dean')).toList();
        break;
      case 'hostel':
        filteredList = emails.where((email) =>
        email.sender.contains('Hostel') ||
            email.sender.contains('Warden')).toList();
        break;
      case 'career':
        filteredList = emails.where((email) =>
        email.sender.contains('VITTBI') ||
            email.sender.contains('Placement') ||
            email.sender.contains('IR')).toList();
        break;
      case 'events':
        filteredList = emails.where((email) =>
        email.sender.contains('Student Welfare') ||
            email.sender.contains('Riviera') ||
            email.subject.toLowerCase().contains('riviera') ||
            email.sender.contains('Gravitas') ||
            email.subject.toLowerCase().contains('gravitas')).toList();
        break;
      case 'misc':
        filteredList = emails.where((email) =>
        email.sender.contains('Viswanathan') ||
            email.sender.contains('PROVC') ||
            email.sender.contains('Chancellor') ||
            email.sender.contains('Vice Chancellor') ||
            email.sender.contains('Periyar') ||
            email.sender.contains('Duolingo') ||
            email.sender.contains('Google') ||
            email.subject.toLowerCase().contains('greetings') ||
            email.body.toLowerCase().contains('quiz') ||
            email.subject.toLowerCase().contains('quiz') ||
            email.body.toLowerCase().contains('notes') ||
            email.subject.toLowerCase().contains('notes')).toList();
        break;
    }

    return filteredList;
  }
}

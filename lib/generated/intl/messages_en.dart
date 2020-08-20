// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(distantCount) => "${distantCount} away";

  static m1(day) => "Day ${day}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "AM" : MessageLookupByLibrary.simpleMessage("AM"),
    "Friday" : MessageLookupByLibrary.simpleMessage("Friday"),
    "Monday" : MessageLookupByLibrary.simpleMessage("Monday"),
    "OK" : MessageLookupByLibrary.simpleMessage("OK"),
    "PM" : MessageLookupByLibrary.simpleMessage("PM"),
    "Saturday" : MessageLookupByLibrary.simpleMessage("Saturday"),
    "Sunday" : MessageLookupByLibrary.simpleMessage("Sunday"),
    "Thursday" : MessageLookupByLibrary.simpleMessage("Thursday"),
    "Tuesday" : MessageLookupByLibrary.simpleMessage("Tuesday"),
    "Wednesday" : MessageLookupByLibrary.simpleMessage("Wednesday"),
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "comment" : MessageLookupByLibrary.simpleMessage("Comment"),
    "distant" : m0,
    "favorite" : MessageLookupByLibrary.simpleMessage("Favorite"),
    "minute" : MessageLookupByLibrary.simpleMessage("minute"),
    "navigation" : MessageLookupByLibrary.simpleMessage("Navigation"),
    "new_schedule" : MessageLookupByLibrary.simpleMessage("New Schedule"),
    "no_data" : MessageLookupByLibrary.simpleMessage("No Data"),
    "opening_time" : MessageLookupByLibrary.simpleMessage("Opening Time"),
    "phone" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "position" : MessageLookupByLibrary.simpleMessage("Position"),
    "schedule" : MessageLookupByLibrary.simpleMessage("Schedule"),
    "schedule_day" : m1,
    "search" : MessageLookupByLibrary.simpleMessage("Search"),
    "search_hint" : MessageLookupByLibrary.simpleMessage("Please enter address or place name"),
    "search_web" : MessageLookupByLibrary.simpleMessage("Search"),
    "start_time" : MessageLookupByLibrary.simpleMessage("Start time"),
    "stay_time" : MessageLookupByLibrary.simpleMessage("Stay time")
  };
}

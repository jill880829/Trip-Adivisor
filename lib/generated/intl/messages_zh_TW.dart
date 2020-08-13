// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static m0(distantCount) => "距離 ${distantCount}";

  static m1(day) => "第 ${day} 天";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "AM" : MessageLookupByLibrary.simpleMessage("上午"),
    "OK" : MessageLookupByLibrary.simpleMessage("確認"),
    "PM" : MessageLookupByLibrary.simpleMessage("下午"),
    "about" : MessageLookupByLibrary.simpleMessage("約"),
    "account" : MessageLookupByLibrary.simpleMessage("個人資料"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "distant" : m0,
    "minute" : MessageLookupByLibrary.simpleMessage("分鐘"),
    "new_schedule" : MessageLookupByLibrary.simpleMessage("新增行程"),
    "schedule" : MessageLookupByLibrary.simpleMessage("行程規劃"),
    "schedule_day" : m1,
    "search" : MessageLookupByLibrary.simpleMessage("景點搜尋"),
    "search_hint" : MessageLookupByLibrary.simpleMessage("請輸入地址 \\ 名稱"),
    "start_time" : MessageLookupByLibrary.simpleMessage("出發時間"),
    "stay_time" : MessageLookupByLibrary.simpleMessage("停留時間")
  };
}

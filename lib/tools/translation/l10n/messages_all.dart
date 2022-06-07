import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'messages_ar.dart' as messages_ar;
import 'messages_en.dart' as messages_en;
import 'package:intl/src/intl_helpers.dart';

typedef LibraryLoader = Future<dynamic> Function();

Map<String, LibraryLoader> _deferredLibraries = {
  'ar': () => Future.value(null),
  'en': () => Future.value(null),
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    default:
      return messages_en.messages;
  }
}

Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());
  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

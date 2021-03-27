/// Convert a List from one type to another skipping al those elements
/// not compatible with the target type.
///
/// List fool = ['foo', 10, null];
/// List<String> dest = convertListToType<String>(fool);
/// ** output: dest -> ['foo']
///
/// optional - if a discarded list is passed, the method will add to it
///      all elements of the origin list that are not of the target type.
///      The discarded list must be of the same type of the origin, (or dynamic)
///      and it is cleaned while starting, so any contained value is lost.
///
///
/// List fool = ['foo', 10, null];
/// var discarded = [];
/// List<String> dest = convertListToType<String>(fool,
///    discardedList: discarded);
/// ** output: dest -> ['foo']
/// **         discarded -> [10, null]
///
///
/// At 2.12.2 time it can give problem with lists of complex sub types.
/// I they are inferred by the system, the seems to be ok,
/// if you define a specific type, the sub elements are set as that type.
/// *** open issue request
List<T> convertListToType<T>(List origin, {List? discardedList}) {
  var saveDiscarded = false;

  if (discardedList == null) {
    return <T>[
      for (var element in origin)
        if (element is T) element
    ];
  }

  saveDiscarded = true;
  discardedList.clear();

  var ret = <T>[];
  for (var element in origin) {
    if (element is T) {
      ret.add(element);
      continue;
    }
    if (saveDiscarded) {
      discardedList.add(element);
    }
  }
  return ret;
}

bool unfilledList(List? list) => list?.isEmpty ?? true;
bool filledList(List? list) => !unfilledList(list);

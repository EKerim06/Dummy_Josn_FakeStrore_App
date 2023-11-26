///Product Query Enums [limit]
enum ProductQuery {
  ///Query limit parameter default [10]
  limit,

  ///how much items skipping
  skip;
}

///Product Query Extension
extension ProductQueryExtension on ProductQuery {
  ///Returned toMapEntry
  ///[limit] is how much items
  ///[skip] is how much items skipping
  MapEntry<String, String> toMapEntry(String value) {
    switch (this) {
      case ProductQuery.limit:
        return MapEntry('limit', value);
      case ProductQuery.skip:
        return MapEntry('skip', value);
    }
  }
}

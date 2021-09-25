bool unfilledMap(Map? map) => map?.isEmpty ?? true;
bool filledMap(Map? map) => !unfilledMap(map);

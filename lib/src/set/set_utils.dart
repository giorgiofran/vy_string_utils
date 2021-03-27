
bool unfilledSet(Set? set) => set?.isEmpty ?? true;
bool filledSet(Set? set) => !unfilledSet(set);

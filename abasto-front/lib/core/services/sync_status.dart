enum SyncStatus { local, pending, synced, conflict, deleted }

extension SyncStatusParser on SyncStatus {
  static SyncStatus fromDatabase(String value) {
    return SyncStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => SyncStatus.local,
    );
  }
}

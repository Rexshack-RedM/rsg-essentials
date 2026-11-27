# Changelog

All notable changes to rsg-essentials. Newest first.

## 3.3.1

### Changed
- Discord logs are queued per webhook, sent in batches of up to 10 and retried when Discord rate limits or fails, instead of one request per log. `@everyone` is sent with the batch.

## 3.3.0

### Added
- **Rebindable keys for hands up and pointing:** both use rsg-core `RegisterKey` (needs rsg-core 3.5.0 or newer), so players can rebind them in the game's key settings and the two per-frame loops are gone. New `Config.UseKeyMapping` (set `false` to poll the keys as before) and `Config.Keys` (`HandsUp`, `Point`). New locale keys `key_handsup` and `key_point` in all 12 languages.

### Fixed
- Pointing no longer starts the animation if the key is released while the animation dictionary is still loading, and stops when the resource stops.

## 3.2.1

### Documentation
- `DOCS.md`: added a generated technical reference (dependencies, database, configuration, exports, callbacks, events, commands, items, locales) with code examples, read straight from the source.

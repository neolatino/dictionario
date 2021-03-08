class CacheManager {
  CacheManager._internal();

  static final CacheManager _singleton = CacheManager._internal();

  factory CacheManager() {
    return _singleton;
  }

  final Map<String, Object> _cache = Map();

  T cache<T>(String key, T value) {
    return _cache.putIfAbsent(key, () => value as Object) as T;
  }

  T forceCache<T>(String key, T value) {
    _cache[key] = value as Object;
    return value;
  }
}

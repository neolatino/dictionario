import 'cache_manager.dart';

class CacheProvider {
  final CacheManager _cacheManager = CacheManager();

  T cache<T>(String key, T value) => _cacheManager.cache(key, value);

  T forceCache<T>(String key, T value) => _cacheManager.forceCache(key, value);
}

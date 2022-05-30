# dio_view_ume_adapter


## Getting Started

* add flutter_ume plugin

```dart
void main() {
  if (kDebugMode) {
    PluginManager.instance.register(DioViewUMEAdapter(dio: _dio));
    runApp(const UMEWidget(child: MyApp()));
  } else {
    runApp(const MyApp());
  }
}
```

* start inspect dio.

```dart
_dio.get('https://www.some.host.com/some/path');
```



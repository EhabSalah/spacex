dependencies:
	flutter pub get
clean:
	flutter clean
build-runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs
analyze:
	flutter analyze
dart-fix-quietly:
	flutter pub global run dartfix --pedantic lib --overwrite
run-dev:
	flutter run --flavor development --dart-define=FLAVOR=development --target lib/main.dart
run-prd:
	flutter run --release --flavor production --dart-define=FLAVOR=production --target lib/main.dart

build-android-dev:
	flutter build apk --flavor development --dart-define=FLAVOR=development --target lib/main.dart

build-android-prd:
	flutter build apk --release --flavor production --dart-define=FLAVOR=production --target lib/main.dart
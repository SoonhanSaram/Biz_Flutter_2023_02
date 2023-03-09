# flutter_070_member

- google 을 통한 login 구현
- firebase authentication 을 사용해 join 과 login 구현

## google login 을 구현

- `flutter pub add google_sign_in`, `flutter pub add http`
- `flutter pub add change_app_package_name`

## google firebase 프로젝트 구성

- firebase 에서 프로젝트 생성
- 안드로이드 App 을 추가
- SHA 지문등록

### SHA 지문등록

- Android Studio 설치
- `https://developers.google.com/android/guides/client-auth?hl=ko` 페이지에서 keytool 사용법 확인
  아래 코드를 활용해서 SHA 지문 가져오기
- `C:\Program Files\Java\jdk-15.0.2\bin` 폴더에서 `bash shell` 사용

```bash
./keytool -list -v \ -alias androiddebugkey -keystore ~/.android/debug.keystore
```

- 초기 비밀번호는 'android'
- firebase 프로젝트 설정에서 해당 앱에 SHA 인증서 지문 추가

## firebase 연동 실행

- firebase SDK 안내서에 따라 Android 아래의 build.gradle 파일에 설정하기
- dependencies 설정

```bash
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add firebase_database
```

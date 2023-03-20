# flutter_070_member_mvvm

- google 을 통한 login 구현
- firebase authentication 을 사용해 join 과 login 구현

## google login mvvm 패턴 refactoring(2023-03-20)

- `flutter pub add provider`
-

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

## Google Login exception

- `platformException(sign_in_failed, apiException: 12500`
- GCP(Google Cloud platform) 에 접속해 콘솔 들어가기
- 상단에 현재 프로젝트 이름 확인
- 왼쪽 햄버거 버튼 `API 및 서비스` -> `Oauth 동의화면` 접속하기
- `사용자 email 정보`, `개발자 email 정보` 확인하여 등록하기

- `platformException(sign_in_failed, apiException: 10`
- `SHA 키 오류`
- 여러곳에서 사용할 경우 각 컴퓨터마다 keytool을 실행하여 SHA1 키를 등록하기

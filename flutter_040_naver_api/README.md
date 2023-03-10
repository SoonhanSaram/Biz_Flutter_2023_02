# flutter_040_naver_api

- naver OpenAPI 를 사용해 영화 검색 App 만들기
- `/lib/config/naver_api.dart` 파일에 NaverAPI 의 접속
  정보를 설정
- `.gitignore` 파일에 `naver_api.*` 를 등록해
  `github` 업로드 차단

## flutter 에서 외부 서버에 접속하기 위해

- dependencies 설정

```
flutter pub add http
flutter pub add flutter_html
```

## naver API 에서 요구하는 안드로이드 패키지 설정

`flutter pub add change_app_package_name`
`flutter pub run change_app_package_name:main com.kyoungmin.naver`

## android 설정 확인 및 권한 부여

-`/android/src/main/kotlin` 폴더에서 `MainActivity.kt` 파일을 열고 package 가 `com.kyoungmin.naver` 로 변경되었는지 확인 -`/android/src/main/AndroidManifest.xml` 파일을 열고 package 확인

- 같은 파일에 다음 항목을 (<application>) 위에 추가

```xml
<uses-permission android:name="android.permission.INTERNET"/>
   <application
```

## gradle 빌드 환경 설정

- `android/app/build.gradle` 파일 열기
- `default config` 항목에서 다음 부분 변경

```groovy
minSdkVersion 25  //flutter.minSdkVersion
targetSdkVersion  33 //flutter.targetSdkVersion
```

- `buildTypes` 항목을 찾아 다음과 같은 지 확인

```groovy
buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
```

## 영화 리스트 검색 후 naver 영화 자세히 보기로 jump

- 외부 URL 을 내장 브라우저로 열기
- `flutter pub add url_launcher` 설치
- `AndroidManifest.xml` 파일에 다음 항목 추가

```xml
<queries>
        <intent>
            <action android:name="android.intent.action.VIEW"/>
            <data android:schema="https" />
        </intent>
</queries>
<application>
```

## Andorid

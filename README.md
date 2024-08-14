# edfapg_sdk

[View SDK Wiki](https://github.com/edfapay/edfa-pg-flutter-sdk.git) | [Report new issue](https://github.com/edfapay/edfa-pg-flutter-sdk.git/issues/new)

# EdfaPay Flutter SDK & [Sample](https://github.com/edfapay/edfa-pg-flutter-sdk.git)

EdfaPay is a white-label payment software provider. Thanks to our 15+ years of experience in the
payment industry, we’ve developed a state-of-the-art white-label payment system that ensures smooth
and uninterrupted payment flow for merchants across industries.
 
[//]: # (<p align="center">)

[//]: # (  <a href="https://edfapay.com/home/">)

[//]: # (      <img src="https://github.com/ExpresspaySa/expresspay-flutter-sdk/blob/main/media/header.png" alt="Expresspay" width="400px"/>)

[//]: # (  </a>)

[//]: # (</p>)

EdfaPay Flutter SDK was developed and designed with one purpose: to help the Flutter developers
easily integrate the EdfaPay API Payment Platform for a specific merchant.

To properly set up the SDK, read [Wiki](https://github.com/edfapay/edfa-pg-flutter-sdk/wiki)
first.

## Setup And Installation

This Flutter plugin is based on iOS and Android native libraries.
You need to add the `jitpack` repository support and `credentials` to the gradle to access the
secured Android library. `Follow Below`

**Setup Android**
Add to the root build.gradle in Android Project at Path:(${ProjectRoot}/android/build.gradle):

```groovy
allprojects {
    repositories {
        ...
        jcenter()
        maven {
            url 'https://jitpack.io'
        }
    }
}
```

**Setup iOS**
iOS does not required any setup just install flutter plugin where the `iOS framewework` is embedded
within the plugin in iOS plaform directory.
If you need to enable `Apple Pay` in your app it can be enable by following the instructions
at [Link](https://github.com/edfapay/edfa-pg-flutter-sdk)

## Intalling Flutter Plugin**

In the `dependencies:` section of your `pubspec.yaml`, add the following lines:

```pubspec.yaml
dependencies:
  intl: ^0.17.0
  edfapg_sdk: any
```

## Configuring the Proguard Rule

If your project is obfuscated with proguard, please add the rule below to your project **proguard-rules.pro**

```
-keep class com.edfapg.sdk.** {
  public protected private *;
}
```


## Initialize SDK

```dart
EdfaPgSdk.instance.config(
  key: MERCHANT_CLIENT_KEY, // Your Secret Merchant Key
  password: MERCHANT_CLIENT_PASSWORD, // Your Secret Merchant Password
  enableDebug: true
);
```

[More Detail](https://github.com/edfapay/edfa-pg-flutter-sdk)

## Quick Payment Implementation

[**Card Payment for iOS/Android
**](https://github.com/edfapay/edfa-pg-flutter-sdk/wiki)
Start the card payment with one click, easy and short line of codes. It will help the developer to
easily implement the payment using card in thier application. click
the [link](https://github.com/edfapay/edfa-pg-flutter-sdk/wiki)
for easy steps to start payments.

[**Apple Pay Payment for iOS
**](https://github.com/edfapay/edfa-pg-flutter-sdk/wiki)
Start the Apple Pay payment with one click, easy and short line of codes. It will help the developer
to easily implement the payment using ApplePay in thier application. the developer just need to
configure and enable the Apple Pay in thier AppleDeveloper Account and call the simple function.
click
the [link](https://github.com/edfapay/edfa-pg-ios-sdk-pod/)
for easy steps to start payments with ApplePay.

## Getting help

To report a specific issue or feature request, open
a [new issue](https://github.com/edfapay/edfa-pg-flutter-sdk/issues/new).

Or write a direct letter to the [support@edfapay.sa](mailto:support@edfapay.sa).

## License

MIT License. See
the [LICENSE](https://github.com/edfapay/edfa-pg-flutter-sdk/blob/master/LICENSE) file for
more details.

## Contacts

![](/media/footer.png)

Website: https://edfapay.com/home/
Phone: [+966920031242](tel:+966920033633)  
Email: [support@edfapay.sa](mailto:support@edfapay.sa)  
7637 Othman Bin Affan St., 2123 Al Ezdihar Dist., 12487 Riyadh, Riyadh, Saudi Arabia

© 2022 - 2023 EdfaPay. All rights reserved.



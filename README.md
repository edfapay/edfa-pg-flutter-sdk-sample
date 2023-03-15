# expresspay_sdk

![](https://jitpack.io/v/expresspay/expresspay-android-sdk.svg) | [View SDK Wiki](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki) | [Report new issue](https://github.com/a2zZuhaib/expresspay-flutter-sdk/issues/new)

# Expresspay Flutter SDK & Sample

Expresspay is a white-label payment software provider. Thanks to our 15+ years of experience in the payment industry, we’ve developed a state-of-the-art white-label payment system that ensures smooth and uninterrupted payment flow for merchants across industries.

<p align="center">
  <a href="https://expresspay.sa">
      <img src="/media/header.png" alt="Expresspay" width="400px"/>
  </a>
</p>

Expresspay Flutter SDK was developed and designed with one purpose: to help the Flutter developers easily integrate the Expresspay API Payment Platform for a specific merchant.


To properly set up the SDK, read [Wiki](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki) first.

## Setup And Installation
This Flutter plugin is based on iOS and Android native libraries.
You need to add the `jitpack` repository support and `credentials` to the gradle to access the secured Android library. `Follow Below`

**Setup Android**
Add to the root build.gradle in Android Project at Path:(${ProjectRoot}/android/build.gradle):

```groovy
allprojects {
    repositories {
        ...
        jcenter()
        maven {
            url 'https://jitpack.io'
            credentials { username 'jp_t35u3134mhdka9fc1vatvmcu6i' }
        }
    }
}
```

**Setup iOS**
iOS does not required any setup just install flutter plugin where the `iOS framewework` is embedded within the plugin in iOS plaform directory.

**Intalling Flutter Plugin**
In the `dependencies:` section of your `pubspec.yaml`, add the following lines:

```pubspec.yaml
dependencies:
  intl: ^0.17.0
  expresspay_sdk: any
```

## Quick Payment Implementation
[**Card Payment for iOS/Android**](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki/Express-Quick-Card-Payment)
Start the card payment with one click, easy and short line of codes. It will help the developer to easily implement the payment using card in thier application. click the [link](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki/Express-Quick-Card-Payment) for easy steps to start payments.


[**Apple Pay Payment for iOS**](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki/Express-ApplePay-Payment)
Start the Apple Pay payment with one click, easy and short line of codes. It will help the developer to easily implement the payment using ApplePay in thier application. the developer just need to configure and enable the Apple Pay in thier AppleDeveloper Account and call the simple function. click the [link](https://github.com/ExpresspaySa/expresspay-ios-sdk-framework/wiki/Express-ApplePay-Payment) for easy steps to start payments with ApplePay.


## Getting help

To report a specific issue or feature request, open a [new issue](https://github.com/a2zZuhaib/expresspay-flutter-sdk/issues/new).

Or write a direct letter to the [support@expresspay.sa](mailto:support@expresspay.sa).

## License

MIT License. See the [LICENSE](https://github.com/a2zZuhaib/expresspay-flutter-sdk/blob/master/LICENSE) file for more details.

## Contacts

![](/media/footer.png)

Website: https://expresspay.sa  
Phone: [+966 920033633](tel:+966920033633)  
Email: [support@expresspay.sa](mailto:support@expresspay.sa)  
Address: Expresspay, Olaya Street, Riyadh, Saudi Arabia

© 2022 - 2023 Expresspay. All rights reserved.



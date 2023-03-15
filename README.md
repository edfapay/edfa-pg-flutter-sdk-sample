![](https://jitpack.io/v/expresspay/expresspay-android-sdk.svg) | [View SDK Wiki](https://github.com/ExpresspaySa/expresspay-android-sdk/wiki) | [Report new issue](https://github.com/ExpresspaySa/expresspay-android-sdk/issues/new)

# Expresspay Flutter SDK Samples

Expresspay is a white-label payment software provider. Thanks to our 15+ years of experience in the payment industry, we’ve developed a state-of-the-art white-label payment system that ensures smooth and uninterrupted payment flow for merchants across industries.

<p align="center">
  <a href="https://expresspay.sa">
      <img src="/media/header.jpg" alt="Expresspay" width="400px"/>
  </a>
</p>

Expresspay Flutter SDK was developed and designed with one purpose: to help the Flutter developers easily integrate the Expresspay API Payment Platform for a specific merchant. 

The main aspects of the Expresspay AndFlutterroid SDK:

- [Kotlin](https://developer.android.com/kotlin) is the main language
- [Retrofit](http://square.github.io/retrofit/) is the API machine 
- [KDoc](https://kotlinlang.org/docs/reference/kotlin-doc.html) code coverage
- API debug [logging](https://github.com/square/okhttp/tree/master/okhttp-logging-interceptor)
- Minimum SDK 16+
- Sample Application

To properly set up the SDK, read [Wiki](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki) first.
To get used to the SDK, download a [sample app](https://github.com/a2zZuhaib/expresspay-flutter-sdk/tree/master/sample).

## Setup

Add to the root build.gradle:

```groovy
allprojects {
    repositories {
        ...
        jcenter()
        maven { url 'https://jitpack.io' }
    }
}
```

Add to the package build.gradle:

```groovy
dependencies {
    implementation 'com.github.ExpresspaySa:expresspay-android-sdk:{latest-version}'
}
```

Latest version is: ![](https://github.com/a2zZuhaib/expresspay-flutter-sdk.svg) 

Also, it is possible to download the latest artifact from the [releases page](https://github.com/a2zZuhaib/expresspay-flutter-sdk/releases).

## Quick Payment Implementation
[**Card Payment**](https://github.com/ExpresspaySa/expresspay-android-sdk/wiki/Express-Quick-Card-Payment)
Start the card payment with one click, easy and short line of codes. It will help the developer to easily implement the payment using card in thier application. click the [link](https://github.com/a2zZuhaib/expresspay-flutter-sdk/wiki/Express-Quick-Card-Payment) for easy steps to start payments.


## Getting help

To report a specific issue or feature request, open a [new issue](https://github.com/a2zZuhaib/expresspay-flutter-sdk/issues/new).

Or write a direct letter to the [support@expresspay.sa](mailto:support@expresspay.sa).

## License

MIT License. See the [LICENSE](https://github.com/a2zZuhaib/expresspay-flutter-sdk/blob/master/LICENSE) file for more details.

## Contacts

![](/media/footer.jpg)

Website: https://expresspay.sa  
Phone: [+966 920033633](tel:+966920033633)  
Email: [support@expresspay.sa](mailto:support@expresspay.sa)  
Address: Expresspay, Olaya Street, Riyadh, Saudi Arabia 

© 2022 - 2023 Expresspay. All rights reserved.

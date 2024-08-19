# EdfaPay Payment Gateway Flutter SDK

EdfaPay is a white-label payment software provider. Thanks to our 15+ years of experience in the
payment industry, we’ve developed a state-of-the-art white-label payment system that ensures smooth
and uninterrupted payment flow for merchants across industries.

EdfaPay Flutter SDK was developed and designed with one purpose: to help the Flutter developers
easily integrate the EdfaPay API Payment Platform for a specific merchant.


## Installation
> [!IMPORTANT]
> ### Configure Repository
> This Flutter plugin is a wrapper of Android and iOS native libraries.
> 
> **Setup Android**
> 
> You must add the `jitpack` repository support to the **Gradle** to access and download the native dependency. 
>
> Add below to the `./android/build.gradle` of your project
> 
> ```groovy
> allprojects {
>     repositories {
>         ...
> 
>         // Add below at the same location 
>         maven {
>             url 'https://jitpack.io'
>         }
>     }
> }
> ```
> ----
>
> Or add below to the `./android/settings.gradle` of your project
> 
> ```groovy
> dependencyResolutionManagement {
>     repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
>     repositories {
>         ...
> 
>         // Add below at the same location 
>         maven {
>             url "https://jitpack.io"
>         }
>     }
> }
> ```
>
> 
> **Setup iOS**
> 
> iOS does not require any setup just install Flutter plugin.
> If you need to enable `Apple Pay` in your app it can be enabled by following the instructions
> at [Link](https://github.com/edfapay/edfa-pg-flutter-sdk)

> [!IMPORTANT]
> ### Intalling Flutter Plugin
> 
> In the `dependencies:` section of your `pubspec.yaml`, add the following lines:
> 
> ```pubspec.yaml
> dependencies:
>   intl: ^0.17.0
>   edfapg_sdk: any
> ```

> [!IMPORTANT]
> ### Configuring the Proguard Rule
>
> **Android**
> 
> If your project is obfuscated with proguard, please add the rule below to your android project **proguard-rules.pro**
> 
> ```
> -keep class com.edfapg.sdk.** {
>   public protected private *;
> }
> ```

## Usage
> [!IMPORTANT]
> ### Initialize SDK
> 
> ```dart
> EdfaPgSdk.instance.config(
>   key: MERCHANT_CLIENT_KEY, // Your Secret Merchant Key
>   password: MERCHANT_CLIENT_PASSWORD, // Your Secret Merchant Password
>   enableDebug: true
> );
> ```

> [!TIP]
> ### Get Ready for Payment
> > **Create `EdfaPgSaleOrder` Model**
> > ```dart
> >     final order = EdfaPgSaleOrder(
> >        id: EdfaPgSdk.instance.HELPER.generateUUID(),
> >        description: "Test Order",
> >        currency: "SAR",
> >        amount: 1.00//Random().nextInt(9)/10, // will not exceed 0.9
> >    );
> > ```
>
> > **Create `EdfaPgPayer` Model**
> > ```dart
> >    final payer = EdfaPgPayer(
> >        firstName: "First Name",
> >        lastName: "Last Name",
> >        address: "EdfaPay Payment Gateway",
> >        country: "SA",
> >        city: "Riyadh",
> >        zip: "123768",
> >        email: "support@edapay.com",
> >        phone: "+966500409598",
> >        ip: "66.249.64.248",
> >        options: EdfaPgPayerOption( // Options
> >            middleName: "Middle Name",
> >            birthdate: DateTime.parse("1987-03-30"),
> >            address2: "Usman Bin Affan",
> >            state: "Al Izdihar"
> >        )
> >    );
> > ```
> 
> > **Payment with Card**
> > ```dart
> >    EdfaCardPay()
> >        .setOrder(order)
> >        .setPayer(payer)
> >        .onTransactionSuccess((response){
> >          print("onTransactionSuccess.response ===> ${response.toString()}");
> >
> >    }).onTransactionFailure((response){
> >      print("onTransactionFailure.response ===> ${response.toString()}");
> >
> >    }).onError((error){
> >      print("onError.response ===> ${error.toString()}");
> >
> >    }).initialize(context);
> > ```
>
> > **Pay With ApplePay - iOS Only**
> > ```dart
> >     EdfaApplePay()
> >         .setOrder(order)
> >         .setPayer(payer)
> >         .setApplePayMerchantID(APPLEPAY_MERCHANT_ID)
> >         .onAuthentication((response){
> >       print("onAuthentication.response ===> ${response.toString()}");
> > 
> >     }).onTransactionSuccess((response){
> >       print("onTransactionSuccess.response ===> ${response.toString()}");
> > 
> >     }).onTransactionFailure((response){
> >       print("onTransactionFailure.response ===> ${response.toString()}");
> > 
> >     }).onError((error){
> >       print("onError.response ===> ${error.toString()}");
> > 
> >     }).initialize(context);
> > ```

<!--
> [!TIP]
> ### Sale Transaction
> <details>
>   <summary> To pay with card </summary>
> </details>

> [!TIP]
> ### Recurring Transaction
> <details>
>   <summary> To pay with card </summary>
> </details>

> [!TIP]
> ### Capture Transaction
> <details>
>   <summary> To pay with card </summary>
> </details>

> [!TIP]
> ### Credit Void Transaction
> <details>
>   <summary> To pay with card </summary>
> </details>

> [!TIP]
> ### Transaction Status
> <details>
>   <summary> To pay with card </summary>
> </details>

> [!TIP]
> ### Transaction Detail
> <details>
>   <summary> To pay with card </summary>
> </details>
-->

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



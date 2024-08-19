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
>
> ### Addon's
> > **Create `EdfaPgSaleOrder` & `EdfaPgPayer` Model** [Like This](https://github.com/edfapay/edfa-pg-flutter-sdk-sample?tab=readme-ov-file#get-ready-for-payment)
> > 
> > **Create `EdfaPgSaleOption` Model**
> > ```dart
> >     final saleOption = EdfaPgSaleOption(
> >         channelId: "channel-id-here", // channel-id if its enable for merchant
> >         recurringInit: true // Make sure recurring is enabled for merchant and [true=if want to do recurring, false=if don't want do recurring]
> >     );
> > ```
> > 
> > **Create `EdfaPgCard` Model**
> > ```dart
> >     final card = EdfaPgCard(
> >         number: "1234567890987654",
> >         expireMonth: 01,
> >         expireYear: 2028,
> >         cvv: 123
> >     );
> > ```
> > 
> > **Sale Transaction** - Make sure to pass null to `saleOption:` and false to `isAuth:`
> > ```dart
> >     EdfaPgSdk.instance.ADAPTER.SALE.execute(
> >         order: order,
> >         card: card,
> >         payer: payer,
> >         saleOption: null,
> >         isAuth: false,
> >         onResponse: SaleResponseCallback(
> >             success: (EdfaPgSaleSuccess result) {
> >               debugPrint(result.toJson().toString());
> >               
> >             },
> >             decline: (EdfaPgSaleDecline result) {
> >               debugPrint(result.toJson().toString());
> >               
> >             },
> >             recurring: (EdfaPgSaleRecurring result) {
> >               debugPrint(result.toJson().toString());
> >               
> >             },
> >             redirect: (EdfaPgSaleRedirect result) {
> >               debugPrint(result.toJson().toString());
> >               
> >             },
> >             secure3d: (EdfaPgSale3DS result) {
> >               debugPrint(result.toJson().toString());
> >               
> >             },
> >             error: (EdfaPgError result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             }
> >         ),
> >         onResponseJSON: (data){
> >           debugPrint(data);
> > 
> >         },
> >         onFailure: (result) {
> >           debugPrint(result.toJson().toString());
> > 
> >         }
> >     );
> > ```
>
> > **Recurring Transaction**
> > - Make sure to pass false to `isAuth:`
> > - Card Number should be passed the same used for the first `Sale` with `EdfaPgSaleOption.recurringInit==true`
> > - `EdfaPgRecurringOptions.firstTransactionId:` should `transactionId` from first success `Sale` with `EdfaPgSaleOption.recurringInit==true`
> > - `EdfaPgRecurringOptions.token:` Should be recurringToken from first success `Sale` with `EdfaPgSaleOption.recurringInit==true`
> > ```dart
> >     EdfaPgSdk.instance.ADAPTER.RECURRING_SALE.execute(
> >         cardNumber: "1234567890123456",
> >         isAuth: false,
> >         order: order,
> >         payerEmail: "support@edfapay.com",
> >         recurringOptions: EdfaPgRecurringOptions(
> >             firstTransactionId: "c9f9b51b-72f4-4e2d-8a49-3b26c97b2f50",
> >             token:  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
> >         ),
> >         onResponse: RecurringSaleResponseCallback(
> >             success: (EdfaPgSaleSuccess result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             decline: (EdfaPgSaleDecline result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             recurring: (EdfaPgSaleRecurring result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             redirect: (EdfaPgSaleRedirect result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             secure3d: (EdfaPgSale3DS result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             error: (EdfaPgError result) {
> >               debugPrint(result.toJson().toString());
> > 
> >             }
> >         ),
> >         onResponseJSON: (data){
> >           debugPrint(data);
> > 
> >         },
> >         onFailure: (result) {
> >           debugPrint(result.toJson().toString());
> > 
> >         }
> >     );
> > ```
> 
> > **Capture Transaction**
> > - `transactionId:` should `transactionId` from success `Sale` with `isAuth:true`
> > - Card Number should be passed the same used for the `Sale` with `isAuth:true`
> > - `cardNumber:` should authorized by `Sale` with `isAuth:true`
> > - `amount:` should be the same as `Sale` with `isAuth:true`
> > ```dart
> >     EdfaPgSdk.instance.ADAPTER.CAPTURE.execute(
> >         amount: 1.0,
> >         transactionId: "c9f9b51b-72f4-4e2d-8a49-3b26c97b2f50",
> >         cardNumber: "1234567890123456",
> >         payerEmail: "support@edfapay.com",
> >         onResponse: CaptureResponseCallback(
> >             success: (EdfaPgCaptureSuccess result){
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             decline: (EdfaPgCaptureDecline result){
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             error: (EdfaPgError result){
> >               debugPrint(result.toJson().toString());
> > 
> >             }
> >         ),
> >         onResponseJSON: (data){
> >           debugPrint(data);
> > 
> >         },
> >         onFailure: (result) {
> >           debugPrint(result.toJson().toString());
> > 
> >         }
> >     );
> > ```
>
> > **Credit Void Transaction**
> > - `transactionId:` should `transactionId` from success `Sale` with `isAuth:true`
> > - Card Number should be passed the same used for the `Sale` with `isAuth:true`
> > - `cardNumber:` should authorized by `Sale` with `isAuth:true`
> > - `amount:` should be the same as `Sale` with `isAuth:true`
> > ```dart
> >     EdfaPgSdk.instance.ADAPTER.CREDIT_VOID.execute(
> >         amount: 1.0,
> >         transactionId: "c9f9b51b-72f4-4e2d-8a49-3b26c97b2f50",
> >         cardNumber: "1234567890123456",
> >         payerEmail: "support@edfapay.com",
> >         onResponse: CreditVoidResponseCallback(
> >             success: (EdfaPgCreditVoidSuccess result){
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             error: (EdfaPgError result){
> >               debugPrint(result.toJson().toString());
> > 
> >             }
> >         ),
> >         onResponseJSON: (data){
> >           debugPrint(data);
> > 
> >         },
> >         onFailure: (result) {
> >           debugPrint(result.toJson().toString());
> > 
> >         }
> >     );
> > ```
>
> > **Transaction Detail**
> > - `transactionId:` should be from the last transaction,
> > - `cardNumber:` should be passed the same used for the last transaction
> > ```dart
> >     EdfaPgSdk.instance.ADAPTER.TRANSACTION_DETAILS.execute(
> >         transactionId: "c9f9b51b-72f4-4e2d-8a49-3b26c97b2f50",
> >         cardNumber: "1234567890123456",
> >         payerEmail: "support@edfapay.com",
> >         onResponse: TransactionDetailsResponseCallback(
> >             success: (EdfaPgTransactionDetailsSuccess result){
> >               debugPrint(result.toJson().toString());
> > 
> >             },
> >             error: (EdfaPgError result){
> >               debugPrint(result.toJson().toString());
> > 
> >             }
> >         ),
> >         onResponseJSON: (data){
> >           debugPrint(data);
> > 
> >         },
> >         onFailure: (result) {
> >           debugPrint(result.toJson().toString());
> > 
> >         }
> >     );
> > ```
>
> > **Transaction Status**
> > - `transactionId:` should be from the last transaction,
> > - `cardNumber:` should be passed the same used for the last transaction
> > ```dart
> >     EdfaPgSdk.instance.ADAPTER.TRANSACTION_STATUS.execute(
> >         transactionId: "c9f9b51b-72f4-4e2d-8a49-3b26c97b2f50",
> >         cardNumber: "1234567890123456",
> >         payerEmail: "support@edfapay.com",
> >         onResponse: TransactionStatusResponseCallback(
> >             success: (EdfaPgTransactionStatusSuccess result){
> >               debugPrint(result.toJson().toString());
> >             },
> >             error: (EdfaPgError result){
> >               debugPrint(result.toJson().toString());
> > 
> >             }
> >         ),
> >         onResponseJSON: (data){
> >           debugPrint(data);
> >         },
> >         onFailure: (result) {
> >           debugPrint(result.toJson().toString());
> > 
> >         }
> >     );
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



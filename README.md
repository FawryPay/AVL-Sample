
# 

# **FawryPaySDK-AVL iOS**

Accept popular payment methods with a single client-side implementation.

## **Before You Start**

Use this integration if you want your iOS application to:

-   Accept cards and other payment methods.
-   Save and display cards for reuse.

Make sure you have an active FawryPay account, or [**create an account**](https://atfawry.fawrystaging.com/merchant/register).


### **How iOS SDK Looks Like**
<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/1.png" width="300"/>    <img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/2.png" width="300"/>


[**Clone**](https://github.com/FawryPay/AVL-Sample.git) and test our sample application.
------------------------------------------------------------------------
### **How it works**
<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/3.png" width="900"/>


On this page, we will walk you through the iOS SDK integration steps:

1.  Installing FawryPaySDK Pod.
2.  Initialize and Configure FawryPay iOS SDK.
3.  Override the SDK colors.
4.  Present Payment options.
5.  Return payment processing information and inform your client with the payment result.


## **Step 1: Installing FawryPaySDK-AVL Pod**

This document illustrates how our gateway can be integrated within your iOS application in simple and easy steps. Please follow the steps in order to integrate the FawryPay iOS SDK in your application.

1.  Create a pod file in your application if it doesn't exist. Using this [Cocoapod Guide](https://guides.cocoapods.org/using/using-cocoapods.html)
2. Add in your pod file 
<!-- -->

     pod ‘FawryPaySDK-AVL’, '0.4.0'

3. Open the terminal navigated to your project root folder
4. Run pod install
   
With minimum deployments iOS 12.0

## **Step 2: Initialize FawryPay IOS SDK**

1. Import FawryPay SDK in your Swift file.

``` swift
import FawryPaySDK_AVL
```
2. Create an instance of
    - LaunchCustomerModel
    - LaunchMerchantModel
    - AVLInfo
    - FawryLaunchModel

and pass the required parameters (Required and optional parameters are determined below).

<img width="988" src="https://github.com/user-attachments/assets/8815a7ef-ad7d-44ab-9498-98ac0f5808d3">


LaunchCustomerModel
| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                        |
|---------------|---------------|---------------|---------------|---------------|
| customerName      | String   | optional     | \-                                              | Name Name                                          |
| customerEmail     | String   | optional     | \-                                              | [email\@email.com](mailto:email@email.com)         |
| customerMobile    | String   | optional     | \-                                              | +0100000000                                        |
| customerProfileId | String   | optional     | \-                                              | 1234                                               |


LaunchMerchantModel
| **PARAMETER**  | **TYPE** | **REQUIRED** | **DESCRIPTION**                                                                                                                                                                | **EXAMPLE**                         |
|---------------|---------------|---------------|---------------|---------------|
| merchantCode   | String   | required     | Merchant ID provided during FawryPay account setup.                                                                                                                            | 400000011323 |
| secureKey      | String   | required     | provided by support                                                                                                                                                            | 4b8jw3j2-8gjhfrc-4wc4-scde-453dek3d |

AVLInfo
| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| length            | Int      | required     | \-                                                | 6                                                  |
| btcWithFees       | Int      | required     | \-                                                | 4933                                               |
| btcWithoutFees    | Int      | required     | \-                                                | 4428                                               |
| pans              | [String] | required     | BANs related to the bank to use the btcWithoutFees| [“512345”]                                         | 
| avlFeesOffUs              | double | optional     |  - |  7.7  
| avlFeesOnUs              | double | optional     | - |  5.0  


FawryLaunchModel
| **PARAMETER**     |          **TYPE**        | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                         |
|-------------------|--------------------------|--------------|---------------|---------------|
| customer          | LaunchCustomerModel      | optional     | Customer information.                             | \-                                                |
| merchant          | LaunchMerchantModel      | required     | Merchant information.                             | \-                                                |
| signature          | String      | Optional - Should be always nil     | \-                             | \-                                               |
| paymentWithCardToken          | Bool      | Optional - Should be always false     | \-                             | false                                               |
| avlInfo           | AVLInfo                  | required     | \-                                                | \-                                                |
| apiPath           | String                   | Optional - default value = nil | If the user needs to send a path of URL.| "fawrypay-a pi/api/"                      |

| **Property**      |          **TYPE**        | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                         |
|-------------------|--------------------------|--------------|---------------|---------------|
| skipReceipt       | Boolean                  | optional - default value = false    | to skip receipt after payment trial               | \-                                                                                             |
| beneficiaryName   | String                   | mandatory     | \-                                                | “name”                                         |
| beneficiaryWalletNumber| String                   | mandatory     | \-                                                | “01234567890”                                |                                              |
| billingAcct       | String                   | mandatory     | \-                                                | “01234567890”                                     |



3.  Calling Mode:
     -  Payment Mode: Call launchAVL from the shared instance of FrameworkHelper and the payment screen will launch.
<img width="752" src="https://github.com/user-attachments/assets/6b475731-ce4d-469f-84db-13ebb55fde0e">

| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| on                | UIViewController| required     | The view controller which will be the starting point of the SDK.| self                                             |
| launchModel       | FawryLaunchModel| required     | Has info that needed to launch the SDK            | Example in step 2                                  |
| baseURL           | String          | required     | Provided by the support team. Use staging URL for testing and switch for production to go live.|(https://atfawry.fawrystaging.com) (staging)        (https://atfawry.com) (production)|
| appLanguage       | String          | required     | SDK language which will affect SDK's interface languages.| AppLanguage.English                           |
| enable3Ds         | Bool            |optional - default value = false| to allow 3D secure payment make it “true”   | true                                           |
| avlAmountDataType         | Enum          | required     | depending on the merchant’s needs, the type of amount value can be either an integer or a decimal | 7.0   
| logoImage         | UIImage          | required     | if merchant wants to set an image not title | \-  
| titleHeader         | String          | required     | if merchant wants to set title not an image | "Fawry"      
| regulerFont         | UIFont          | required     | font of sdk | UIFont(name: "SFProText-RegularItalic", size: 17)                   |

## **Step 2.1: Initialize Seamless Credit Card, FawryPay IOS SDK**

1. Import FawryPay SDK in your Swift file.

``` swift
import FawryPaySDK_AVL
```
2. Create an instance of
    - LaunchCustomerModel
    - LaunchMerchantModel
    - SavedCard
    - ChargeItemsParamsModel
    - FawryLaunchModel

and pass the required parameters (Required and optional parameters are determined below).

<img width="1093" src="https://github.com/user-attachments/assets/6e7ce284-18c2-4cbc-bce5-d34bcea3451f">


LaunchCustomerModel
| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                        |
|---------------|---------------|---------------|---------------|---------------|
| customerName      | String   | optional     | \-                                              | Name Name                                          |
| customerEmail     | String   | optional     | \-                                              | [email\@email.com](mailto:email@email.com)         |
| customerMobile    | String   | optional     | \-                                              | +0100000000                                        |
| customerProfileId | String   | optional     | \-                                              | 1234                                               |


LaunchMerchantModel
| **PARAMETER**  | **TYPE** | **REQUIRED** | **DESCRIPTION**                                                                                                                                                                | **EXAMPLE**                         |
|---------------|---------------|---------------|---------------|---------------|
| merchantCode   | String   | required     | Merchant ID provided during FawryPay account setup.                                                                                                                            | 400000011323               |                          |
| secureKey      | String   | required     | provided by support                                                                                                                                                            | 4b8jw3j2-8gjhfrc-4wc4-scde-453dek3d |

SavedCard
| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| cardHolderName            | String      | required     | Name appears on card                                                | \-                                                  |
| cardNumber       | String      | required     | Number appears on card                                                | \-                                              |
| cardExpiryMonth    | String      | required     | Expiration month of the card                                                | \-                                               |
| cardExpiryYear              | String | required     | Expiration year of the card | \-                                          | 
| cvv              | String | required     |  3 digits are usually found on signature strip |  \-    

ChargeItemsParamsModel
| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| itemId            | String      | required     | id for the item                                                | "f528a3beb5274855b990dcbcc29df0d6"                                                  |
| charge_description       | String      | required     |  description                                         | "example description"                                              |
| price    | Double      | required     | price for the item                                                | 80.0                                               |
| quantity              | Int | required     | quantity for the item | 1                                         |   


FawryLaunchModel
| **PARAMETER**     |          **TYPE**        | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                         |
|-------------------|--------------------------|--------------|---------------|---------------|
| customer          | LaunchCustomerModel      | optional     | Customer information.                             | \-                                                |
| merchant          | LaunchMerchantModel      | required     | Merchant information.                             | \-                                                |
| signature          | String      | Optional - Should be always nil     | \-                             | \-                                               |
| paymentWithCardToken          | Bool      | Optional - Should be always false     | \-                             | false                                               |
| avlInfo           | AVLInfo                  | Optional - Sould be always nil     | \-                                                | \-                                                |
| apiPath           | String                   | Optional - default value = nil | If the user needs to send a path of URL.| "fawrypay-a pi/api/"                      |
| chargeInfo           | [ChargeItemsParamsModel]                   | required | items that will be paid off |Example in step 2.1

| **Property**      |          **TYPE**        | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                         |
|-------------------|--------------------------|--------------|---------------|---------------|
| skipReceipt       | Boolean                  | optional - default value = false    | to skip receipt after payment trial               | \-                                                |                                        |
| beneficiaryWalletNumber| String                   | optional     | \-                                                | \-                                |
| billingAcct       | String                   | optional     | \-                                                | \-                                     |



3.  Calling Mode:
     -  Payment Mode: Call launchAVL from the shared instance of FrameworkHelper and the payment screen will launch.
<img width="739" src="https://github.com/user-attachments/assets/fb558403-c753-46aa-b57c-c23ece794974">

| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| on                | UIViewController| required     | The view controller which will be the starting point of the SDK.| self                                             |
| launchModel       | FawryLaunchModel| required     | Has info that needed to launch the SDK            | Example in step 2.1                                  |
| baseURL           | String          | required     | Provided by the support team. Use staging URL for testing and switch for production to go live.|(https://atfawry.fawrystaging.com) (staging)        (https://atfawry.com) (production)|
| appLanguage       | String          | required     | SDK language which will affect SDK's interface languages.| AppLanguage.English                           |
| enable3Ds         | Bool            |optional - default value = false| to allow 3D secure payment make it “true”   | true                                           |
| logoImage         | UIImage          | required     | if merchant wants to set an image not title | \-  
| titleHeader         | String          | required     | if merchant wants to set title not an image | "Fawry"   
| card        | SavedCard          | required     | Has info that needed for credit card | Example in step 2.1  |
| transactionPurpose        | String          | optional     | \- | "nameExample"  |
| authCaptureModePayment        | Bool          | required     | \- | true  |


## **Step 3: Override the SDK colors**

1.  Add a plist file to your project named “Style”.
2.  Add keys named:

    -   primaryColorHex
    -   secondaryColorHex
    -   tertiaryColorHex
    -   headerColorHex

3.  Give the keys values of your preferred hex color codes
<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/6.png" width="700"/>


Example:

<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/7.png" width="300"/>


## **Callbacks Explanation:**
-   **launchAVL, payUsingCreditCardSeamless:**\
    There are 5 callbacks:
    -   **completionBlock: { FawrySDKStatusCode? in }**
        -   called when flow launched successfully.

    -   **onPreCompletionHandler: { FawryError? in }**
        -   called when flow NOT launched.

    -   **errorBlock: { FawryError? in }**
        -   if the payment didn't pass.
        -   if you enabled the receipt, this callback will be called after clicking the done button in the receipt.
        -   if you disabled the receipt, this callback will be called upon the finish of the payment screen and the failure of the payment.

    -   **onPaymentCompletedHandler: { Any ? in }**
        -   will be called only whether the payment passed or not. And it's called upon receiving the response of the payment either success or failure.

    -   **onSuccessHandler: {Any ? in }**
        -   if the payment passed.
        -   if you enabled the receipt, this callback will be called after clicking the done button in the receipt.
        -   if you disabled the receipt, this callback will be called upon the finish of the payment screen and the success of the payment.
            





## **Look and Feel:**
1. **AVL amount :**
   - Now textfield for Amount will be editable when avlAmount in launchAVL = nil.
3. **Color:**
   -  You can change color from Style. Plist you can add these Kays in Style.Plist.
       -   fawry_black_Hex
       -   fawry_background_Hex
       -   fawry_blue_Hex
       -   fawry_Yellow_Hex
       -   fawry_Green_Hex
       -   fawry_white_Hex
         
5. **Logo:**
   - You can change Logo from launchAVL in parameter logoImage you can set UIimage.
7. **Fonts:**
   -  You can change fonts from launchAVL in parameter boldFont for titles and regulerFont you can set UIFont.
 
<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/8.png" width="300"/>      <img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/9.png" width="300"/>

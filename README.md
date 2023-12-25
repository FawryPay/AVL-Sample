# 

# **FawryPaySDK-AVL iOS**

Accept popular payment methods with a single client-side implementation.

## **Before You Start**

Use this integration if you want your iOS application to:

-   Accept cards and other payment methods.
-   Save and display cards for reuse.

Make sure you have an active FawryPay account, or [**create an account**](https://atfawry.fawrystaging.com/merchant/register).


### **How iOS SDK Looks Like**
![](https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/1.png) ![](https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/2.png)

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

     pod ‘FawryPaySDK-AVL’

3. Open the terminal navigated to your project root folder
4. Run pod install


## **Step 2: Initialize FawryPay IOS SDK**

1. Import FawryPay SDK in your Swift file.

``` swift
import FawryFrameworkAnonymous
```
2. Create an instance of
    - LaunchCustomerModel
    - LaunchMerchantModel
    - AVLInfo
    - FawryLaunchModel

and pass the required parameters (Required and optional parameters are determined below).
![](https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/4.png)


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
| merchantCode   | String   | required     | Merchant ID provided during FawryPay account setup.                                                                                                                            | +/IPO2sghiethhN6tMC==               |
| merchantRefNum | String   | required     | Merchant's transaction reference number is random 10 alphanumeric digits. You can call FrameworkHelper.shared?.getMerchantReferenceNumber() to generate it rather than pass it. | A1YU7MKI09                          |
| secureKey      | String   | required     | provided by support                                                                                                                                                            | 4b8jw3j2-8gjhfrc-4wc4-scde-453dek3d |

AVLInfo
| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| length            | Int      | required     | \-                                                | 6                                                  |
| btcWithFees       | Int      | required     | \-                                                | 4933                                               |
| btcWithoutFees    | Int      | required     | \-                                                | 4428                                               |
| pans              | [String] | required     | BANs related to the bank to use the btcWithoutFees| [“512345”]                                         |



FawryLaunchModel
| **PARAMETER**     |          **TYPE**        | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                         |
|-------------------|--------------------------|--------------|---------------|---------------|
| customer          | LaunchCustomerModel      | optional     | Customer information.                             | \-                                                |
| merchant          | LaunchMerchantModel      | required     | Merchant information.                             | \-                                                |
| avlInfo           | AVLInfo                  | required     | \-                                                | \-                                                |
| apiPath           | String                   | Optional - default value = nil | If the user needs to send a path of URL.| "fawrypay-a pi/api/"                      |

| **Property**      |          **TYPE**        | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                         |
|-------------------|--------------------------|--------------|---------------|---------------|
| skipReceipt       | Boolean                  | optional - default value = false    | to skip receipt after payment trial               | \-                                                |
| skipCustomerInput | Boolean                  | optional - default value = true     |to skip login screen in which we take email and mobile| \-                                                |
| beneficiaryName   | String                   | mandatory     | \-                                                | “name”                                         |
| beneficiaryWalletNumber| String                   | mandatory     | \-                                                | “01234567890”                                |
| avlFees           | Double                   | mandatory     | \-                                                | 3.00                                              |
| billingAcct       | String                   | mandatory     | \-                                                | “01234567890”                                     |



3.  Calling Mode:
     -  Payment Mode: Call launchAVL from the shared instance of FrameworkHelper and the payment screen will launch.
<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/5.png" width="900"/>

| **PARAMETER**     | **TYPE** | **REQUIRED** | **DESCRIPTION**                                 | **EXAMPLE**                                          |
|---------------|---------------|---------------|---------------|---------------|
| on                | UIViewController| required     | The view controller which will be the starting point of the SDK.| self                                             |
| launchModel       | FawryLaunchModel| required     | Has info that needed to launch the SDK            | Example in step 2                                  |
| baseURL           | String          | required     | Provided by the support team. Use staging URL for testing and switch for production to go live.|(https://atfawry.fawrystaging.com) (staging)        (https://atfawry.com) (production)|
| appLanguage       | String          | required     | SDK language which will affect SDK's interface languages.| AppLanguage.English                           |
| enable3Ds         | Bool            |optional - default value = false| to allow 3D secure payment make it “true”   | true                                           |
| avlAmount         | Double          | required     | depends on refund configuration: will be true when refund is enabled and false when refund is disabled| 7.0                       |



## **Step 3: Override the SDK colors**

1.  Add a plist file to your project named “Style”.
2.  Add keys named:

    -   primaryColorHex
    -   secondaryColorHex
    -   tertiaryColorHex
    -   headerColorHex

3.  Give the keys values of your preferred hex color codes
<img src="https://github.com/FawryPay/IOS-Fawrypay-AVL-Sample/blob/main/Docs/6.png" width="700"/>










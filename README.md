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


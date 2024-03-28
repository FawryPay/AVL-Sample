//
//  ViewController.swift
//  AVL Sample
//
//  Created by Ahmed Sharf on 15/01/2023.
//

import UIKit
import FawryPaySDK_AVL

class ViewController: UIViewController {
    
    let dictionaryForLocalization: NSDictionary = ["cardNumber": "Card Number*","expiryDate": "Expiry Date(mm/yy)*", "cvv": "CVV*", "cardHolderName-avl":"Sender/Card Holder Name*", "userData": "User Data", "amount": "Amount", "beneficiaryName": "Beneficiary Name", "transactionPurpose": "Transaction Purpose", "fundMyWallet": "Fund my own wallet","subtotal": "Subtotal", "Fawry Fees": "Fawry Fees", "total": "Total", "confirmPayment": "Confirm Payment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowPayment(_ sender: UIButton) {
        
        let avlInfo = AVLInfo(length: 6 , btcWithFees: 4933, btcWithoutFees: 4428 , pans: ["512345"], avlFeesOffUs: 7.7, avlFeesOnUs: 5.0, minValue: 10.3, maxValue: 20.3)
        let customerInfo = LaunchCustomerModel(customerName: "Mohamed", customerEmail: "email@gmail.com", customerMobile: "+0100000000")
        
        let merchantInfo = LaunchMerchantModel(merchantCode: "siYxylRjSPyg6dz0QH/y9A==",
                                               merchantRefNum: FrameworkHelper.shared?.getMerchantReferenceNumber(),
                                               secureKey: "086f55c1-463b-425a-9342-f75b094c8b3e")
        let launchModel = FawryLaunchModel(customer: customerInfo,
                                           merchant: merchantInfo,
                                           chargeItems: nil,
                                           signature: nil,
                                           avlInfo: avlInfo,
                                           apiPath: nil)
        
        launchModel.skipCustomerInput = true
        launchModel.skipReceipt = false
        
//        launchModel.beneficiaryName = "Mohamed"
        launchModel.beneficiaryWalletNumber = "01011100222"
        launchModel.billingAcct = "01010202044"
     //   launchModel.avlFees = 7.7
        
        FrameworkHelper.shared?.launchAVL(on: self,
                                          launchModel: launchModel,
                                          baseURL: "https://atfawrystaging.atfawry.com/",
                                          appLanguage: AppLanguage.English,
                                          enable3Ds: true,
                                          avlAmount: nil,
                                          logoImage: UIImage(named: "FawryImage"),
                                          boldFont: UIFont.boldSystemFont(ofSize: 17),
                                          regulerFont:UIFont.italicSystemFont(ofSize: 17),
                                          completionBlock: { (status) in
            print("Payment Method: SDK Loaded with status \(status)")
        }, onPreCompletionHandler: { (error) in
            print("Payment Method: SDK Launch on pre completion \(error?.message)")
        }, errorBlock: { (error) in
            print(error?.errorCode)
            print(error?.message)
            print(error?.usedBTC)
            print(error?.refNumber)
            print("Payment Method: has error \(error?.message)")
        }, onPaymentCompletedHandler: {
            (chargeResponse) in
            if let response = chargeResponse as? PaymentChargeResponse{
                print("mer ref num", response.merchantRefNumber)
                print("used BTC", response.usedBTC)
                print("referenceNumber", response.referenceNumber)
            }
            
            if let er = chargeResponse as? FawryError{
                print(er.message)
            }
        }, onSuccessHandler: { (response) in
            let merchantRefNumber = (response as? PaymentChargeResponse)?.merchantRefNumber ?? ""
            print("Payment Method: Success Handler: \(merchantRefNumber)")
            let paymentTime = (response as? PaymentChargeResponse)?.paymentTime ?? 0.0
            let authNumber = (response as? PaymentChargeResponse)?.authNumber ?? 0
            let cardLastFourDigits = (response as? PaymentChargeResponse)?.cardLastFourDigits ?? 0
            
            print("Payment Method: Success Handler paymentTime: \(paymentTime)")
            print("Payment Method: Success Handler authNumber: \(authNumber)")
            print("Payment Method: Success cardLastFourDigits: \(cardLastFourDigits)")
        })
    }
}


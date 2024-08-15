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
        
        let avlInfo = AVLInfo(length: 6 , btcWithFees: 4933, btcWithoutFees: 4428 , pans: ["512345"], avlFeesOffUs: 0, avlFeesOnUs: 0)
        
        let customerInfo = LaunchCustomerModel(customerName: "Ahmed", customerEmail: "ahmedamrsharf@gmail.com", customerMobile: "01127927617", customerProfileId: "71917")
        
        let merchantInfo = LaunchMerchantModel(merchantCode: "siYxylRjSPyg6dz0QH/y9A==",
                                               secureKey: "086f55c1-463b-425a-9342-f75b094c8b3e")
        let launchModel = FawryLaunchModel(customer: customerInfo,
                                           merchant: merchantInfo,
                                           signature: nil,
                                           paymentWithCardToken: false,
                                           avlInfo: avlInfo,
                                           apiPath: "ECommerceWeb/api/",
                                           showZeroFeesView: true)
        
        launchModel.skipReceipt = true
        
     //   launchModel.beneficiaryName = "Mohamed"
        launchModel.beneficiaryWalletNumber = "01011100222"
        launchModel.billingAcct = "01010202044"
        //launchModel.avlFees = 7.7
        
        FrameworkHelper.shared?.launchAVL(on: self,
                                          launchModel: launchModel,
                                          baseURL: "https://atfawrystaging.atfawry.com/",
                                          appLanguage: AppLanguage.English,
                                          enable3Ds: true,
                                          translationDict: nil,
                                          avlAmount: nil,
                                          avlAmountDataType: .integer,
                                          logoImage: nil,
                                          titleHeader: "Fawry",
                                          boldFont: nil,
                                          regulerFont: UIFont(name: "SFProText-RegularItalic", size: 17),
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
            let authNumber = (response as? PaymentChargeResponse)?.authNumber ?? "0"
            let cardLastFourDigits = (response as? PaymentChargeResponse)?.cardLastFourDigits ?? "0"
            
            print("Payment Method: Success Handler paymentTime: \(paymentTime)")
            print("Payment Method: Success Handler authNumber: \(authNumber)")
            print("Payment Method: Success cardLastFourDigits: \(cardLastFourDigits)")
        })
    }
    
    @IBAction func seamlessAVLAction(_ sender: Any) {
        let secureKey = "3928e924-b8b0-4c13-a80f-e9ba0d104d35"
        let merchantCode = "770000019516"
        let serverURL = "https://atfawry.fawrystaging.com/"
        
        let customerInfo = LaunchCustomerModel(customerName: "Ahmed", customerEmail: "ahmedamrsharf@gmail.com", customerMobile: "01127927617", customerProfileId: "71917")
        let chargeInfo = ChargeItemsParamsModel.init(itemId: "f528a3beb5274855b990dcbcc29df0d6", charge_description: "example description", price: 80.0, quantity: 1)
        
        let merchantInfo = LaunchMerchantModel(merchantCode: merchantCode,
                                               merchantRefNum: self.getMerchantReferenceNumber(),
                                               secureKey: secureKey)

        let launchModel = FawryLaunchModel(customer: customerInfo,
                                           merchant: merchantInfo,
                                           signature: nil,
                                           paymentWithCardToken: false,
                                           avlInfo: nil,
                                           apiPath: nil,
                                           chargeItems: [chargeInfo])
        
        let card = SavedCard.init(cardHolderName: "SAMEH",
                                  cardNumber: "5123450000000008",
                                  cardExpiryMonth: "01",
                                  cardExpiryYear: "39",
                                  cvv: "100")
        
        launchModel.skipReceipt = true
        launchModel.beneficiaryWalletNumber = nil
        launchModel.billingAcct = nil
        FrameworkHelper.shared?.payUsingCreditCardSeamless(on: self,
                                                           launchModel: launchModel,
                                                           baseURL: serverURL,
                                                           appLanguage: AppLanguage.English,
                                                           enable3Ds: true,
                                                           translationDict: nil,
                                                           logoImage: nil,
                                                           titleHeader: "Fawry",
                                                           boldFont: nil,
                                                           regulerFont: nil,
                                                           card: card,
                                                           transactionPurpose: "namee",
                                                           authCaptureModePayment: true,
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
            let authNumber = (response as? PaymentChargeResponse)?.authNumber ?? "0"
            let cardLastFourDigits = (response as? PaymentChargeResponse)?.cardLastFourDigits ?? "0"
            
            print("Payment Method: Success Handler paymentTime: \(paymentTime)")
            print("Payment Method: Success Handler authNumber: \(authNumber)")
            print("Payment Method: Success cardLastFourDigits: \(cardLastFourDigits)")
        })
    }
    public func getMerchantReferenceNumber() -> String {
        let count = 10
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< count {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}


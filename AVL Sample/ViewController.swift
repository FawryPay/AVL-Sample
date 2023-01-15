//
//  ViewController.swift
//  AVL Sample
//
//  Created by Ahmed Sharf on 15/01/2023.
//

import UIKit
import FawryFrameworkAnonymous

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowPayment(_ sender: UIButton) {
        
        let avlInfo = AVLInfo(length: 6 , btcWithFees: 4933, btcWithoutFees: 4428 , pans: ["512345"])
        
        let customerInfo = LaunchCustomerModel(customerName: "Mohamed", customerEmail: "email@gmail.com", customerMobile: "+0100000000")
        
        let merchantInfo = LaunchMerchantModel(merchantCode: "TUXdyCB7z5yFNpv0uxhukA==",
                                               merchantRefNum: FrameworkHelper.shared?.getMerchantReferenceNumber(),
                                               secureKey: "8ebd699a-2210-41fd-ae6d-e4a72cdda20a")
        let launchModel = FawryLaunchModel(customer: customerInfo,
                                           merchant: merchantInfo,
                                           chargeItems: nil,
                                           signature: nil,
                                           avlInfo: avlInfo,
                                           apiPath: nil)
        
        launchModel.skipCustomerInput = true
        launchModel.skipReceipt = false
        
        launchModel.beneficiaryName = "Mohamed"
        launchModel.beneficiaryWalletNumber = "01011100222"
        launchModel.billingAcct = "01011100222"
        launchModel.avlFees = 7.7
        
        FrameworkHelper.shared?.launchAVL(on: self,
                                          launchModel: launchModel,
                                          baseURL: "https://fawrydig.fawrystaging.com:2038/",
                                          appLanguage: AppLanguage.English,
                                          enable3Ds: true,
                                          avlAmount: 20,
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
            
            if let er = chargeResponse as? FawryFrameworkError{
                print(er.message)
            }
        }, onSuccessHandler: { (response) in
            let merchantRefNumber = (response as? PaymentChargeResponse)?.merchantRefNumber ?? ""
            print("Payment Method: Success Handler: \(merchantRefNumber)")
        })
    }
}


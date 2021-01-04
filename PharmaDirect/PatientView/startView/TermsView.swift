//
//  TermsView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-11.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        
        VStack {
        
            Text("")
                .navigationBarTitle("Terms and Conditions", displayMode: .inline)
//                .navigationBarHidden(true)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                Text("""
                    
                    1. TERMS AND CONDITIONS
                    By accessing the pharmacie app you agree to be bound by the terms and conditions set out below.
                        
                    2. NO WARRANTY OR REPRESENTATION
                    While pharmacie uses reasonable efforts to include accurate and up-to-date information on the app, your use and browsing of the app is at your risk. Nothing in the app, including product or service information, shall add to or change any contract for products or services you may have with pharmacie, its, suppliers or affiliates. Neither pharmacie, its alliance partners, suppliers, affiliates nor any other party involved in creating, producing, or delivering the app is liable for any direct, indirect, incidental, special, consequential, punitive or other damages whatsoever including business interruption, loss of use, data, information, profits (regardless of the form of action, including but not limited to contract, negligence or other tortious act) arising out of or in connection with your access or use of the app even if pharmacie has been advised of or foresees the possibility of any damages occurring. Without limiting the foregoing, everything on the app is provided to you “AS IS” WITHOUT REPRESENTATION, WARRANTY OR CONDITION OF ANY KIND, EITHER EXPRESS, IMPLIED, OR STATUTORY INCLUDING, BUT NOT LIMITED TO, IMPLIED REPRESENTATIONS, WARRANTIES OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, DURABILITY, TITLE, NON-INFRINGEMENT OF INTELLECTUAL PROPERTY RIGHTS OR INTER-OPERABILITY OF PRODUCTS OR SERVICES. Changes or updates to the contents of this app may occur without notice.
                    
                    3. USE OF INFORMATION
                    You hereby agree that you shall not use any information contained in this app or the links to this app in any claims, proceedings, suits or actions against pharmacie, its suppliers or affiliates. You may not post, publish, reproduce, transmit or otherwise distribute information or material on the app: (a) constituting or encouraging conduct that would constitute a criminal offence or give rise to civil liability; (b) which is protected by copyright, or other intellectual property right or derivative works thereof, without obtaining permission of the copyright holder; (c) otherwise use this app in a way that is contrary to law or which would adversely impact use of the app or the Internet by other users including the posting or transmitting of other information or software containing viruses or other disruptive components.

                    4. MONITORING
                    pharmacie is under no obligation to monitor the app and assumes no responsibility or liability should its content be modified or altered in any way without pharmacie’ consent.

                    5. REVISIONS
                    pharmacie may at any time revise these Terms and Conditions by updating this posting. You should therefore review these Terms and Conditions each time you access the app.

                    6. PRODUCT DESCRIPTIONS
                    pharmacie attempts to be as accurate as possible. However, pharmacie does not warrant that product descriptions or other content of this app is accurate, complete, reliable, current or error-free. If a product offered by pharmacie is not as described, your sole remedy is to return the product or as described in the contractual agreement with pharmacie or return the product. Price and availability information is subject to change without notice.

                    7. VIRUSES
                    pharmacie assumes no responsibility and shall not be liable for any damages to or viruses that may infect your computer equipment or other property on account of your access to, use of or browsing in the app or your downloading of any materials, data, text or images from the app.

                    8. RIGHT OF INDEMNIFICATION
                    You agree to defend, indemnify and hold pharmacie, its suppliers, alliance partners, affiliates and related companies harmless from any and all liabilities, costs and expenses, including reasonable legal fees related to any violation of these Terms and Conditions by you, or in connection with your use of the app or with the placement or transmission of any message or information on the app by you.

                    9. WAIVER
                    pharmacie’s failure to insist upon or enforce strict performance of any provision of these Terms and Conditions shall not be construed as a waiver of any provision or rights contained in these Terms and Conditions.

                    10. GOVERNING LAWS
                    By visiting the app, you agree that these Terms and Conditions shall be governed by the laws of the province of Ontario and the federal laws of Canada applicable therein and you agree to be bound by the laws of these jurisdictions.

                    """
                )
            }).padding()
        }
    }
}

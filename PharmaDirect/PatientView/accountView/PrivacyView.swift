//
//  PrivacyView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-12.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct PrivacyView: View {

        @Environment(\.colorScheme) var colorScheme
        @Environment(\.managedObjectContext) var context: NSManagedObjectContext
        
        @State var selection: Int?
        
        @State var privacyCompletionFlag: Bool
    
        init () {
            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                _privacyCompletionFlag = State(wrappedValue: UserDefaults.standard.bool(forKey: "privacyCompletionFlag"))
            } else {
                _privacyCompletionFlag = State(wrappedValue: false)
            }
        }
    
        var body: some View {
            
                VStack {
                    Text("")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    Image("cropped-img7")
                        .resizable()
                        .frame(height: UIScreen.main.bounds.height * 0.18)
                        .overlay(
                            Text("Provide all necessary info to your pharmacist")
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.18)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .opacity(0.7)
                        )
                          
                    
                    if UserDefaults.standard.bool(forKey: "signupCompletionFlag") != true {
                        HStack {
                            ForEach(0..<8) { index in
                                Rectangle()
                                    .foregroundColor(Color(index <= 7 ? UIColor.lightGreen : .lightGray))
                                    .frame(height: 5)
                            }
                        }
                            .padding()
                    }
                    
                    
                    

                        
                    Text("You authorize us to use and disclose personal health information as stated below: ")
                        
                    ScrollView(.vertical, showsIndicators: false, content: {
                        Text("""
                    
                    1. OUR COMMITMENT TO PRIVACY.
                    We are committed to the protection and privacy of our customers. We have and will take measures that protect the privacy of personal information and personal health information held by us.
                    This Privacy Policy provides you with details regarding: (1) why we collect personal information and personal health information; (2) what we do with that information; (3) the steps we take to ensure that access to that information is secure; (4) how you can access personal information and personal health information pertaining to you; and (5) who you should contact if you have questions or concerns about our policies or practices.
                    Since we regularly review our policies and practices, your comments are always welcome. We reserve the right to change this Privacy Policy at any time; however, any changes or additions to Section 5 regarding the reasons we use personal information will not apply to you unless you consent to them. We will alert you that changes have been made by indicating at the top of the Privacy Policy the date that it was last updated. This Privacy Policy was last updated on April 22, 2013. We encourage you to review our Privacy Policy to make sure that you understand how information that you provide will be used.
                    Children: We encourage parents to take an active interest in their children's use of the Internet. We do not intend to collect information from children who are under 18 years of age. If you are under 18, please do not provide information on our Web site.

                    2. WHAT IS PERSONAL INFORMATION?
                    In general terms, personal information means any information about an identifiable individual. For example, this includes your name, postal and e-mail address, telephone number, credit card number, demographic information and purchasing history. A special category of personal information is "personal health information", which we describe in Section 3 below.
                    Personal information does not include aggregate information (data about a group or category of products, services or customers, from which individual customer identities have been removed). For example, information about how you use a service may be collected and combined with information about how others use the same service, but no personal information will be included in the resulting data. Likewise, information about the products you purchase may be collected and combined with information about the products purchased by others. Aggregate information about product purchases helps us understand trends and customer needs. It can also assist us in determining whether it would be appropriate to offer new Web site functions by looking at customer Web site browsing activities.

                    3. WHAT IS PERSONAL HEALTH INFORMATION?
                    Personal health information means any information relating to your physical or mental health collected or generated in the course of our providing you with the health services you request, and prescription profiles for fulfillment of pharmacy orders. Examples of personal health information may include your medical history, drug prescription information, or health insurance information, which we may require in order to provide you with pharmacy-related services. It may also include information you provide to Costco health services personnel when receiving counselling or advice, or when contacting Costco with a comment, question or complaint about our health services.

                    4. WHEN WE COLLECT PERSONAL INFORMATION.
                    We only collect such personal information as is strictly necessary for the purposes outlined in Section 5. We collect personal information: (1) when you contact us; (2) when you use our Web site; (3) when you participate in any of our programs; and (4) when you place orders or make purchases on our Web site. We may automatically collect some information when you visit our Web site, such as your computer's network address and operating system, the site from which you linked to us, and the time and date of your visit and purchases. This information is not linked by us to personal information, but rather is only used to compile aggregate information. This information may be collected through the use of cookies (see our "On-line privacy practices" in Section 12 below).

                    5. HOW WE USE PERSONAL INFORMATION.
                    As part of our business operations, we hold and use certain personal information pertaining to you in order to process your requests, and to understand your needs so that we can serve you better. If you ask us to, we will also tell you about opportunities we think will be of interest to you, such as our promotional programs. Specifically, we may use personal information for the following purposes:
                    Notifying you of recalls or safety issues;
                    Managing the provision of goods and services to you, including to determine your credit status and for fraud detection and identification purposes;
                    Managing invoicing, accounting and information security services related to our transactions with you;
                    Monitoring your satisfaction with our programs and services and contacting you regarding the status of such programs and services;
                    As described in our "On-line privacy practices" in Section 12 below; and
                    If you ask us to, promoting, offering or marketing additional products, goods and services we offer.
                    We may use personal information to create aggregate information as well.

                    6. WHEN WE SHARE PERSONAL INFORMATION.
                    Personal information we collect in accordance with this Privacy Policy may be shared with the Costco Affiliates, for the purposes listed above, provided that such shared information is required for and is used and disclosed for such purposes only. Personal information may also be disclosed to unaffiliated third parties in connection with the sale, assignment or other transfer of our business, in which case we will require such third parties to adhere to the terms of this Privacy Policy.
                    From time to time we engage unaffiliated third parties and their affiliates, agents and subcontractors ("Service Providers") to perform certain technological or administrative services. For example, a Service Provider may be asked to perform credit card processing services or be asked to run a computer program that identifies which of our customers purchased a particular product so we can notify those customers of special programs regarding the same or similar products. We also may use a Service Provider to host and administer one or more of our Web sites, process and store data, and fulfill similar technology-related functions on our behalf. In these circumstances, the personal information that the Service Provider receives is limited to only the personal information held by us that they need in order to render their service to us. The companies that are provided with the personal information are first required to sign an agreement that obligates them to keep the information confidential and secure and prohibits them from using it for unauthorized purposes.
                    We also may engage Service Providers to provide us with cloud computing services. Cloud computing is the provision of network-based services, located on remote computers, that allow individuals and businesses to use software and hardware operated by third parties. Examples of these services include online file storage, webmail and online business applications. Service Providers have policies and processes in place to ensure that the confidentiality of information in their care is properly safeguarded at all times.
                    You acknowledge that Costco's e-mail systems are operated in the "cloud". Cloud computing allows businesses or individuals to use computers and software programs operated by third parties. The computers provided by Costco's current "cloud" Service Provider may be located in Canada, the United States or the European Union. Costco's current "cloud" Provider has policies and processes in place to ensure that the confidentiality of information in their care is safeguarded at all times.

                    7. WHEN WE COLLECT, HOW WE USE AND WHEN WE SHARE PERSONAL HEALTH INFORMATION.
                    In the course of providing you with pharmacy-related services and programs we introduce from time to time, we collect, generate and use personal health information to provide you with the health services you request, to obtain or process payment for health services and for internal management purposes, including planning, resource allocation, policy development, quality improvement, monitoring, audit, evaluation and reporting. Your personal health information may be shared between Costco Affiliates for these purposes only.

                    8. HOW LONG DO WE HOLD PERSONAL INFORMATION AND PERSONAL HEALTH INFORMATION.
                    Personal information and personal health information is retained only for so long as is necessary for the purposes set out above. When no longer required, we will destroy, erase or de-personalize the personal information. Legal requirements may necessitate our retaining some or all of the personal information and personal health information we hold for a period of time that is longer than we might otherwise hold it. However, Costco will restrict access to such information to prevent it from being used except for the fulfilment of these legal requirements.

                    9. SECURITY MEASURES.
                    We will continue to keep in place security measures in an effort to protect personal information and personal health information held by us from unauthorized use, access, disclosure, distribution, loss or alteration. We employ physical, administrative, contractual and technological safeguards to protect personal information, and insist that our Service Providers do the same. Access to personal information and personal health information will be restricted to authorized personnel who require the information in order to perform their duties properly. In addition, access will be limited to only that information that is strictly necessary for the performance of those duties. Please also see our "On-line privacy practices" in Section 12 below.
                    We periodically update our policies regarding information security measures in an effort to protect the personal information and personal health information held by us in the most effective manner possible.

                    10. ACCESSING PERSONAL INFORMATION AND PERSONAL HEALTH INFORMATION.
                    Our customers are entitled to access the personal information and personal health information held by us concerning them. In recognition of the importance we attach to each customer's information, you can only access personal information and personal health information we hold about you, but not personal information and personal health information about your spouse or others. Under limited circumstances, we may give you access to personal information or personal health information that we hold about others, but only if required or permitted by law (for example, a parent or guardian may, in certain instances, be given access to the personal information or personal health information of a child or a person who requires a substitute decision maker).
                    """
                        )
                            
                    })
                    .padding(.horizontal)
                    
                    
                    Toggle("I've reviewed the privacy policy and understand my medical information will be used in accordance with this notice.", isOn: self.$privacyCompletionFlag)
                        .padding(.horizontal)
                        
                
                    
                    if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                        Button(action: {
                            self.selection = 9
                            UserDefaults.standard.set(true, forKey: "privacyCompletionFlag")
                            UserDefaults.standard.set(true, forKey: "signupCompletionFlag")
                            FormSubmissionToCoreData(context: context)
                        } ) { Text("Submit").font(.body).bold() }
                            .environment(\.managedObjectContext, self.context)
                            .disabled(privacyCompletionFlag == false)
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                            .foregroundColor(Color(.white))
                            .background(privacyCompletionFlag == false ? .gray : Color(UIColor.mainColor))
                            .padding()
                    } else {
                        
                        Button(action: {
                            self.selection = 0
                        } ) { Text("< Back").font(.body).bold() }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                            .foregroundColor(Color(.white))
                            .background(Color(UIColor.gradiant1))
                            .padding(.horizontal)
                        
                        Button(action: {
                            self.selection = 1
                            UserDefaults.standard.set(true, forKey: "privacyCompletionFlag")
                            UserDefaults.standard.set(true, forKey: "signupCompletionFlag")
                            FormSubmissionToCoreData(context: context)
                        } ) { Text("Next >").font(.body).bold() }
                            .environment(\.managedObjectContext, self.context)
                            .disabled(privacyCompletionFlag == false)
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                            .foregroundColor(Color(.white))
                            .background(privacyCompletionFlag == false ? .gray : Color(UIColor.mainColor))
                            .padding()
                    }
                    Group {
                        NavigationLink(destination: PaymentView(), tag: 0, selection: $selection) { EmptyView() }
                        NavigationLink(destination: HomeView(), tag: 1, selection: $selection) { EmptyView() }
                        NavigationLink(destination: HomeView(selectionValue: 1), tag: 9, selection: $selection) { EmptyView() }
                    }
                }
            
        }
    }
struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}

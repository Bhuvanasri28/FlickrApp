//
//  SafariView.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import UIKit
import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
     
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // Not updating anything here as this is simple use case
    }
}

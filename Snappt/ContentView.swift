//
//  ContentView.swift
//  Snappt
//
//  Created by Mackenzie Bryant on 5/2/20.
//  Copyright © 2020 Mackenzie Bryant. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    var selectPlatforms = ["Instagram", "Facebook", "TikTok", "YouTube"]
    @State private var selectedMode = 0
    @State var reportUserName: String = ""
    @State var isShowingImagePicker = false
    
    var isValid: Bool {
        if reportUserName.isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Platform")){
                    Picker(selection: $selectedMode, label: Text("Platforms")) {
                        ForEach(0..<selectPlatforms.count) {
                            Text(self.selectPlatforms[$0])
                        }
                    }.padding()
                }
                Section(header: Text("Please report the Username that has violated your safety online.")) {
                    HStack {
                        TextField("Username", text: $reportUserName)
                    }.padding()
                    
                }
                Section(header: Text("We strongly encourage you to share any photos that have violated your safety online.")) {
                    HStack {
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }, label: {
                            Text("Attach Photos")
                        })
                            .sheet(isPresented: $isShowingImagePicker, content: {
                        ImagePickerView()
                    })
                    }.padding()
                }
                Section {
                    Button(action: {
                        self.submitReport()
                    }) {
                        Text("Submit Report")
                }.padding()
            }
            } .navigationBarTitle("Snappt")
        }
    }
    func attachPhotos() {
    }
    func submitReport() {
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator()
    }
    
    // this is the tricky part
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage)
            }
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
    }
}

struct DummyView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<DummyView>) ->
        UIButton {
            let button = UIButton()
            button.setTitle("DUMMY", for: .normal)
            button.backgroundColor = .red
            return button
    }
    
    func updateUIView(_ uiView: DummyView.UIViewType, context: UIViewRepresentableContext<DummyView>) {
    }
}

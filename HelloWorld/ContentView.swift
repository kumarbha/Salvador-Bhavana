//
//  ContentView.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 07.02.23.
//

import SwiftUI

struct ContentView: View {
    @State var description: String = ""
    @ObservedObject var imageGenerationViewModel = ImageGenerationViewModel()
    
    var body: some View {
        VStack {
            headingView
            textEditorView
            generateImageButtonView
            imageView
            progressDisplayView
        }.alert(imageGenerationViewModel.alertMessage, isPresented: $imageGenerationViewModel.showAlert ) {
            cancelButtonView
        }.background(
            Image("Background")
        )
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

private extension ContentView {
    var textEditorView: some View {
        HStack {
            Text("Description")
                .font(.callout)
                .bold()
            TextField("Prompt", text: $description, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("*").foregroundColor(Color(hue: 1.0, saturation: 0.812, brightness: 0.863)).font(.largeTitle)
        }.padding()
    }
    var clearImageButtonView: some View {
        Button("Clear All") {
            imageGenerationViewModel.image = nil
            description = ""
        }
    }
    var generateImageButtonView: some View {
        Button(action: {
            imageGenerationViewModel.image = nil
            imageGenerationViewModel.sendRequest(prompText: description)
        }, label: {
            Text("Generate Images")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.cornerRadius(20))
                .foregroundColor(Color.black)
        }).padding().disabled(description.isEmpty)
    }
    
    
    var imageView: some View {
        VStack {
            if let imageRef = imageGenerationViewModel.image {
                Image(uiImage: imageRef)
                    .resizable()
                    .border(.white)
                    .frame(width: 250, height: 250)
                
                Button(action: {
                    imageGenerationViewModel.saveImage(image: imageRef)
                }, label: {
                    Text("Save Image")
                        .padding()
                        .background(Color.white.cornerRadius(20))
                        .foregroundColor(Color.black)
                }).padding()
            }
            clearImageButtonView.foregroundColor(Color.white)
        }
    }
    
    var progressDisplayView: some View {
        VStack {
            if imageGenerationViewModel.isWorking {
                ProgressView("Working ...").foregroundColor(Color.white)
            }
        }
    }
    var headingView: some View {
        Text("Image Generation Demo").font(.largeTitle).padding(.bottom, 35.0)
    }
    var cancelButtonView: some View {
        Button("OK", role: .cancel) { }
    }
}

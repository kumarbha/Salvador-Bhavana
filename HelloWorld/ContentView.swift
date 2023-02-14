//
//  ContentView.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 07.02.23.
//

import SwiftUI

struct ContentView: View {
    @State var description: String = ""
    @State var image: UIImage? = nil
    @State var isWorking: Bool = false
    var body: some View {
        ZStack {
            Image("Background").resizable().ignoresSafeArea()
            VStack {
                Text("Image Generation Demo").font(.largeTitle).padding(.bottom, 35.0)
                HStack {
                    Spacer()
                    Text("Description")
                        .font(.callout)
                        .bold()
                    Spacer()
                    TextField("Prompt", text: $description, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }.padding()
                Button(action: {
                    Task {
                        isWorking = true
                        do {
                            let response = try await ImageGenerationController().generateImage(prompt: description)
                            let imageURL = response.data[0].url
                            let (data,_) = try await URLSession.shared.data(from: imageURL)
                            image = UIImage(data: data)
                            isWorking = false
                        }
                        catch {
                            print(error)
                        }
                    }
                }, label: {
                    Text("Generate Images")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.cornerRadius(20))
                        .foregroundColor(Color.black)
                }).padding()
                if let imageRef = image {
                    Image(uiImage: imageRef)
                        .resizable()
                        .border(.white)
                        .frame(width: 250, height: 250)
                    Button("Clear Image") {
                        image = nil
                        description = ""
                    }.foregroundColor(Color.white)
                }
                if isWorking {
                    ProgressView("Working ...").foregroundColor(Color.white)
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

//
//  SwiftUIHomeView.swift
//  ArbOffc
//
//  Created by Debashis Pal on 12/02/24.
//

import SwiftUI

struct SwiftUIHomeView: View {
    let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"] // Sample image names
    
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            // Slideshow with indicator
            ZStack(alignment: .bottom) {
                Slideshow(images: images, selectedIndex: $selectedIndex)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    // Swiped left
                                    selectedIndex = min(selectedIndex + 1, images.count - 1)
                                } else if value.translation.width > 0 {
                                    // Swiped right
                                    selectedIndex = max(selectedIndex - 1, 0)
                                }
                            }
                    )
            }
            .frame(height: .infinity)
            .padding([.leading, .trailing],8)
            // Indicator
            HStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Circle()
                        .fill(index == selectedIndex ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                        .padding(.horizontal, 4)
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
            }
            .padding(.bottom, 8)
//            Spacer()
            
            // Display selected image below indicator
//            Text("Selected Image: \(images[selectedIndex])").padding()
        }
    }
}

struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIHomeView()
    }
}

// Sample Slideshow component
struct Slideshow: View {
    let images: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        Image(images[selectedIndex])
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
    }
}

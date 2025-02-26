//
//  ColoringView.swift
//  Chromosom47
//
//  Created by Bana Alshabib on 13/08/1445 AH.
//ColoringView

import SwiftUI
import PencilKit

struct Canvas: View {
    @State private var showAlert = false
    @State private var isDone = false

    let title: String
    let imageName: String
    let titleColor: Color

    init(title: String, imageName: String, titleColor: Color) {
        self.title = title
        self.imageName = imageName
        self.titleColor = titleColor
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Beige").edgesIgnoringSafeArea(.all)

                VStack {
                   
                  
                    PencilKitContainerView(imageName: imageName)
                        .foregroundColor(.white)
                        .shadow(radius: 12)
                
              
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            showAlert = true
                            
                            
                            
                        }
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you done coloring?"),
                    primaryButton: .default(Text("Done")) {
                        isDone = true
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
            .background(
                NavigationLink(
                    destination: Categories(),
                    isActive: $isDone,
                    label: { EmptyView() }
                )
            )
        }
    }
}

struct PencilKitContainerView: UIViewControllerRepresentable {
    let imageName: String

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let pencilKitViewController = PencilKitViewController(imageName: imageName)

        viewController.addChild(pencilKitViewController)
        viewController.view.addSubview(pencilKitViewController.view)
        pencilKitViewController.didMove(toParent: viewController)

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
       
    }
}

class PencilKitViewController: UIViewController {
    let toolPicker = PKToolPicker()
    let imageName: String

    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let canvasWidth: CGFloat = 600
        let canvasHeight: CGFloat = 600

        let pencilKitCanvasView = PKCanvasView(frame: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))
        pencilKitCanvasView.center = view.center
        pencilKitCanvasView.drawingPolicy = .anyInput

        toolPicker.addObserver(pencilKitCanvasView)
        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvasView)
        pencilKitCanvasView.becomeFirstResponder()

        view.addSubview(pencilKitCanvasView)

        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight)
        imageView.center = view.center

        view.addSubview(imageView)
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas(title: "School", imageName: "SchoolOutline", titleColor: Color("SchoolColor"))
        Canvas(title: "Tools", imageName: "ToolsOutline", titleColor: Color("ToolsColor"))
        Canvas(title: "Animals", imageName: "Animals", titleColor: Color("AnimalsColor"))
        Canvas(title: "Food", imageName: "Food", titleColor: Color("FoodColor"))

    }
}

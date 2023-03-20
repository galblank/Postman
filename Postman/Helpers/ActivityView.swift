//
//  ActivityView.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//
import SwiftUI

public class ActivityUIKitView: UIView {
    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct RepresentedActivityUIKitView: UIViewRepresentable {
    typealias UIViewType = ActivityUIKitView
    func updateUIView(_ uiView: ActivityUIKitView, context: Context) {

    }

    func makeUIView(context: Context) -> ActivityUIKitView {
        // Return ActivityUIKitView instance.
        let view = ActivityUIKitView()
        return view
    }
}

struct ActivityView: View {
    @ObservedObject var activityData = ActivityModel(text: "",
                                                     progress: 0.0,
                                                     showProgress: false)
    var body: some View {
            ZStack {
                VStack {
                    HStack {
                        Image("court_bg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 50)
                        Spacer()
                    }
                    Spacer()
                    if activityData.showProgressBar {
                        ProgressView(value: activityData.progress, label: {
                            Text(activityData.text)
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.bottom, 10)
                                .multilineTextAlignment(.leading)
                        })
                        .tint(.white)
                        .padding()
                    } else {
                        ProgressView {
                            Text(activityData.text)
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding()
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                    }
                    Spacer()
                }
            }
            .frame(maxHeight: 200)
            .frame(maxWidth: 300)
            .background(.white)
            .foregroundColor(Color.primary)
            .cornerRadius(20)
            .padding()
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var activityData = ActivityModel(text: "Please wait...",
                                                     progress: 0.5,
                                                     showProgress: true)
    static var previews: some View {
        ActivityView(activityData: activityData)
            .background(.clear)
    }
}

//
//  ContentView.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    func clearButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapAllClear()
        }, label: {
            GrayCircleButtonView(text: "AC",size: size)
        })
    }
    
    func leftBracketButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "(")
        }, label: {
            GrayCircleButtonView(text: "(",size: size)
        })
    }
    
    func rightBracketButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: ")")
        }, label: {
            GrayCircleButtonView(text: ")",size: size)
        })
    }
    
    func divideButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "/")
        }, label: {
            OrangeCircleButtonView(text: "/",size: size)
        })
    }
    
    func multiplyButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "*")
        }, label: {
            OrangeCircleButtonView(text: "*",size: size)
        })
    }
    
    func minusButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "-")
        }, label: {
            OrangeCircleButtonView(text: "-",size: size)
        })
    }
    
    func plusButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "+")
        }, label: {
            OrangeCircleButtonView(text: "+",size: size)
        })
    }
    
    func computeButton(size:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapEqual()
        }, label: {
            OrangeCircleButtonView(text: "=",size: size)
        })
    }
    
    func computeSize(size:CGFloat) -> CGFloat {
        return size/9;
    }
    
    var body: some View {
        ZStack {
            Color(.black)
            GeometryReader() { proxy in
                let size = proxy.size.height/9
                ZStack(alignment: .bottomTrailing) {
                    Color(.black)
                    VStack(alignment: .leading){
                        Text(viewModel.currentNumberString)
                            .foregroundColor(.white)
                            .font(.system(size:size/1.5))
                        Spacer()
                        if let result = viewModel.result {
                            HStack {
                                Spacer()
                                Text(result)
                                    .foregroundColor(.white)
                                    .font(.system(size:size/1.5))
                            }
                        }
                        HStack {
                            Spacer()
                            VStack {
                                HStack {
                                    Group {
                                        clearButton(size:size)
                                        leftBracketButton(size:size)
                                        rightBracketButton(size:size)
                                    }
                                    .padding(Self.buttonPadding)
                                }
                                ForEach(0..<3) { outNumber in
                                    HStack {
                                        ForEach(1..<4) { innerNumber in
                                            let number = (2-outNumber)*3+innerNumber
                                            Button(action: {
                                                viewModel.tapExpression(sign: "\(number)")
                                            }, label: {
                                                BlackCircleButtonView(text: "\(number)",size:size)
                                            })
                                            .padding(Self.buttonPadding)
                                        }
                                    }
                                }
                                HStack {
                                    Group {
                                        Button(action: {
                                            viewModel.tapExpression(sign: "0")
                                        }, label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius:size/2)
                                                    .frame(width:size*2+10+2*Self.buttonPadding,height:size,alignment:.center)
                                                    .foregroundColor(Color(grayScale:BlackCircleButtonView.grayScale))
                                                Text("0")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: size/2.5))
                                            }
                                        })
                                        Button(action: {
                                            viewModel.tapExpression(sign: ".")
                                        }, label: {
                                            ZStack {
                                                Circle()
                                                    .frame(width:size,height:size,alignment:.center)
                                                    .foregroundColor(Color(grayScale:BlackCircleButtonView.grayScale))
                                                Text(".")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: size/2.5))
                                            }
                                        })
                                    }
                                    .padding(Self.buttonPadding)
                                }
                            }
                            VStack {
                                Group {
                                    divideButton(size:size)
                                    multiplyButton(size:size)
                                    minusButton(size:size)
                                    plusButton(size:size)
                                    computeButton(size:size)
                                }
                                .padding(Self.buttonPadding)
                            }
                        }
                    }
                }
            }
            .padding()
        }

    }
    
    static let buttonPadding:CGFloat = 2
    
    struct GrayCircleButtonView: View {
        let text: String
        let size: CGFloat
        static let grayScale = 0.7
        var body: some View {
            CircleButtonView(text: text,
                             color: Color(grayScale: Self.grayScale),
                             opacity: 1,
                             fontColor: .black,
                             size:size)
        }
    }
    
    struct BlackCircleButtonView: View {
        let text: String
        let size: CGFloat
        static let grayScale = 0.2
        var body: some View {
            CircleButtonView(text: text,
                             color: Color(grayScale: Self.grayScale),
                             opacity: 1,
                             fontColor: .white,
                             size: size)
        }
    }
    
    struct OrangeCircleButtonView: View {
        let text: String
        let size: CGFloat
        var body: some View {
            CircleButtonView(text: text,
                             color: Color(.orange),
                             opacity: 1,
                             fontColor: .white,
                             size: size)
        }
    }
    
    struct CircleButtonView: View {
        let text: String
        let color: Color
        let opacity: Double
        let fontColor: Color
        let size: CGFloat
        var body: some View {
            ZStack {
                Circle()
                    .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(color)
                    .opacity(opacity)
                Text(text)
                    .foregroundColor(fontColor)
                    .font(.system(size: size/2.5))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//
//  ContentView.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    func clearButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapAllClear()
        }, label: {
            GrayCircleButtonView(text: "AC",hSize: hSize, vSize: vSize)
        })
    }
    
    func leftBracketButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "(")
        }, label: {
            GrayCircleButtonView(text: "(",hSize: hSize, vSize: vSize)
        })
    }
    
    func rightBracketButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: ")")
        }, label: {
            GrayCircleButtonView(text: ")",hSize: hSize, vSize: vSize)
        })
    }
    
    func divideButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "/")
        }, label: {
            OrangeCircleButtonView(text: "/",hSize: hSize, vSize: vSize)
        })
    }
    
    func multiplyButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "*")
        }, label: {
            OrangeCircleButtonView(text: "*",hSize: hSize, vSize: vSize)
        })
    }
    
    func minusButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "-")
        }, label: {
            OrangeCircleButtonView(text: "-",hSize: hSize, vSize: vSize)
        })
    }
    
    func plusButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapExpression(sign: "+")
        }, label: {
            OrangeCircleButtonView(text: "+",hSize: hSize, vSize: vSize)
        })
    }
    
    func computeButton(hSize:CGFloat, vSize:CGFloat) -> some View {
        return Button(action: {
            viewModel.tapEqual()
        }, label: {
            OrangeCircleButtonView(text: "=",hSize: hSize, vSize: vSize)
        })
    }
    
    func computeSize(size:CGFloat) -> CGFloat {
        return size/9;
    }
    
    var body: some View {
        ZStack {
            Color(.black)
            GeometryReader { proxy in
                let vSize = proxy.size.height/9
                let hSize = proxy.size.width/4.5
                ZStack {
                    Color(.black)
                    VStack {
                        VStack {
                            HStack {
                                Text(viewModel.currentNumberString)
                                    .foregroundColor(.white)
                                    .font(.system(size:vSize/1.3))
                                Spacer()
                            }
                            Spacer()
                            if let result = viewModel.result {
                                HStack {
                                    Spacer()
                                    Text(result)
                                        .foregroundColor(.white)
                                        .font(.system(size:vSize/1.3))
                                }
                            }
                        }.padding(.horizontal)
                        HStack {
                            VStack {
                                HStack {
                                    Group {
                                        clearButton(hSize:hSize,vSize:vSize)
                                        leftBracketButton(hSize:hSize,vSize:vSize)
                                        rightBracketButton(hSize:hSize,vSize:vSize)
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
                                                BlackCircleButtonView(text: "\(number)",hSize:hSize,vSize:vSize)
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
                                                RoundedRectangle(cornerRadius:vSize/2)
                                                    .frame(width:hSize*2+10+2*Self.buttonPadding,height:vSize,alignment:.center)
                                                    .foregroundColor(Color(grayScale:BlackCircleButtonView.grayScale))
                                                Text("0")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: vSize/1.8))
                                            }
                                        })
                                        Button(action: {
                                            viewModel.tapExpression(sign: ".")
                                        }, label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: vSize/2)
                                                    .frame(width: hSize, height: vSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                    .foregroundColor(Color(grayScale:BlackCircleButtonView.grayScale))
                                                Text(".")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: vSize/1.8))
                                            }
                                        })
                                    }
                                    .padding(Self.buttonPadding)
                                }
                            }
                            VStack {
                                Group {
                                    divideButton(hSize:hSize,vSize:vSize)
                                    multiplyButton(hSize:hSize,vSize:vSize)
                                    minusButton(hSize:hSize,vSize:vSize)
                                    plusButton(hSize:hSize,vSize:vSize)
                                    computeButton(hSize:hSize,vSize:vSize)
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
        let hSize: CGFloat
        let vSize: CGFloat
        static let grayScale = 0.7
        var body: some View {
            RoundedRectButtonView(text: text,
                             color: Color(grayScale: Self.grayScale),
                             opacity: 1,
                             fontColor: .black,
                             hSize:hSize,
                             vSize:vSize)
        }
    }
    
    struct BlackCircleButtonView: View {
        let text: String
        let hSize: CGFloat
        let vSize: CGFloat
        static let grayScale = 0.2
        var body: some View {
            RoundedRectButtonView(text: text,
                             color: Color(grayScale: Self.grayScale),
                             opacity: 1,
                             fontColor: .white,
                             hSize:hSize,
                             vSize:vSize)
        }
    }
    
    struct OrangeCircleButtonView: View {
        let text: String
        let hSize: CGFloat
        let vSize: CGFloat
        var body: some View {
            RoundedRectButtonView(text: text,
                             color: Color(.orange),
                             opacity: 1,
                             fontColor: .white,
                             hSize:hSize,
                             vSize:vSize)
        }
    }
    
    struct RoundedRectButtonView: View {
        let text: String
        let color: Color
        let opacity: Double
        let fontColor: Color
        let hSize: CGFloat
        let vSize: CGFloat
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: vSize/1.8)
                    .frame(width: hSize, height: vSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(color)
                    .opacity(opacity)
                Text(text)
                    .foregroundColor(fontColor)
                    .font(.system(size: vSize/2))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


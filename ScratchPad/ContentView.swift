//
//  ContentView.swift
//  ScratchPad
//
//  Created by Yousof Akbarzai on 4/1/22.
//

import SwiftUI



struct Line {
    var points =  [CGPoint]()
}

struct ContentView: View {
    
    @State var currentline = Line()
    @State var previouslines: [Line] = []
    @State var nextlines: [Line] = []
    
    var body: some View {
        
        
    VStack{
        
        Text("Study App").padding()
        
        Spacer()
        
        Canvas { context, size in
            for line in previouslines {
                var path : Path = Path()
                path.addLines(line.points)
                context.stroke(path,with: .color(Color.black), lineWidth: 1.0)
            }
        }
        .frame(width: 350.0, height: 700.0)
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ value in
                // adding point to the current line
                let newPoint = value.location
                if value.translation.width + value.translation.height == 0 {
                    previouslines.append(Line(points: [newPoint]))
                }else {
                    let index = previouslines.count-1
                    previouslines[index].points.append(newPoint)
                }
            })
                .onEnded({ value in
                    if let last = previouslines.last?.points, last.isEmpty {
                        previouslines.removeLast()
                    }
                }))
        
        Spacer()
        
    
        HStack {
            Button("<") {
                let lastline: Line! = previouslines.removeLast()
                    nextlines.append(lastline)
            }.padding()
                .disabled(previouslines.count == 0)
            
            Button(">") {
                let nextline: Line! = nextlines.removeLast()
                    previouslines.append(nextline)
                
            }.padding()
                .disabled(nextlines.count == 0)
        }
    }
        
        

    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

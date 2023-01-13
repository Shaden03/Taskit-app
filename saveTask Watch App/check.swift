//
//  check.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 12/01/2023.
//

import SwiftUI

struct check: View {
        @State var isChecked: Bool = false
        var clicked: ((Bool) -> Void)
        
        var body: some View {
            
                Button {
                    isChecked.toggle()
                    clicked(isChecked)
                } label: {
                    Image(systemName: isChecked ? "checkmark.square.fill": "square")
//                        .foregroundColor(Color.mint)
                }.buttonStyle(.plain)

               
        }
    

}

struct check_Previews: PreviewProvider {
    static var previews: some View {
        check(){
            isChecked in
            if isChecked {
                
            }
        }
    }
    
}

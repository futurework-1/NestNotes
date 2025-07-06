import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    var placeholder: String = ""
    var minHeight: CGFloat = 80
    var maxHeight: CGFloat = 200
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Фон
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("violet1").opacity(0.9))
                .frame(minHeight: minHeight, maxHeight: maxHeight)
            
            // Placeholder
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.4))
                    .padding()
                
            }
            
            // TextEditor
            TextEditor(text: $text)
                .foregroundColor(.white)
                .padding(.top, 8)
                .padding(.leading, 10)
                .padding(.trailing, 16)
                .frame(minHeight: minHeight, maxHeight: maxHeight)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
            
            // Кнопка очистки
            if !text.isEmpty {
                HStack {
                    Spacer()
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 20))
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CustomTextEditor(text: .constant(""), placeholder: "Some placeholder here...")
        .padding()
}

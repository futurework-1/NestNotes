import SwiftUI

struct SegmentedToggle: View {
    
    enum Segment: String, CaseIterable, Identifiable {
        case inTheNest = "🥚 In the nest"
        case hatched   = "🐣 Hatched"
        
        var id: String { rawValue }
    }
    
    @Binding var selection: Segment
    @Namespace private var animation 
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Segment.allCases) { segment in
                Button {
                    withAnimation(.spring()) {
                        selection = segment
                    }
                } label: {
                    Text(segment.rawValue)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .foregroundColor(selection == segment ? .white : .gray.opacity(0.7))
                }
                .background(
                    ZStack {
                        if selection == segment {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.violet2)
                                .matchedGeometryEffect(id: "highlight", in: animation)
                        }
                    }
                )
            }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.violet1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black.opacity(0.25), lineWidth: 1)
        )
    }
}

struct SegmentedTogglePreview: View {
    @State private var current = SegmentedToggle.Segment.inTheNest

    var body: some View {
        SegmentedToggle(selection: $current)
    }
}

#Preview {
    SegmentedTogglePreview()
        .padding(.horizontal)
}

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            topSectionView()
    
            VStack(spacing: 15) {
                HStack(spacing: 10) {
                    createWeeklyView(isSelected: true)
                    createWeeklyView(isSelected: false)
                    createWeeklyView(isSelected: false)
                    createWeeklyView(isSelected: false)
                    createWeeklyView(isSelected: false)
                    createWeeklyView(isSelected: false)
                    createWeeklyView(isSelected: false)
                }
                
                habitSection()
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical)
    }
}

@ViewBuilder
private func topSectionView() -> some View {
    HStack {
        VStack(alignment: .leading) {
            Text("Welcome Back,")
                .foregroundStyle(.gray)
            Text("Bronwyn.d.santos")
        }
        Spacer()
        Image("account-image")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
    }
}

@ViewBuilder
private func habitSection() -> some View {
    VStack {
        HStack {
            Text("Your Habits")
                .font(.title3)
                .foregroundStyle(.gray)
                .bold()
            Spacer()
        }.padding(.vertical)
        
        habitGrid()
    }
}

@ViewBuilder
private func habitGrid() -> some View {
    Text("Add a habit and view the progress here.")
}

@ViewBuilder
private func createWeeklyView(isSelected: Bool) -> some View {
     VStack {
            Text("1")
            Text("M")
             .font(.caption)
     }
     .padding()
     .background {
        Capsule(style: .continuous)
            .if(!isSelected, transform: { Capsule in
                Capsule.stroke(Color.accentColor, lineWidth: 2)
            })
            .if(isSelected, transform: { Capsule in
                Capsule.foregroundStyle(Color.accentColor)
            })
        }
}

#Preview {
    DashboardView()
}

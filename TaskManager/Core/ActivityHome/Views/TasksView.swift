//
//  TasksView.swift
//  KavSoft
//
//  Created by Obi on 9/20/23.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("DarkPurple")
    @Binding var currentDate: Date
    @Binding var createNewTask: Bool
    /// SwiftData Dynamic Query
    @Query private var tasks: [Activity]
    init(currentDate: Binding<Date>, createNewTask: Binding<Bool>) {
        self._currentDate = currentDate
        self._createNewTask = createNewTask
        /// Predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Activity> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        /// Sorting
        let sortDescriptor = [
            SortDescriptor(\Activity.creationDate, order: .forward)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 35) {
                ForEach(tasks) { task in
                    TaskRowView(task: task)
                        .background(alignment: .leading) {
                            if tasks.last?.id != task.id {
                                Rectangle()
                                    .frame(width: 1)
                                    .offset(x: 8)
                                    .padding(.bottom, -35)
                            }
                        }
                }
            }
            .padding([.vertical, .leading], 15)
            .padding(.top, 15)

            if tasks.isEmpty {
                
//                animate = false
                
                VStack(spacing: 10) {
                    Text("No Task's Found 😭")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.darkPurple))
                        .padding(.bottom, 20)
                   
                    
                    Button(action: {
                        createNewTask.toggle()
                    }, label: {
                        Text("Add Something 🤠")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(animate ? secondaryAccentColor : Color.accentColor)
                            .cornerRadius(10)
                    })
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(
                        color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                }
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)
                .position(x: geometry.size.width / 2, y: geometry.size.height + 200)
                }
            }
        }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
            Animation
                .easeInOut(duration: 2.0)
                .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    RootView()
}

//
//  ContentView.swift
//  WGPA Calculator
//
//  Created by Ravishka Dulshan on 2024-03-04.
//

import SwiftUI

struct Student {
	var id: String
	var gpas: [Double]
	var weightedGPA: Double {
		let weightedGPA = (0.0 * gpas[0]) + (0.2 * gpas[1]) + (0.3 * gpas[2]) + (0.5 * gpas[3])
		return weightedGPA
	}
	
	var classResult: String {
		switch weightedGPA {
		case 3.7...5.0:
			return "First Class"
		case 3.0..<3.7:
			return "Second Upper Class"
		case 2.0..<3.0:
			return "Second Lower Class"
		default:
			return "Pass"
		}
	}
}

struct ContentView: View {
	@State private var students: [Student] = []
	@State private var currentStudentID: String = ""
	@State private var currentGPAs: [String] = Array(repeating: "", count: 4)
	
	var body: some View {
		VStack {
			HStack {
				Text("Student GPA Calculator")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(.black)
					.padding()
				Spacer()
			}
			.background(Color.white)
			.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
			
			VStack {
				TextField("Enter Student ID", text: $currentStudentID)
					.padding()
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.background(Color.white)
					.cornerRadius(8)
				
				ScrollView {
					VStack(alignment: .leading, spacing: 10) {
						Text("Enter GPAs for each year:")
							.foregroundColor(.black)
							.font(.headline)
						
						ForEach(0..<4, id: \.self) { index in
							TextField("Year \(index + 1)", text: $currentGPAs[index])
								.padding()
								.textFieldStyle(RoundedBorderTextFieldStyle())
								.background(Color.white)
								.cornerRadius(8)
						}
						
						Button("Calculate") {
							processStudent()
						}
						.padding()
						.foregroundColor(.white)
						.background(Color.blue)
						.cornerRadius(50)
					}
					.padding()
					.background(Color.white)
					.cornerRadius(12)
					.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
					
					LazyVStack(spacing: 10) {
						ForEach(students, id: \.id) { student in
							VStack(alignment: .leading, spacing: 5) {
								Text("Student ID: \(student.id)")
									.foregroundColor(.black)
									.font(.headline)
								Text("Weighted GPA: \(student.weightedGPA, specifier: "%.2f")")
									.foregroundColor(.black)
								Text("Class: \(student.classResult)")
									.foregroundColor(.black)
							}
							.padding()
							.background(Color.white)
							.cornerRadius(8)
							.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
						}
					}
					.padding()
				}
				.background(Color.gray.opacity(0.1))
				.cornerRadius(16)
				.edgesIgnoringSafeArea(.bottom)
			}
			.padding()
		}
	}



	
	private func processStudent() {
		guard !currentStudentID.isEmpty else {
			return
		}
		
		let gpaValues = currentGPAs.map { Double($0) ?? 0.0 }
		let student = Student(id: currentStudentID, gpas: gpaValues)
		students.append(student)
		
		// Reset input fields
		currentStudentID = ""
		currentGPAs = Array(repeating: "", count: 4)
	}
}



#Preview {
    ContentView()
}

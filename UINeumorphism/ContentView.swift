//
//  ContentView.swift
//  UINeumorphism
//
//  Created by M H on 27/12/2021.
//

import SwiftUI

extension Color {
	static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
	
	static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
	static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
	
	static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
	static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

extension LinearGradient {
	init(_ colors: Color...) {
		self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
	}
}

struct SimpleButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(30)
			.contentShape(Circle())
			.background(
				Group {
					if configuration.isPressed {
						Circle()
							.fill(Color.offWhite)
							.overlay(Circle()
										.stroke(.gray, lineWidth: 4)
										.blur(radius: 4)
										.offset(x: 2, y: 2)
										.mask(Circle()
												.fill(LinearGradient(Color.black, Color.clear))
											 )
							) // overlay
							.overlay(Circle()
										.stroke(.white, lineWidth: 8)
										.blur(radius: 8)
										.offset(x: -2, y: -2)
										.mask(Circle()
												.fill(LinearGradient(Color.clear, Color.black))
											 )
							) // overlay
					} else {
						Circle()
							.fill(Color.offWhite)
							.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
							.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
					}
					
				} // group
			) // bcgr
	}
}


struct DarkBackground <S: Shape> : View {
	var isHifhlighted: Bool
	var shape: S
	
	var body: some View {
		ZStack {
			if isHifhlighted {
				shape
					.fill(LinearGradient(Color.darkEnd, Color.darkStart))
					.overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
					.shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
					.shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
			} else {
				shape
					.fill(LinearGradient(Color.darkStart, Color.darkEnd))
//					.overlay(shape.stroke(LinearGradient(Color.darkEnd, Color.darkStart), lineWidth: 4))
					.shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
					.shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
			}
		} // zstack
	}
}

struct ColorfulBackground <S: Shape> : View {
	var isHifhlighted: Bool
	var shape: S
	
	var body: some View {
		ZStack {
			if isHifhlighted {
				shape
					.fill(LinearGradient(Color.lightEnd, Color.lightStart))
					.overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
					.shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
					.shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
			} else {
				shape
					.fill(LinearGradient(Color.darkStart, Color.darkEnd))
					.overlay(shape.stroke(LinearGradient(Color.lightEnd, Color.lightStart), lineWidth: 4))
					.shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
					.shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
			}
		} // zstack
	}
}

struct DarkButtonStyle : ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(30)
			.contentShape(Circle())
			.background(
				DarkBackground(isHifhlighted: configuration.isPressed, shape: Circle())
			)
	}
}


struct DarkToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		Button {
			configuration.isOn.toggle()
		} label: {
			configuration.label
				.padding(30)
				.contentShape(Circle())
		} // button
		.background(
			DarkBackground(isHifhlighted: configuration.isOn, shape: Circle())
		)

	}
}

struct ColorfulButtonStyle : ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(30)
			.contentShape(Circle())
			.background(
				ColorfulBackground(isHifhlighted: configuration.isPressed, shape: Circle())
			)
	}
}


struct ColorfulToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		Button {
			configuration.isOn.toggle()
		} label: {
			configuration.label
				.padding(30)
				.contentShape(Circle())
		} // button
		.background(
			ColorfulBackground(isHifhlighted: configuration.isOn, shape: Circle())
		)
		
	}
}

struct ContentView: View {
	@State private var isToggled = false
	
	
    var body: some View {
		ZStack {
//			Color.offWhite
			LinearGradient(Color.darkStart, Color.darkEnd)
			
			
			
			
//			RoundedRectangle(cornerRadius: 25)
//				.fill(Color.offWhite)
//				.frame(width: 300, height: 300)
//				.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//				.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
			
			VStack (spacing: 60){
				Button(action: {
					print("pressed")
				}, label: {
					Image(systemName: "heart.fill")
						.foregroundColor(.red)
				}) // button
					.buttonStyle(SimpleButtonStyle())
				
				Button(action: {
					print("pressed")
				}, label: {
					Image(systemName: "heart.fill")
						.foregroundColor(.red)
				}) // button
					.buttonStyle(DarkButtonStyle())
				
				Toggle(isOn: $isToggled, label: {
						Image(systemName: isToggled ? "checkmark" : "xmark")
							.foregroundColor(isToggled ? .green : .red)
				
				}) // toogle
					.toggleStyle(DarkToggleStyle())
				
				
				Button(action: {
					print("pressed")
				}, label: {
					Image(systemName: "checkmark")
						.foregroundColor(.green)
				}) // button
					.buttonStyle(ColorfulButtonStyle())
				
				Toggle(isOn: $isToggled, label: {
					Image(systemName: "xmark")
						.foregroundColor(.red)
				}) // toogle
					.toggleStyle(ColorfulToggleStyle())
			} // vstack
			
		}
		.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

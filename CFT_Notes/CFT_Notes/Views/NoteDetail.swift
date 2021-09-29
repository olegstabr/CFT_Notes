//
//  NoteDetail.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI
struct NoteDetail: View {
	@State var content: String
	@State private var attributedText = NSMutableAttributedString(string: "")
	@State private var font: UIFont? = .systemFont(ofSize: 32)
	@State private var fontColor: UIColor? = .black
	@State private var fontSize: CGFloat = 32
	@EnvironmentObject var noteVM: NoteViewModel

	var note: Note
    var body: some View {
		NavigationView {
			VStack {
				TextView(text: $content, attributedText: $attributedText, font: $font, fontColor: $fontColor)
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.padding(.horizontal)
			}
			.toolbar(content: {
				ToolbarItemGroup(placement: .bottomBar) {
					Button {
						fontSize += 2
						font = .systemFont(ofSize: fontSize)
					} label: {
						Image(systemName: "textformat.size.larger")
							.font(.title)
					}
					Button {
						fontSize -= 2
						font = .systemFont(ofSize: fontSize)
					} label: {
						Image(systemName: "textformat.size.smaller")
							.font(.title)
					}
					Button {
						fontColor = .red
					} label: {
						Image(systemName: "paintbrush")
							.font(.title)
					}
					Spacer()
				}
			})
			.foregroundColor(.primary)
			.navigationTitle(note.title)
		}
		.onTapGesture {
			hideKeyboardAndSave()
		}
    }
	
	private func hideKeyboardAndSave() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
		save()
	}
	
	private func save() {
		noteVM.setContent(note: note, content: content)
		noteVM.save()
	}
}

struct TextView: UIViewRepresentable {
	@Binding var text: String
	@Binding var attributedText: NSMutableAttributedString
	@Binding var font: UIFont?
	@Binding var fontColor: UIColor?
	
	init(text: Binding<String>, attributedText: Binding<NSMutableAttributedString>, font: Binding<UIFont?>, fontColor: Binding<UIColor?>) {
		self._text = text
		self._attributedText = attributedText
		self._font = font
		self._fontColor = fontColor
		self.attributedText.mutableString.setString($text.wrappedValue)
	}

	func makeUIView(context: Context) -> UITextView {
		let view = UITextView()
		view.isScrollEnabled = true
		view.isEditable = true
		view.isUserInteractionEnabled = true
		view.delegate = context.coordinator
		return view
	}

	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.attributedText = attributedText
		uiView.allowsEditingTextAttributes = true
		uiView.font = font
		uiView.textColor = fontColor
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UITextViewDelegate {
		var parent: TextView
		
		init(_ textView: TextView) {
			parent = textView
		}
		
		func textViewDidChange(_ textView: UITextView) {
			parent.text = textView.attributedText.string
		}
	}
}

struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
		NoteDetail(content: "", note: Note(id: 1, title: "TTTTT1", description: "dsadsadsd", content: "content CONNSADFNSANDFA"))
    }
}

//
//  NoteDetail.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI
struct NoteDetail: View {
	@State var content: String
	@State var attributedText = NSMutableAttributedString(string: "")
	@State private var fontWeight: Font.Weight = .light
	@State private var isBold = false
	@EnvironmentObject var noteVM: NoteViewModel

	var note: Note
    var body: some View {
		NavigationView {
			VStack {
				TextView(text: $content, attributedText: $attributedText, allowsEditingTextAttributes: true, font: .systemFont(ofSize: 64))
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.padding(.horizontal)
			}
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
	@State var allowsEditingTextAttributes: Bool = true
	@State var font: UIFont?
	
	init(text: Binding<String>, attributedText: Binding<NSMutableAttributedString>, allowsEditingTextAttributes: Bool, font: UIFont?) {
		self._text = text
		self._attributedText = attributedText
		self.attributedText.mutableString.setString($text.wrappedValue)
		self.allowsEditingTextAttributes = allowsEditingTextAttributes
		self.font = font
	}

	func makeUIView(context: Context) -> UITextView {
		let view = UITextView()
		view.isScrollEnabled = true
		view.isEditable = true
		view.isUserInteractionEnabled = true
		view.font = UIFont.systemFont(ofSize: 32)
		view.delegate = context.coordinator
		return view
	}

	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.attributedText = attributedText
		uiView.allowsEditingTextAttributes = allowsEditingTextAttributes
		uiView.font = font
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

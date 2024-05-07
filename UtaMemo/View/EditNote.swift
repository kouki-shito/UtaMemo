
//
//  EditNote.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI
import UIKit
import SwiftData

struct EditNote: View {

  @Environment(\.modelContext) var context
  @Environment(\.dismiss) private var dismiss
  @State private var CanUndo : Bool = false
  @State private var CanRedo : Bool = false
  @FocusState var isFocussed : Bool
  @Bindable var updateNote : NoteModel
  @State var updateContent :String = ""

  var body: some View {

    VStack(spacing:0){
      titleArea
      noteArea
    }//:VStack
    .padding(.top,70)
    .overlay(
      navigationArea
      ,alignment: .top
    )
    .onAppear(){
      updateContent = updateNote.content
    }
  }//:body

}//:View

extension EditNote {

  private func saveNote(){
    updateNote.content = updateContent
    try? context.save()
  }

  private var navigationArea : some View {
    HStack(alignment:.center){
      //MARK: -BACKANDFOCUS
      HStack{
        Button{
          if isFocussed == false{
            //Back Home
            saveNote()
            dismiss()
          }else{
            //disable Note Focus
            isFocussed = false
          }
        }label: {
          Image(
            systemName:isFocussed == false ? "chevron.backward":"checkmark.circle")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(
            isFocussed == false ? .black : .green)
        }
        .animation(.linear(duration: 0.1),
                   value: isFocussed)
        Spacer(minLength: 0)
      }

      //MARK: -UNDOREDO
      Button {
        //Undo
      }label: {
        Image(systemName: "arrow.backward")
          .font(.title2)
          .opacity(isFocussed == true ? 1 : 0)

      }
      .padding(.leading)
      .frame(width: 40,height: 40)
      .disabled(!isFocussed || !CanUndo)
      .animation(
        .linear(duration: 0.1),
        value:isFocussed)

      Button{
        //Redo
      }label: {
        Image(systemName: "arrow.forward")
          .font(.title2)
          .opacity(
            isFocussed == true ? 1 : 0)
      }
      .frame(width: 40,height: 40,alignment: .center)
      .disabled(!isFocussed || !CanRedo)
      .animation(.linear(duration: 0.1), value:isFocussed)

      //MARK: -MENUBUTTON
      HStack{
        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        Button{
          //menuButton
        }label: {
          Image(systemName: "line.horizontal.3.circle")
            .font(.title)
        }
        .frame(width: 40,height: 40)

      }
    }
    .frame(height: 30)
    .padding(.horizontal)
    .padding(.vertical)
    .background(.white)
  }

  private var titleArea : some View {
    TextField("題名", text: $updateNote.title)
      .font(.title)
      .fontWeight(.heavy)
      .padding()
      .focused($isFocussed)
  }

  private var noteArea : some View {
    EditUiTextView(updateContent: $updateContent, updateNote: updateNote)//get textview Content
  }
}//:Extension

struct EditUiTextView : UIViewRepresentable {

  @Binding var updateContent :String
  @Bindable var updateNote :NoteModel

  func makeUIView(context: Context) -> some UITextView {
    let textView = UITextView()
    textView.text = updateNote.content
    textView.font = UIFont.boldSystemFont(ofSize: 23)
    textView.delegate = context.coordinator

    let toolbar = UIToolbar(frame: CGRect(
      x: .zero,
      y: .zero,
      width: textView.frame.size.width,
      height: 44))

    let attrButton = UIBarButtonItem(
      barButtonSystemItem:.camera,
      target: context.coordinator,
      action: #selector(context.coordinator.addAttribute(sender:)))

    toolbar.setItems([attrButton], animated: true)
    textView.inputAccessoryView = toolbar

    return textView

  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    updateContent = uiView.text
    context.coordinator.textView = uiView
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(updateContent:$updateContent)
  }

  class Coordinator : NSObject,UITextViewDelegate {
    weak var textView:UITextView!
    @Binding var updateContent : String
    var Range : [NSRange] = []

    init(updateContent : Binding<String>){
      _updateContent = updateContent
    }

    func textViewDidChange(_ textView: UITextView) {

      let BgBlackAtr : [NSAttributedString.Key:Any] = [
        .backgroundColor : UIColor.clear,
        .font : UIFont.boldSystemFont(ofSize: 23)]
      textView.typingAttributes = BgBlackAtr
      updateContent = textView.text
    }

    @objc func addAttribute(sender:AnyObject) {

      let Trange = textView.selectedRange

      let mutableAtrString = NSMutableAttributedString(attributedString: textView.attributedText)
      let BgGreenAtr : [NSAttributedString.Key:Any] = [
        .backgroundColor : UIColor.green,
        .font : UIFont.boldSystemFont(ofSize: 23)]
      mutableAtrString.setAttributes(BgGreenAtr,range: Trange)
      textView.attributedText = mutableAtrString
    }//:Atribute
  }
}


#Preview {
  NewNote()
    .modelContainer(for:NoteModel.self)
}


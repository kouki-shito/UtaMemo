//
//  EditNote.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI
import UIKit
import SwiftData

struct NewNote: View {

  @Environment(\.modelContext) var context
  @Environment(\.dismiss) private var dismiss
  @State private var noteContent : String = ""
  @State private var noteTitle : String = ""
  @State private var CanUndo : Bool = false
  @State private var CanRedo : Bool = false
  @State private var range = NSRange()
  @FocusState var isFocussed : Bool

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

  }//:body

}//:View

extension NewNote {

  private func addNote(){
    let newNote = NoteModel(content: noteContent,title: noteTitle)
    context.insert(newNote)
  }
  private func saveNote(){
    try? context.save()
  }

  private var navigationArea : some View {
    HStack(alignment:.center){
      //MARK: -BACKANDFOCUS
      HStack{
        Button{
          if isFocussed == false{
            //Back Home
            if noteContent == "" && noteTitle == ""{

            }else{
              addNote()
            }

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
    TextField("題名", text: $noteTitle)
      .font(.title)
      .fontWeight(.heavy)
      .padding()
      .focused($isFocussed)
      .onChange(of: isFocussed){
        saveNote()
      }
  }

  private var noteArea : some View {

    //TextEditor(text: $noteContent)
    uiTextView(noteContent: $noteContent)
    //      .autocorrectionDisabled(true)
    //      .font(.title2)
    //      .fontWeight(.bold)
    //      .padding(.horizontal,20)
    //      .focused($isFocussed)
    //      .scrollContentBackground(.hidden)
    //      .toolbar{
    //        ToolbarItemGroup(placement:.keyboard){
    //          //KeyBoardToolBar
    //          Button{
    //
    //          }label: {
    //            Image(systemName: "rectangle.inset.fill")
    //              .foregroundColor(.yellow)
    //              .font(.title2)
    //            //.frame(width: 30,height: 30)
    //          }
    //          Spacer()
    //          Button{
    //
    //          }label: {
    //            Image(systemName: "pencil.circle")
    //              .foregroundColor(.blue)
    //              .font(.title2)
    //            //.frame(width: 30,height: 30)
    //          }
    //        }
    //      }
      .onChange(of: isFocussed){
        saveNote()
      }
      .onChange(of:range){
        //print(range)
      }
  }

  //  func getAttributeString(_ str:String)   ->AttributedString{
  //    var attributeString = AttributedString(str)
  //
  //  }



}//:Extension

struct uiTextView : UIViewRepresentable {

  @Binding var noteContent :String
  //@Binding var range: NSRange

  func makeUIView(context: Context) -> some UITextView {
    let textView = UITextView()
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
    uiView.text = noteContent
    context.coordinator.textView = uiView
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(noteContent:$noteContent)
  }
  class Coordinator : NSObject,UITextViewDelegate {
    weak var textView:UITextView?
    var Range : [NSRange] = []

    @Binding var noteContent : String

    init(noteContent : Binding<String>){
      _noteContent = noteContent
    }

    func textViewDidChange(_ textView: UITextView) {
    }
    //
    //    func textViewDidChangeSelection(_ textView: UITextView) {
    //
    //    }

    @objc func addAttribute(sender:AnyObject) {

      let range = textView!.selectedRange
      let Location = range.location
      let Length = range.length
      let attrText = NSMutableAttributedString(string: textView!.text)

      if Length != 0 {
        if Range.count != 0 {
          //MARK: -Double Check
          if Range.filter({$0 == range}) == [] {
            //no Double
            Range.append(range)
          }else{
            Range.removeAll(where: {$0 == range})
            print("DeleteBackground")
          }
          //MARK: -Other Check
          Range.removeAll(where: {$0.location == Location && $0.length < Length})

          for (index,_) in Range.enumerated(){
            let EndPoint = Range[index].location + Range[index].length

            if textView!.text.count - EndPoint < 0 {
              //outRanged
              let LostCount = EndPoint - textView!.text.count
              print(LostCount)

              if LostCount < Length + 1 {
                //Replace Length
                Range[index] = NSMakeRange(Range[index].location, Length-LostCount)
                print("Replaced")
              }else if LostCount >= Length + 1{
                //Delete range
                Range.remove(at: index)
                print("deleteOutOfRange")
              }

            }//:if
          }//:For

        }else{
          Range.append(range)
        }
        print(Range)
        Range.forEach(){
          attrText.addAttribute(.backgroundColor, value: UIColor.red, range: NSRange(location: $0.location, length:$0.length))
        }
        textView!.attributedText = attrText
      }
    }//:Atribute


  }
}



#Preview {
  NewNote()
    .modelContainer(for:NoteModel.self)
}


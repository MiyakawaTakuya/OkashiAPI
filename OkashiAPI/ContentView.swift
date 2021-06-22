//
//  ContentView.swift
//  OkashiAPI
//
//  Created by 宮川卓也 on 2021/06/22.
//

import SwiftUI

struct ContentView: View {
    //OkashiDataを参照する状態変数
    //@ObservedObjectは@Stateと同じような役割ですが、複数のデータを外部ファイルと共有する場合に利用するという違いがある
    //データ取得用のOkashiDataクラスとお菓子検索画面でデータを共有したいので今回これを使う
    //@ObservedObjectはこれが「更新情報を受け取るオブジェクト」であることを示している
    @ObservedObject var okashiDataList = OkashiData()
    //入力された文字列を保持する状態変数
    @State var inputText = ""
    
    var body: some View {
        VStack {
            //文字を受け取るTextFieldを表示する
            //一つ目の引数はプレースホルダー(入力欄に表示するメッセージ)
            //二つ目の引数のtextは@Stateで宣言した状態変数に$を接頭辞として指定することで状態変数の値を参照渡しすることができる
            //三つ目の引数は、入力が確定したタイミングで実行する処理をクロージャ{}でかく。
            TextField("キーワードを入力してください",text: $inputText, onCommit: {
                //入力完了後に検索をする
                okashiDataList.searchOkashi(keyword: inputText)
            }) //検索バーここまで
            .padding()  //上下左右に余白を開ける
            
            //お菓子の検索結果を表示
            List(okashiDataList.okashiList){okashi in
                //okashiに要素を取り出してListを生成
                HStack{
                    Image(uiImage:okashi.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                    Text(okashi.name)
                }
            }//お菓子リストここまで
        }//VStackここまで

    }
}
//ATSの設定を変更すること
//iOSアプリとインターネットを安全に接続するための設定で
//これが初期設定では有効になっているので無効に変更する

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

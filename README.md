THLoadXibView
=============

XIBからViewインスタンスを生成出来るようにするライブラリ

##メリット
・カスタムViewインスタンスをコードから生成できるし、XIBの中に埋め込むことも出来る。  
・親XIBからカスタムViewの最も上の階層のViewのframeやbackgroundColor等の設定が出来る。  

##インストール
　Podfileに以下を追加し、pod install。  
　pod 'THLoadXibView', :git => 'https://github.com/hosokawa0825/THLoadXibView.git'
　
##使い方
　サンプルコード（プロジェクト内のExampleCustomView）を参照してください。

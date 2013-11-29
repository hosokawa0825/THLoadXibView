Pod::Spec.new do |s|
    s.name              = 'THLoadXibView'
    s.version           = '1.0.0'
    s.summary           = 'XIBからViewインスタンスを生成出来るようにするライブラリ'
    s.homepage          = 'https://github.com/hosokawa0825/THLoadXibView'
    s.license           = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author            = {
        'hosokawa0825' => 'globe_sessions@hotmail.com'
    }
    s.source            = {
        :git => 'https://github.com/hosokawa0825/THLoadXibView.git',
        :tag => s.version.to_s
    }
    s.source_files      = 'THLoadXibView/Lib/*.{m,h}'
    s.requires_arc      = true
end
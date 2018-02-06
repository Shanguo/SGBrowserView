Pod::Spec.new do |s|
s.name = 'SGBrowserView'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'Browser a view whitch you designed quickly.'
s.homepage = 'https://github.com/shanguo/SGBrowserView'
s.authors = { '刘山国' => '857363312@qq.com' }
s.source = { :git => 'https://github.com/shanguo/SGBrowserView.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'SGBrowserView/SGBrowserView/*.{h,m}'
end

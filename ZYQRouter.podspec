Pod::Spec.new do |s|
s.name                  = 'ZYQRouter'
s.version               = '1.3.3'
s.summary               = 'A new method router and page router  '
s.homepage              = 'https://github.com/heroims/ZYQRouter'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/ZYQRouter.git', :tag => "#{s.version}" }
s.platform              = :ios, '5.0'
s.source_files          = 'ZYQRouter/*.{h,m}'
s.requires_arc          = true
end


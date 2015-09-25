Pod::Spec.new do |s|
  s.name		= 'CubeFlip'
  s.version          	= '0.0.1'
  s.license 		= { :type => "MIT", :file => "LICENSE" }
  s.platform      	= :ios, '8.0'
  s.summary 		= 'Simple flip cube, box in swift'

  s.homepage 		= 'https://github.com/Armanoide/CubeFlip'
  s.author 		= { 'Billa Norbert' => 'norbert.billa@gmail.com' }
  s.source 		= { :git => 'https://github.com/Armanoide/CubeFlip.git', :tag => '0.0.1' }
  s.source_files 	= 'SRC/*.{swift}'
  s.requires_arc 	= true
  s.frameworks 		= 'Foundation'
end

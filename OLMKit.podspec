Pod::Spec.new do |s|

  # The libolm version
  MAJOR = 1
  MINOR = 3
  PATCH = 0

  s.name         = "OLMKit"
  s.version      = "#{MAJOR}.#{MINOR}.#{PATCH}"
  s.summary      = "An Objective-C wrapper of olm (http://matrix.org/git/olm)"

  s.description  = <<-DESC
				   olm is an implementation of the Double Ratchet cryptographic ratchet in C++
                   DESC

  s.homepage     = "http://matrix.org/git/olm"

  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }

  s.authors            = { "Chris Ballinger" => "chrisballinger@gmail.com", 
                           "matrix.org" => "support@matrix.org" }

  s.platform     = :ios, "5.0"

  # Expose the Objective-C wrapper API of libolm
  s.public_header_files = "xcode/OLMKit/*.h"

  s.source       = { 
    :git => "https://matrix.org/git/olm.git", 
    :tag => s.version.to_s 
  }
    
  s.source_files = "xcode/OLMKit/*.{h,m}", "include/**/*.{h,hh}", "src/*.{c,cpp}", "lib/ed25519/**/*.{h,c}", "lib/crypto-algorithms/sha256.c",  "lib/crypto-algorithms/aes.c", "lib/curve25519-donna/curve25519-donna.c"
  
  s.library = "c++"
  
  
  # Use the same compiler options for C and C++ as olm/Makefile
  
  s.compiler_flags = "-g -O3 -DOLMLIB_VERSION_MAJOR=#{MAJOR} -DOLMLIB_VERSION_MINOR=#{MINOR} -DOLMLIB_VERSION_PATCH=#{PATCH}"
  s.xcconfig = { 
    'USER_HEADER_SEARCH_PATHS' =>"#{File.join(File.dirname(__FILE__), 'include')} #{File.join(File.dirname(__FILE__), 'lib')}"
  }
  
  s.subspec 'olmc' do |olmc|
    olmc.source_files   = "src/*.{c}", "lib/ed25519/**/*.{h,c}", "lib/crypto-algorithms/sha256.c", "lib/crypto-algorithms/aes.c",  "lib/curve25519-donna/curve25519-donna.c"
    olmc.compiler_flags = ' -std=c99 -fPIC'
  end
  
  s.subspec 'olmcpp' do |olmcpp|
    olmcpp.source_files   = "src/*.{cpp}"
    olmcpp.compiler_flags = ' -std=c++11 -fPIC'
  end
  
end

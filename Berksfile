source "https://supermarket.chef.io"

Dir.glob(File.join(File.dirname(__FILE__), 'cookbooks', '*')).each { |p| cookbook File.basename(p).to_s, path: p }

cookbook 'docker', '~> 2.9.2'
require "erb"

class Base
  
  class Env
    
    def initialize
      @headers = { "Content-type" => "text/html" }
      @status = 200
    end
    
    def render
      file =  @env["PATH_INFO"]
      file = "/index" if file == "/"
      file += ".erb"
      @template = ERB.new(File.read(File.expand_path(File.join("..", "views", file), __FILE__)))
      @template.result(binding)
    end
    
    def call(env)
      @env = env
      path = @env["PATH_INFO"]
      path.sub!(/\/$/, "")
      path = "/" if path == ""
      meth = "#{@env["REQUEST_METHOD"]}_#{path}".to_sym
      output = send(meth)
      [@status, @headers, [output]]
    end
      
  end
  
  class << self
    
    def request(method, path, &block)
      meth = "#{method.to_s.upcase}_#{path}".to_sym
      Env.send(:define_method, meth, &block)
    end
    
    def get(path, &block)
      request(:get, path, &block)
    end
    
    def post(path, &block)
      request(:post, path, &block)
    end  
    
  end
  
  def self.call(env)
    Env.new.call(env)
  end
      
end
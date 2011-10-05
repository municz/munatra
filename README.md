## Task: errors

Implement error handling. The framework capable of defining response for at least 404 file not found.

```ruby
class App < Base

  get "/" do
    "Hello world"
  end

  error 404 do
    "Sorry, file not found!"
  end

end
```

After that all request to the application except root ("/") should respond with message defined for 404 error.

**1 bonus point**

Add tests that will cover added functionality.

**1 bonus point**
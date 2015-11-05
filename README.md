# Rails Lite

This is a reconstruction of the basic functionality of Rails, in six phases, developed as a test-driven project.

### Phase 1: Server

Set up a simple server using the WEBrick module, along with rudimentary request/response functionality.

### Phase 2: Basic Controllers

Lay the foundation of ControllerBase, which provides the functionality that ActionController::Base does in Rails: 
the `render` and `redirect_to` controller methods.

### Phase 3: Template Rendering

Use `Kernel#binding` to evaluate ERB code and update the `render` method to handle HTML content.

### Phase 4: Session Management

Store session information using `WEBrick::Cookie` objects and a `Session` class. 
Update controllers to store session information.

### Phase 5: Query Params and Request-Body Params

Parse query string and post body to extract params at any level of nesting using Regex. 
Set up a `Params` object to store the params as a controller instance variable.

### Phase 6: Routing and Route Params

Set up a `Route` object that stores a URL pattern, an HTTP method, a controller class, and an action name.
Extract the route params from the URL using Regex.  
Set up a `Router` object to match a requested URL with a `Route` object given a HTTP request.  
Modify controllers to invoke the appropriate action when the `Router` is run.

### Future Additions
* `flash` and `flash.now`
* CSRF protection

module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern, @http_method = pattern, http_method
      @controller, @action = controller_class, action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
      @http_method == req.request_method.downcase.to_sym
                      && @pattern.match(req.path)
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
      match = @pattern.match(req.path)
      @route_params = {}
      match.names.each_with_index do |name, idx|
        @route_params[name] = match.captures[idx]
      end
      new_controller = @controller.new(req, res, @route_params)
      new_controller.invoke_action(@action)
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    # simply adds a new route to the list of routes
    def add_route(pattern, http_method, controller_class, action_name)
      @routes << Route.new(pattern, http_method, controller_class, action_name)
    end

    # evaluate the proc in the context of the instance
    # for syntactic sugar :)
    def draw(&prc)
      self.instance_eval(&prc)
    end

    # make each of these methods that
    # when called add route
    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method.to_s) do |pattern,
                                          controller_class,
                                          action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
    end

    # should return the route that matches this request
    def match(req)
      @routes.find { |route| route.matches?(req) }
    end

    # either throw 404 or call run on a matched route
    def run(req, res)
      p routes
      route = match(req)
      if route
        route.run(req, res)
      else
        res.status = 404
        res.body = "could not find #{req.path} with action #{req.request_method}"
      end
    end
  end
end

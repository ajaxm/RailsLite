require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @req = req
      query_params = parse_www_encoded_form(@req.query_string) || {}
      post_params = parse_www_encoded_form(@req.body) || {}

      @params = query_params.merge(post_params).merge(route_params)
    end

    def [](key)
      @params[key.to_s] || @params[key.to_sym]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    # class AttributeNotFoundError < ArgumentError; end;

    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return nil unless www_encoded_form

      params = {}
      form_pairs = URI::decode_www_form(www_encoded_form)
      form_pairs.each do |pair|
        deepest_value = pair.last
        keys = parse_key(pair.first)
        current = params
        keys[0...-1].each do |key|
          current[key] ||= {}
          current = current[key]
        end
        current[keys.last] = deepest_value
      end
      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end

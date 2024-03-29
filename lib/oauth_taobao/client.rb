require 'oauth2'

module OauthTaobao

  # The OauthTaobao::Client class
  class Client < OAuth2::Client

    attr_reader :redirect_uri
    attr_accessor :token

    # Initializes a new Client from a signed_request
    #
    # @param [String] code The Authorization Code value
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder
    def self.from_code(code, opts={}, &block)
      client = self.new(opts, &block)
      client.auth_code.get_token(code)

      client
    end

    # Initializes a new Client from a signed_request
    #
    # @param [String] signed_request param posted by Sina
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder
    def self.from_signed_request(signed_request, opts={}, &block)
      client = self.new(opts, &block)
      client.signed_request.get_token(signed_request)

      client
    end

    # Initializes a new Client from a hash
    #
    # @param [Hash] a Hash contains access_token and expires
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder
    def self.from_hash(hash, opts={}, &block)
      client = self.new(opts, &block)
      client.get_token_from_hash(hash)

      client
    end

    # Initializes a new Client
    #
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder
    def initialize(opts={}, &block)
      id = OauthTaobao::Config.api_key
      secret = OauthTaobao::Config.api_secret
      @redirect_uri = OauthTaobao::Config.redirect_uri
      @tbsandbox = (["true", true, 'yes','1',1].include? OauthTaobao::Config.tbsandbox) ? true : false
      @site = @tbsandbox ? 'https://oauth.tbsandbox.com/' : 'https://oauth.taobao.com' rescue 'https://oauth.taobao.com'

      options = {:site          => @site,
                 :authorize_url => "/authorize",
                 :token_url     => "/token",
                 :raise_errors  => false,
                 :ssl           => {:verify => false}}.merge(opts)

      super(id, secret, options, &block)
    end

    # Whether or not the client is authorized
    #
    # @return [Boolean]
    def is_authorized?
      !!token && !token.expired?
    end

    # Initializes an AccessToken by making a request to the token endpoint
    #
    # @param [Hash] params a Hash of params for the token endpoint
    # @param [Hash] access token options, to pass to the AccessToken object
    # @return [AccessToken] the initalized AccessToken
    def get_token(params, access_token_opts={})

      unless params.class == Hash
        params = Hash[params.split("&").collect{|pair| pair.split("=")}]
      end
      params = params.merge(:parse => :json)

      access_token_opts = access_token_opts.merge({:header_format => "OAuth2 %s", :param_name => "access_token"})

      #@token = super(params, access_token_opts)
      opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
      if options[:token_method] == :post
        headers = params.delete(:headers)
        opts[:body] = params
        opts[:headers] =  {'Content-Type' => 'application/x-www-form-urlencoded'}
        opts[:headers].merge!(headers) if headers
      else
        opts[:params] = params
      end
      response = request(options[:token_method], token_url, opts)
      raise Error.new(response) if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])

      # on taobao the response.parsed, I get is hash
      #parsed = Hash[response.parsed.split("&").collect{|pair| pair.split("=")}]
      parsed = response.parsed
      @token = OAuth2::AccessToken.from_hash(self, parsed.merge(access_token_opts))
    end

    # Initializes an AccessToken from a hash
    #
    # @param [Hash] hash a Hash contains access_token and expires
    # @return [AccessToken] the initalized AccessToken
    def get_token_from_hash(hash)
      access_token = hash.delete('access_token') || hash.delete(:access_token) || hash.delete('oauth_token') || hash.delete(:oauth_token)
      opts = {:expires_at => hash["expires"] || hash[:expires],
              :header_format => "OAuth2 %s",
              :param_name => "access_token"}

      @token = OAuth2::AccessToken.new(self, access_token, opts)
    end

    # Refreshes the current Access Token
    #
    # @return [AccessToken] a new AccessToken
    # @note options should be carried over to the new AccessToken
    def refresh!(params={})
      @token = token.refresh!(params)
    end

    #
    # Strategies
    #

    # The Authorization Code strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.1
    def auth_code
      @auth_code ||= OauthTaobao::Strategy::AuthCode.new(self)
    end

    # The Resource Owner Password Credentials strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.3
    def password
      super
    end

    # The Signed Request Strategy
    #
    # @see http://open.weibo.com/wiki/%E7%AB%99%E5%86%85%E5%BA%94%E7%94%A8%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97
    def signed_request
      @signed_request ||= OauthTaobao::Strategy::SignedRequest.new(self)
    end

    #
    # APIs
    #

    def request_params
      access_token = self.token.token
      #request_params = {"oauth_consumer_key" => self.id, "access_token" => access_token, "openid" => params["openid"], "oauth_version" => "2.a", "scope" => "all"}
      request_params = {"oauth_consumer_key" => self.id, "access_token" => access_token, "oauth_version" => "2.a"}
    end

    def account
      @account ||= OauthTaobao::Interface::Account.new(self)
    end
=begin
    def comments
      @comments ||= OauthTaobao::Interface::Comments.new(self)
    end

    def favorites
      @favorites ||= OauthTaobao::Interface::Favorites.new(self)
    end

    def friendships
      @friendships ||= OauthTaobao::Interface::Friendships.new(self)
    end

    def register
      @register ||= OauthTaobao::Interface::Register.new(self)
    end

    def search
      @search ||= OauthTaobao::Interface::Search.new(self)
    end

    def t
      @t ||= OauthTaobao::Interface::T.new(self)
    end

    def suggestions
      @suggestions ||= OauthTaobao::Interface::Suggestions.new(self)
    end

    def tags
      @tags ||= OauthTaobao::Interface::Tags.new(self)
    end

    def trends
      @trends ||= OauthTaobao::Interface::Trends.new(self)
    end
=end
    def users
      @users ||= OauthTaobao::Interface::Users.new(self)
    end
  end
end

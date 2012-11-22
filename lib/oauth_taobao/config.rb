module OauthTaobao
  module Config

    def self.api_key=(val)
      @@api_key = val
    end

    def self.api_key
      @@api_key
    end

    def self.api_secret=(val)
      @@api_secret = val
    end

    def self.api_secret
      @@api_secret
    end

    def self.redirect_uri=(val)
      @@redirect_uri = val
    end

    def self.redirect_uri
      @@redirect_uri
    end
    
    def self.tbsandbox=(val)
      @@tbsandbox = val
    end
    
    def self.tbsandbox
      @@tbsandbox
    end
  end
end

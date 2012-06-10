class Fluent::ImKayacOutput < Fluent::Output
  Fluent::Plugin.register_output('imkayac', self)

  def initialize
    super
    require 'net/http'
    require 'digest/sha1'
    require 'json'
  end

  config_param :username,   :string
  config_param :handler,    :string, :default => nil
  config_param :password,   :string, :default => nil
  config_param :secret_key, :string, :default => nil
  config_param :api_url,    :string, :default => "http://im.kayac.com/api/post/"

  def configure(conf)
    super

    if @username.nil?
      raise Fluent::ConfigError, "missing username"
    end

  end

  def start
    super
  end

  def shutdown
    super
  end

  def post(tag, time, record)
    url = URI.parse( @api_url + @username )
    params = {
      "message" => "#{tag} at #{Time.at(time).localtime}\n#{record.to_json}",
    }
    params["handler"]  = @handler  if @handler
    params["password"] = @password if @password
    params["sig"]      = Digest::SHA1.hexdigest(params["message"] + @secret_key) if @secret_key

    begin
      res = Net::HTTP.post_form(url, params)
    rescue IOError, EOFError, SystemCallError
      # server didn't respond
      $log.warn "out_imkayac: Net::HTTP.post_form raises exception: #{$!.class}, '#{$!.message}'"
      res = nil
    end
    unless res and res.is_a?(Net::HTTPSuccess)
      $log.warn "out_imkayac: failed to post to im.kayac.com, code: #{res && res.code}"
      return
    end
    begin
      result = JSON.load(res.body)
    rescue
      $log.warn "out_imkayac: response body is not valid JSON format: #{$!.class}, '#{$!.message}' #{res.body}"
      result = nil
    end
    if result and result["error"] != ""
      $log.warn "out_imkayac: error from im.kayac.com: #{result['error']}"
    end
  end

  def emit(tag, es, chain)
    es.each do |time,record|
      post(tag, time, record)
    end
    chain.next
  end

end

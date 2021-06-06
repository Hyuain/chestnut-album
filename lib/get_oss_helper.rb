require 'base64'
require 'openssl'
require 'digest'

HEADER_PREFIX = "x-oss-"

class GetOssHelper
  def initialize(_options = {})
    @expires = Time.now.to_i + 3600
  end

  def get_temp_url(filename)
    "#{filename}" +
      "?OSSAccessKeyId=#{ENV['OSS_ACCESS_KEY_ID']}" +
      "&Expires=#{@expires}" +
      "&Signature=#{CGI.escape(signature(get_string_to_signature(filename)))}"
  end

  private

  def signature(policy)
    Base64.strict_encode64 OpenSSL::HMAC.digest('sha1', ENV['OSS_ACCESS_KEY_SECRETE'], policy)
  end

  def get_string_to_signature(filename)
    content_md5 = ""
    content_type = ""
    cano_res = "/#{ENV['OSS_BUCKET']}/#{filename}"
    # sub_res = (resources[:sub_res] || {})
    #             .sort.map { |k, v| v ? [k, v].join("=") : k }.join("&")
    # cano_res += "?#{sub_res}" unless sub_res.empty?
    "GET\n#{content_md5}\n#{content_type}\n#{@expires}\n" +
        "#{cano_res}"
  end

end
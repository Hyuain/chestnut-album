require 'base64'
require 'openssl'
require 'digest'

class UploadOssHelper
  def initialize(options = {})
    @time_out = options[:time_out]
    @time_out ||= 1
    @max_size = options[:max_size]
    @max_size ||= 15
    @file_name = options[:file_name]
  end

  def create_upload_params
    policy = get_policy_base64
    {
      OSSAccessKeyId: ENV['OSS_ACCESS_KEY_ID'],
      policy: policy,
      signature: signature(policy),
      key: generate_file_key,
    }
  end

  private

  def get_policy_base64
    time = Time.now + @time_out.hour
    policy_text = {
      expiration: time.utc.iso8601,
      conditions: [
        ["content-length-range", 0, @max_size * 1024 * 1024],
      ],
    }
    Base64.encode64 policy_text.to_json
  end

  def signature(policy)
    Base64.strict_encode64 OpenSSL::HMAC.digest('sha1', ENV['OSS_ACCESS_KEY_SECRETE'], policy)
  end

  def generate_file_key
    "test/#{@file_name}"
  end

end
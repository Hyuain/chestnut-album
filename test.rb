def get_signature(key, verb, headers, resources)

  content_md5 = headers['content-md5'] || ""
  content_type = headers['content-type'] || ""
  date = headers['date']

  cano_headers = headers.select { |k, v| k.start_with?(HEADER_PREFIX) }
                        .map { |k, v| [k.downcase.strip, v.strip] }
                        .sort.map { |k, v| [k, v].join(":") + "\n" }.join

  cano_res = resources[:path] || "/"
  sub_res = (resources[:sub_res] || {})
              .sort.map { |k, v| v ? [k, v].join("=") : k }.join("&")
  cano_res += "?#{sub_res}" unless sub_res.empty?

  string_to_sign =
    "#{verb}\n#{content_md5}\n#{content_type}\n#{date}\n" +
      "#{cano_headers}#{cano_res}"
end
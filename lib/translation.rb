require 'base64'
require 'json'
require 'net/https'

module Translation
  class << self
    def translate_word(word_arr)
      # APIのURL作成
      api_url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['GOOGLE_API_KEY']}"

      # APIリクエスト用のJSONパラメータ
       params = { q: word_arr, target: 'ja' }.to_json # ""を付けてくれている役割


      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      response_body["data"]["translations"].pluck("translatedText")#byebugでresponse_bodyの中身を確認したものを記述
      # APIレスポンス出力
    end
  end
end
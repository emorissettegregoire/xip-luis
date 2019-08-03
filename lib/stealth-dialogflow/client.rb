module Stealth
  class Dialogflow

    LANGUAGE_CODE = ENV['DIALOGFLOW_LANGUAGE_CODE'] || 'en-US'

    def self.detect_intent(text:, session_id:, params: {})
      params = {
        queryInput: {
          text: {
            text: text,
            languageCode: LANGUAGE_CODE,
            queryParams: params
          }
        }
      }

      res = http_client.post(
        endpoint(session_id: session_id),
        body: MultiJson.dump(params)
      )
    end

    private

      def self.endpoint(session_id:)
        path_fragment1 = "/v2/projects/#{ENV['DIALOGFLOW_PROJECT_ID']}/agent"
        path_fragment2 = "/sessions/#{session_id}:detectIntent"

        uri = URI::HTTPS.build(
          host: 'dialogflow.googleapis.com',
          path: [path_fragment1, path_fragment2].join
        )

        uri.to_s
      end

      def self.http_client
        headers = {
          'Content-Type' => 'application/json'
          'Authorization' => "Bearer #{ENV['DIALOGFLOW_SECRET']}",
          'charset' => "utf-8"
        }
        HTTP.timeout(connect: 15, read: 30).headers(headers)
      end

      def self.generate_body()
        #code
      end

  end
end

module Services
  module PTP
    class Release
      include Virtus.model

      attribute :id, Integer
      attribute :checked, Boolean
      attribute :codec, String
      attribute :container, String
      attribute :golden_popcorn, Boolean
      attribute :leechers, Integer
      attribute :seeders, Integer
      attribute :quality, String
      attribute :release_name, String
      attribute :resolution, String
      attribute :scene, Boolean
      attribute :size, Integer
      attribute :snatched, Integer
      attribute :source, String
      attribute :upload_time, DateTime

      attribute :width, Integer
      attribute :height, Integer

      def initialize(data)
        super(data.each_with_object({}) do |(key, value), new_hash|
          converted_value = value.is_a?(String) ? value.downcase : value
          new_hash[key.to_s.underscore] = converted_value
        end)
      end
    end
  end
end
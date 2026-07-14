
class PexelsService
  include HTTParty

  def initialize
    # Récupération de la clé API
    @api_key = Rails.application.credentials.dig(:pexels, :api_key)
    # On s'assure que la clé est présente et nettoyée d'éventuels espaces invisibles
    @headers = { "Authorization" => @api_key.to_s.strip }
  end

  def fetch_collection(collection_id)
    return [] if collection_id.blank?

    # Nettoyage de l'ID de la collection (supprime les espaces accidentels)
    clean_id = collection_id.to_s.strip
    url = "https://api.pexels.com/v1/collections/#{clean_id}"

    response = self.class.get(url, headers: @headers)

    if response.success?
      # L'API Pexels renvoie les éléments sous la clé "media"
      response.parsed_response["media"] || []
    else
      # Permet de voir l'erreur exacte dans vos logs de terminal Rails
      puts "----------------------------------------"
      puts "Erreur de requête Pexels !"
      puts "URL appelée : #{url}"
      puts "Code de retour : #{response.code}"
      puts "Message de l'API : #{response.body}"
      puts "----------------------------------------"
      []
    end
  end
end

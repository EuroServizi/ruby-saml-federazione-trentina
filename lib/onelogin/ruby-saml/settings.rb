module Onelogin
  module Saml
    class Settings
     
      attr_accessor :assertion_consumer_service_url, :issuer, :sp_name_qualifier, :sp_cert
      attr_accessor :idp_sso_target_url, :idp_cert_fingerprint, :idp_cert, :name_identifier_format, :idp_metadata, :idp_metadata_ttl, :idp_name_qualifier
      attr_accessor :authn_context, :requester_identificator
      attr_accessor :assertion_consumer_service_binding, :idp_slo_target_url
      attr_accessor :name_identifier_value
      attr_accessor :sessionindex
      attr_accessor :single_logout_service_url, :single_logout_service_binding, :single_logout_destination, :destination_service_url
      attr_accessor :skip_validation
    
      def initialize(config = {})
        config.each do |k,v|
          acc = "#{k.to_s}=".to_sym
          self.send(acc, v) if self.respond_to? acc
        end

        # Set some sane default values on a few options
        self.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
        self.single_logout_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
        # Default cache TTL for metadata is 1 day
        self.idp_metadata_ttl = 86400
      end

    end
  end
end

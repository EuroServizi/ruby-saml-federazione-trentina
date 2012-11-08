require "rexml/document"
require "rexml/xpath"
require "uri"

# Class to return SP metadata based on the settings requested.
# Return this XML in a controller, then give that URL to the the 
# IdP administrator.  The IdP will poll the URL and your settings
# will be updated automatically
module Onelogin
  module Saml
    include REXML
    class Metadata
      def generate(settings)
        meta_doc = REXML::Document.new
        root = meta_doc.add_element "md:EntityDescriptor", { 
            "xmlns:md" => "urn:oasis:names:tc:SAML:2.0:metadata",
            "xmlns:xml" => "http://www.w3.org/XML/1998/namespace" 
        }
        if settings.issuer != nil
          root.attributes["entityID"] = settings.issuer
        end
        sp_sso = root.add_element "md:SPSSODescriptor", { 
            "protocolSupportEnumeration" => "urn:oasis:names:tc:SAML:2.0:protocol"
        }
        
          if settings.name_identifier_format != nil
            name_id = sp_sso.add_element "md:NameIDFormat"
            name_id.text = settings.name_identifier_format
          end
          if settings.sp_cert != nil
            keyDescriptor = sp_sso.add_element "md:KeyDescriptor", {
              "use" => "signing"
            }
            keyInfo = keyDescriptor.add_element "ds:KeyInfo", {
              "xmlns:ds" => "http://www.w3.org/2000/09/xmldsig#"
            }
            x509Data = keyInfo.add_element "ds:X509Data"
            x509Certificate = x509Data.add_element "ds:X509Certificate"
            file = ""
            File.foreach(settings.sp_cert){ |line|
                                         file  += line unless line.include?("RSA PUBLIC KEY")
                                       }
            x509Certificate.text = file                            
          end
          if settings.assertion_consumer_service_url != nil
            sp_sso.add_element "md:AssertionConsumerService", {
                # Add this as a setting to create different bindings?
                "Binding" => "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST",
                "Location" => settings.assertion_consumer_service_url,
                "index" => "1"
            }
          end
          if settings.sp_logout_service != nil
            sp_sso.add_element "md:SingleLogoutService", {
                "Binding" => "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect",
                "Location" => settings.sp_logout_service
            }
          end
        meta_doc << REXML::XMLDecl.new
        ret = ""
        # pretty print the XML so IdP administrators can easily see what the SP supports
        meta_doc.write(ret, 1)

        Logging.debug "Generated metadata:\n#{ret}"

        return ret

      end
    end
  end
end

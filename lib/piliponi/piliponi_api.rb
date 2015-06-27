require 'yaml'

module Core

  PREFIXES = YAML.load_file(File.join(File.dirname(__FILE__),"config/telco.yml"))

  class PiliponiApi
    def lookup(prefix)
      network = PREFIXES.find { |k,v| v.include? prefix }

      network ? network[0] : "unknown"
    end

  end
end

require 'openssl'
require 'base64'

class SignerVerifier
  attr_accessor :user_provided_file, :user_provided_signatue

  def initialize(user_provided_file, user_provided_signatue = nil)
    @user_provided_file = user_provided_file
    @user_provided_signatue = user_provided_signatue
  end

  def sign
    write_to_file(signature, signature_output_file_path)
    puts "#{user_provided_file} was signed using private key, signature saved as #{signature_output_file_path}"
  end

  def verify
    puts verification
  end

  private 

  def signature
    Base64.encode64(rsa_key(private_key).sign(OpenSSL::Digest::SHA1.new, file_contents(user_provided_file)))
  end

  # Returns boolean
  def verification
    rsa_key(public_key).verify(
      OpenSSL::Digest::SHA1.new, 
      Base64.decode64(file_contents(user_provided_signatue)), 
      file_contents(user_provided_file)
    )
  end
  
  def write_to_file(string, path)
    file = File.new(path, mode: "w")
    file.write(string)
    file.close
  end

  def signature_output_file_path
    "#{user_provided_file.chomp('.txt')}_signature.txt"
  end

  def file_contents(path)
    file = File.open(path)
    results = file.read
    file.close
    results
  end
  
  def public_key
    File.read("lib/public.key")
  end 

  def private_key
    File.read("lib/private.key")
  end

  def rsa_key(key)
    OpenSSL::PKey::RSA.new(key)
  end
end

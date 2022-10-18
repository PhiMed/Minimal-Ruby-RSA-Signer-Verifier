require 'encrypto_signo'

class SignerVerifier
  attr_accessor :user_provided_file, :user_provided_signatue

  def initialize(user_provided_file, user_provided_signatue = nil)
    @user_provided_file = user_provided_file
    @user_provided_signatue = user_provided_signatue
  end

  def sign
    signature = EncryptoSigno.sign(private_key, file_contents(user_provided_file))
    file = File.new(signature_output_file_path, mode: "w")
    file.write(signature)
    file.close
    puts "#{user_provided_file} was signed using private key, signature saved as #{signature_output_file_path}"
  end

  # Returns boolean
  def verify
    puts EncryptoSigno.verify(
      public_key, 
      file_contents(user_provided_signatue), 
      file_contents(user_provided_file)
    )
  end

  private 

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
end

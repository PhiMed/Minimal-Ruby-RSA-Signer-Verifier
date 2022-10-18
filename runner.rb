require './lib/signer_verifier'

if ARGV[0] == 'verify'
  SignerVerifier.new(ARGV[1], ARGV[2]).verify
elsif ARGV[0] == 'sign'
  SignerVerifier.new(ARGV[1]).sign
end

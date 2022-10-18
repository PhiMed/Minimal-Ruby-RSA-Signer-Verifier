This is an absolute bare-bones pure Ruby application that will perform RSA signing and signature verification of user provided text files via the command line. 

**Setup:**

* Generate your own RSA private/public key pair and save them in the correspondingly named files inside this app automically by running these two commands from the top level directory for the app.

  `$openssl genrsa -out lib/private.key 2048`
  `$openssl rsa -pubout -in path/to/private.key -out lib/public.key`

  (or insert your own existing keys)

* Install dependencies: 

  `$gem install encrypto_signo` , `bundle install`

**To use:**

From the command line:
(while at the top level directory of this application)

* To create a signature for a file:

  `$ruby runner.rb sign <<path_to_file_you_wish_to_sign.txt>>`

  Application will create a new text file (named `<<original name>>_signature.txt` using the _private_ key and save it (in the top level directory of this app).

* To verify a signature for a file (assuming original file and signature are saved as seperate text files):

  `$ruby runner.rb verify <<path_to_original_file_you_wish_to_verifyt>>.txt <<path_to_signature_for_that_original_file>>.txt`

  Application will verify the signature/original file combo using the _public_ key, and return `true` if can be verified and `false` in all other scenarios.

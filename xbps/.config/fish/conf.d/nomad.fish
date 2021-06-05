set -x NOMAD_NAMESPACE '*'
set -x NOMAD_ADDR "https://nomad.s.voidlinux.org"
set -x VAULT_ADDR "https://vault.s.voidlinux.org"

function vault-login
	vault login -method=ldap
	# can take username=$username parameter
	#expires in one day
end

function nomad-token
	set -xg NOMAD_TOKEN (vault read -field secret_id nomad/creds/apps-admin)
	#expires in one hour
end

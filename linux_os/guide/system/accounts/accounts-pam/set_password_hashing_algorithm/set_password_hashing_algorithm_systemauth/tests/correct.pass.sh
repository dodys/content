#!/bin/bash
# platform = Oracle Linux 7,Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ubuntu
# variables = var_password_hashing_algorithm_pam=sha512

{{% if 'ubuntu' in product %}}
config_file=/usr/share/pam-configs/tmpunix
cat << EOF > "$config_file"
Name: Unix authentication
Default: yes
Priority: 257
Conflicts: unix
Auth-Type: Primary
Auth:
        [success=end default=ignore]    pam_unix.so try_first_pass
Auth-Initial:
        [success=end default=ignore]    pam_unix.so
Account-Type: Primary
Account:
        [success=end new_authtok_reqd=done default=ignore]      pam_unix.so
Account-Initial:
        [success=end new_authtok_reqd=done default=ignore]      pam_unix.so
Session-Type: Additional
Session:
        required        pam_unix.so
Session-Initial:
        required        pam_unix.so
Password-Type: Primary
Password:
        [success=end default=ignore]    pam_unix.so obscure use_authtok try_first_pass sha512
Password-Initial:
        [success=end default=ignore]    pam_unix.so obscure sha512
EOF
DEBIAN_FRONTEND=noninteractive pam-auth-update
rm "$config_file"
{{% else %}}
pam_file="/etc/pam.d/system-auth"

if ! grep -q "^password.*sufficient.*pam_unix\.so.*sha512" "$pam_file"; then
	sed -i --follow-symlinks '/^password.*sufficient.*pam_unix\.so/ s/$/ sha512/' "$pam_file"
fi
{{% endif %}}

#!/bin/bash
# platform = multi_platform_ubuntu

{{% if product == "ubuntu2204" %}}
sshd_approved_macs="hmac-sha2-512,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha2-256-etm@openssh.com"
{{% else %}}
sshd_approved_macs="hmac-sha2-512,hmac-sha2-256"
{{% endif %}}

sed -i "/^MACs.*/d" /etc/ssh/sshd_config
sed -i "/^MACs.*/d" /etc/ssh/sshd_config.d/*
echo "MACs $sshd_approved_macs" >> /etc/ssh/sshd_config.d/test.conf

#!/bin/bash
{{{ tests_init_faillock_vars("lenient_low") }}}
# platform = multi_platform_ubuntu


{{{ bash_enable_pam_faillock_directly_in_pam_files() }}}

echo "$PRM_NAME=$TEST_VALUE" > /etc/security/faillock.conf

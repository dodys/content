# platform = multi_platform_debian

{{{ bash_package_install("aide") }}}

AIDE_CONFIG=/etc/aide/aide.conf
DEFAULT_DB_PATH=/var/lib/aide/aide.db

# Fix db path in the config file, if necessary
{{% if product == 'debian13' %}}
if ! grep -q '^database_in=file:' ${AIDE_CONFIG}; then
    echo "database_in=file:${DEFAULT_DB_PATH}" >> ${AIDE_CONFIG}
fi
{{% else %}}
if ! grep -q '^database=file:' ${AIDE_CONFIG}; then
    # replace_or_append gets confused by 'database=file' as a key, so should not be used.
    #replace_or_append "${AIDE_CONFIG}" '^database=file' "${DEFAULT_DB_PATH}" '@CCENUM@' '%s:%s'
    echo "database=file:${DEFAULT_DB_PATH}" >> ${AIDE_CONFIG}
fi
{{% endif %}}

# Fix db out path in the config file, if necessary
if ! grep -q '^database_out=file:' ${AIDE_CONFIG}; then
    echo "database_out=file:${DEFAULT_DB_PATH}.new" >> ${AIDE_CONFIG}
fi

/usr/sbin/aideinit -y -f

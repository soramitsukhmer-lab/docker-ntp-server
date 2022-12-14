#!/command/with-contenv sh

ME=$(basename $0)
DEFAULT_NTP="time.cloudflare.com"
CHRONY_CONF_FILE="/etc/chrony/chrony.conf"

# confirm correct permissions on chrony run directory
if [ -d /run/chrony ]; then
  chown -R chrony:chrony /run/chrony
  chmod o-rx /run/chrony

  # remove previous pid file if it exist
  test -f /run/chronyd.pid && rm -f /run/chronyd.pid
  test -f /var/run/chrony/chronyd.pid && rm -f /var/run/chrony/chronyd.pid
fi

# confirm correct permissions on chrony variable state directory
if [ -d /var/lib/chrony ]; then
  chown -R chrony:chrony /var/lib/chrony
fi

## dynamically populate chrony config file.
{
  echo "# chrony.conf file generated by $ME"
  echo "# time servers provided by NTP_SERVER environment variables."
} > ${CHRONY_CONF_FILE}


# NTP_SERVERS environment variable is not present, so populate with default server
if [ -z "${NTP_SERVERS}" ]; then
  NTP_SERVERS="${DEFAULT_NTP}"
fi

IFS=","
for N in $NTP_SERVERS; do
  # strip any quotes found before or after ntp server
  N_CLEANED=${N//\"}

  # check if ntp server has a 127.0.0.0/8 address (RFC3330) indicating it's
  # the local system clock
  if [[ "${N_CLEANED}" == *"127\."* ]]; then
    echo "server ${N_CLEANED}" >> ${CHRONY_CONF_FILE}
    echo "local stratum 10"    >> ${CHRONY_CONF_FILE}
    echo "makestep 0.1 3" >> ${CHRONY_CONF_FILE}

  # found pool time servers
  elif [[ "${N_CLEANED}" == *"pool\."* ]]; then
    echo "pool ${N_CLEANED} iburst" >> ${CHRONY_CONF_FILE}
    echo "makestep 1.0 3" >> ${CHRONY_CONF_FILE}

  # found external time servers
  else
    echo "server ${N_CLEANED} iburst" >> ${CHRONY_CONF_FILE}
    echo "makestep 0.1 3" >> ${CHRONY_CONF_FILE}
  fi
done

# final bits for the config file
{
  echo "rtcsync"
  echo "allow all"
  echo "driftfile /var/lib/chrony/chrony.drift"
  echo "dumpdir /var/run/chrony"
} >> ${CHRONY_CONF_FILE}

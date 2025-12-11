#!/bin/sh

FTP_PASSWORD=$(cat /run/secrets/ftp_password)

if [ -z "$FTP_USER" ]; then
    echo "FTP_USER is not set, default: \"ftpuser\"!"
	FTP_USER="ftpuser"
fi

mkdir -p /var/www/html

if ! id "$FTP_USER" >/dev/null 2>&1; then
    echo "Creating FTP user: $FTP_USER"
    adduser -D -h /var/www/html $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

chown -R $FTP_USER:$FTP_USER /var/www/html

echo "Starting vsftpd..."
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
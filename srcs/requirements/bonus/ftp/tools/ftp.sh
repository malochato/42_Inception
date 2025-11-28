#!/bin/sh

if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
    echo "FTP_USER or FTP_PASSWORD is not set!"
    exit 1
fi

if ! id "$FTP_USER" >/dev/null 2>&1; then
    echo "Creating FTP user: $FTP_USER"
    adduser -D -h /var/www/html $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

chown -R $FTP_USER:$FTP_USER /var/www/html

echo "Starting vsftpd..."
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
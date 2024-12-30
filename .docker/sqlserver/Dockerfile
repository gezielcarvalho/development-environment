FROM rapidfort/microsoft-sql-server-2019-ib:latest

USER root
# Create home directory and set permissions
RUN mkdir -p /home/mssql /var/opt/mssql/data && \
    chown -R 10001:0 /var/opt/mssql/data && \
    chmod -R 700 /var/opt/mssql/data

# Switch back to mssql user
USER mssql

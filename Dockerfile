FROM apache/airflow:1.10.12-python3.6

USER root

#COPY kubectl-hpecp /tmp
#COPY kubectl /tmp

#RUN cd /tmp && \
#    chmod +rx ./kubectl && \
#    chmod +rx ./kubectl-hpecp && \
#    mv ./kubectl /usr/bin/kubectl && \
#    mv ./kubectl-hpecp /usr/bin/kubectl-hpecp
	
# Copy certs
#COPY Certs\* /usr/local/share/ca-certificates/
#RUN chmod 755 /usr/local/share/ca-certificates/ca-bundle.crt

# Update certs
#RUN update-ca-certificates

#RUN echo export PIP_CERT=/etc/ssl/certs/ca-certificates.crt >> ~/.bashrc
#RUN export PIP_CERT=/etc/ssl/certs/ca-certificates.crt
#RUN export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
#RUN export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
#RUN export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt


# Install dependencies
RUN apt-get update
#RUN apt-get install -y python-dev libldap2-dev libssl-dev

RUN apt-get install -y build-essential python3-dev python2.7-dev \
    libldap2-dev libsasl2-dev slapd ldap-utils tox \
    lcov valgrind
	
USER airflow


#RUN apt-get -y install gcc python3-dev 

RUN pip config set global.index-url https://artifactory.gmfinancial.com/artifactory/api/pypi/remote-pip/simple

RUN pip config set global.trusted-host artifactory.gmfinancial.com

RUN pip install --user --upgrade pip
RUN pip install --user -U setuptools
RUN pip install --user apache-airflow-backport-providers-cncf-kubernetes
RUN pip install --user flask_bcrypt
#RUN pip install --user ldap3
RUN pip install python-ldap

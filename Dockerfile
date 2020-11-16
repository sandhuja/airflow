FROM apache/airflow:1.10.12-python3.6

USER root

COPY kubectl-hpecp /tmp
COPY kubectl /tmp

RUN cd /tmp && \
    chmod +rx ./kubectl && \
    chmod +rx ./kubectl-hpecp && \
    mv ./kubectl /usr/bin/kubectl && \
    mv ./kubectl-hpecp /usr/bin/kubectl-hpecp
	

# Install dependencies
RUN apt-get update
RUN apt-get -y install gcc python3-dev
RUN apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev
	
USER airflow

RUN pip install --user --upgrade pip
RUN pip install --user -U setuptools
RUN pip install --user apache-airflow-backport-providers-cncf-kubernetes
RUN pip install --user flask_bcrypt
RUN pip install --user ldap3
#RUN pip install python-ldap
RUN pip install --user pyldap

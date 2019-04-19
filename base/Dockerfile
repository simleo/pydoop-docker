ARG hadoop_version=3.2.0
ARG python_version=3.6
ARG maven_home=/opt/maven
ARG maven_version=3.6.0

FROM crs4/hadoop:${hadoop_version}-ubuntu
ARG maven_home
ARG maven_version
ARG python_version
ENV PYTHON=python${python_version}
RUN v=$([ ${python_version%%.*} -eq 3 ] && echo 3 || echo) \
    && apt-get -y update && apt-get -y install --no-install-recommends \
      build-essential \
      openjdk-8-jdk \
      python${python_version}-dev \
      python${v}-pip \
      zip \
    && apt clean && rm -rf /var/lib/apt-lists/* \
    && ${PYTHON} -m pip install --no-cache-dir --upgrade pip setuptools \
    && mkdir -p "${maven_home}" \
    && wget -q -O - "ftp://ftp.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz" | tar -xz --strip 1 -C "${maven_home}" \
    && echo "export M2_HOME=\"${maven_home}\"" >> /etc/profile.d/maven.sh \
    && echo "export M2=\"\${M2_HOME}/bin\"" >> /etc/profile.d/maven.sh \
    && echo "export PATH=\"\${M2}:\${PATH}\"" >> /etc/profile.d/maven.sh
ENV HADOOP_HOME=/opt/hadoop
ENV M2_HOME="${maven_home}"
ENV M2="${M2_HOME}/bin"
ENV PATH="${M2}:${PATH}"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

FROM postgres
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y sudo iputils-ping iproute2 jq vim netcat default-libmysqlclient-dev libsqlite3-dev postgresql-client-11 postgresql-server-dev-11 libpq-dev python3-pip bridge-utils wireguard linux-source curl git libssl-dev pkg-config build-essential ipset python3-setuptools python3-wheel dh-autoreconf procps iperf3
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN PATH=$PATH:$HOME/.cargo/bin cargo install diesel_cli --force

ENV POSTGRES_USER=postgres
ENV POSTGRES_BIN=/usr/lib/postgresql/15/bin/postgres
ENV INITDB_BIN=/usr/lib/postgresql/15/bin/initdb
ENV RUSTFLAGS="-C target-cpu=native"

ADD rita.tar.gz /
RUN pip3 install --user -r /althea_rs/integration-tests/requirements.txt
RUN git clone "https://github.com/kingoflolz/network-lab" "/althea_rs/integration-tests/deps/network-lab"
RUN git clone -b master https://github.com/althea-mesh/babeld.git "/althea_rs/integration-tests/deps/babeld" && make -C "/althea_rs/integration-tests/deps/babeld"
RUN cd "/althea_rs" && PATH=$PATH:$HOME/.cargo/bin cargo build  --all --release --features "rita_bin/development"

ADD scripts/entrypoint.sh /scripts/entrypoint.sh
RUN ["chmod", "+x", "/scripts/entrypoint.sh"]
ENTRYPOINT [ "/scripts/entrypoint.sh" ]
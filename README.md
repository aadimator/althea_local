# althea_local
Creates a local development environment for Althea using Docker

## Prerequisites

I'm starting with a clean Ubuntu install.

- Ubuntu 22.10
- `docker-ce`
	- Make sure that you are using `docker-ce` instead of `Docker Desktop`. I wasn't able to run it using `Docker Desktop`, and upon suggestion by Althea developer, using `docker-ce` results in all tests succeeding.

## Install Wireguard

```sh
sudo apt-get update && sudo apt install -y wireguard linux-source linux-headers-$(uname -r) build-essential && sudo modprobe wireguard
```

## Clone Repo

```sh
git clone --recurse-submodules git@github.com:aadimator/althea_local.git
cd althea_local
```

## Run bash script

Make sure that you're in the `althea_local` directory.

```sh
bash start.sh
```

This will build a Docker image, using the `althea_rs` repository, and configure all the different components needed to run Althea. In the end, it will run a Docker container and open the `bash` shell, where all the required dependencies and environment variables have been set.

Whenever you want to launch into the development environment, you'll have to execute the above script.

## Test

To test that everything is set up correctly, run the following integration test inside the container shell:

```sh
python3 althea_rs/integration-tests/integration-test-script/rita.py
```

This command will execute the official integration tests of `althea_rs` repository, testing the integration of different components. If all tests pass, you can be sure that everything is set up correctly.

## Environment Variables

Values of different environment variables can be changed in `env.list` file.
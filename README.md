# Blorg

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `(cd assets && npm install)`
  * Compile e4 files with `make`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Usage

### Docker Swarm for Development
```bash
sudo mkdir -p /var/vol/blorg-dev/postgres/data
sudo chown -R <you>:<you> /var/vol/blorg-dev/postgres/data
make docker-deploy-env-dev # Deploys swarm
make docker-bash-service-blorg-web_dev  # Executes bash in web service
    * make init
    * exit
```
  Now goto <YourIP>:4000 on your host machine
```bash
make docker-attach-service-blorg-web_dev #See mix log
```
  You can edit the files in host machine to see the changes while the development swarm is working. Call make after editing e4 files.

### Docker Swarm for Production
```bash
sudo mkdir -p /var/vol/blorg-prod/postgres/data
sudo chown -R <you>:<you> /var/vol/blorg-prod/postgres/data
make docker-deploy-env-prod # Deploys swarm
make docker-bash-service-blorg-web_prod
  make init
  exit
```
  Now goto <YourIP>:80 on your host machine
```bash
make docker-attach-service-blorg-web_prod #See mix log
```

## Developing a New Local Docker Image
If you edit docker/tempate-docker-compose.yml
```
make docker-compose-files
```
generates files for each env (prod, dev, local).

```
make docker-build-local-image-elixirelm/blorg
```
generates the local image. You can tag it for versioning and pushing later.
Use "local" instead of "prod" in "Deploying Swarm for Production" to test deploying with the local image

```
make docker-clean
```
cleans unused images after developing and testing local images

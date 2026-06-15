# ROFL Go Starter

A simple confidential [Go] app running in an [Intel TDX] VM with [Oasis ROFL].

> [!TIP]
> Read my [Create your first confidential Go app running in TDX VM with Oasis
ROFL][blog-post] blog post for a complete step-by-step guide.

[Go]: https://go.dev/
[Intel TDX]: https://en.wikipedia.org/wiki/Trust_Domain_Extensions
[Oasis ROFL]: https://docs.oasis.io/build/rofl/
[blog-post]: https://tadej.ja.nez.si/confidential-go-app-with-oasis-rofl.html

## Deployments

The ROFL Go Starter is currently deployed to:

| Chain            | App ID                                                    |
|------------------|-----------------------------------------------------------|
| Sapphire Testnet | [rofl1qphpdgztdm6edd7fhaulpg47qghtcr7uzyfgua3w][app-test] |

[app-test]:
  https://explorer.oasis.io/testnet/sapphire/rofl/app/rofl1qphpdgztdm6edd7fhaulpg47qghtcr7uzyfgua3w

## Quick start

To deploy your own ROFL Go Starter app, follow these steps:

> [!NOTE]
> You need to have [Oasis CLI][oasis-cli-setup] and either
> [Podman][podman-install] or [Docker][docker-engine-install] installed on your
> system.

1. Fork/Clone this GitHub repo.
2. Remove ROFL manifest (`rofl.yaml`) which contains information about my
   deployment.
3. Initialize your ROFL app and register it on-chain:

   ```sh
   oasis rofl init
   oasis rofl create --network testnet --account <YOUR-OASIS-CLI-ACCOUNT>
   ```

4. Build ROFL bundle for your ROFL app and update its on-chain registration:

   ```sh
   oasis rofl build
   oasis rofl update
   ```

5. Deploy your ROFL app:

   ```sh
   oasis rofl deploy --offer playground_short --term hour --term-count 2
   ```

6. Validate your ROFL app is running correctly:

   ```sh
   oasis rofl machine show
   oasis rofl machine logs
   ```

For a complete guide on how to perform the steps above, follow my
[Create your first confidential Go app running in TDX VM with Oasis
ROFL][blog-post] blog post.

[oasis-cli-setup]: https://docs.oasis.io/build/tools/cli/setup/
[podman-install]: https://podman.io/docs/installation
[docker-engine-install]: https://docs.docker.com/engine/install/

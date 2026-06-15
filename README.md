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

## Maintenance

### Machine status

To view the current machine's status, run:

```sh
oasis rofl machine show
```

Output should be similar to:

```text
Downloading compose.yaml artifact...
  URI: compose.yaml
Name:       default
Provider:   rofl:provider:sapphire (oasis1qp2ens0hsp7gh23wajxa4hpetkdek3swyyulyrmz)
ID:         000000000000062e
Offer:      0000000000000003
Status:     accepted
Creator:    rofl_go_starter (0x488347710509ff23C03C00fF66dA3aaeb566D61e)
Admin:      rofl_go_starter (0x488347710509ff23C03C00fF66dA3aaeb566D61e)
Node ID:    1owPK3eT21k0ajRG7VfHRgp4JPXobCQtzuglz6ZSJis=
Created at: 2026-06-15 12:41:07 +0200 CEST
Updated at: 2026-06-15 12:41:41 +0200 CEST
Paid until: 2026-06-15 13:41:07 +0200 CEST
Proxy:
  Domain: m1582.opf-testnet-rofl-25.rofl.app
Metadata:
  net.oasis.scheduler.rak: KUntNdw0QiwtQQgOqb38Nwl8SM4rbGqE7aVNsw/YDi0=
Resources:
  TEE:     Intel TDX
  Memory:  4096 MiB
  vCPUs:   2
  Storage: 20000 MiB
Deployment:
  App ID: rofl1qphpdgztdm6edd7fhaulpg47qghtcr7uzyfgua3w
  Metadata:
    net.oasis.deployment.orc.ref: rofl.sh/67ce5956-2253-4a7d-a036-816e48279277:1781344823@sha256:d8b4d6cddf8aaa434509d4165c961cf415dfaaa067572d15081fb78a2174807b
Commands:
  <no queued commands>
```

### Extending machine payment

To top-up the payment for the current machine, e.g. for 24 hours, run:

```sh
oasis rofl machine top-up --term hour --term-count 24
```

Output should be similar to:

```text
Downloading compose.yaml artifact...
  URI: compose.yaml
Using provider:     rofl:provider:sapphire (oasis1qp2ens0hsp7gh23wajxa4hpetkdek3swyyulyrmz)
Top-up machine:     default [000000000000062e]
Top-up term:        24 x hour (120.0 TEST total)
WARNING: Machine rental is non-refundable. You will not get a refund for the already paid term if you cancel.
Unlock your account.
? Passphrase: ***********
You are about to sign the following transaction:
Format: plain
Method: roflmarket.InstanceTopUp
Body:
  {
    "provider": "oasis1qp2ens0hsp7gh23wajxa4hpetkdek3swyyulyrmz",
    "id": "000000000000062e",
    "term": 1,
    "term_count": 24
  }
Authorized signer(s):
  1. A3H0gf7Kq/pvahKRi5sgyxaKB8f4bJrY+5MbVXSz53Rt (secp256k1eth)
     Nonce: 6
Fee:
  Amount: 0.0017016 TEST
  Gas limit: 17016
  (gas price: 0.0000001 TEST per gas unit)

Network:  testnet
ParaTime: sapphire
Account:  rofl_go_starter
? Sign this transaction? Yes
(In case you are using a hardware-based signer you may need to confirm on device.)
Broadcasting transaction...
Transaction included in block successfully.
Round:            17522674
Transaction hash: b8303ce18580bffdbad950f9e09ea2fe974eda2b691d384b10d433cae8110623
Execution successful.
Machine topped up.
```

### Replacing non-existing machine with a new one

If the ROFL app has no machine running it, you can replace it with a new one by
running:

```sh
oasis rofl deploy --replace-machine
```

Output should be similar to:

```text
Downloading compose.yaml artifact...
  URI: compose.yaml
Using provider: rofl:provider:sapphire (oasis1qp2ens0hsp7gh23wajxa4hpetkdek3swyyulyrmz)
Unlock your account.
? Passphrase: ***********
Pushing ROFL app to OCI repository 'rofl.sh/67ce5956-2253-4a7d-a036-816e48279277:1781344823'...
Pushing... 100.00% [#################################################] 84.84 MiB
Deploying into existing machine: 000000000000062b
Machine instance not found. Obtaining new one...Taking offer:
  - playground_short [0000000000000003]
    TEE: tdx | Memory: 4096 MiB | vCPUs: 2 | Storage: 19.53 GiB
    Capacity: 200
    Payment: hourly: 5.0 TEST
Selected per-hour pricing term, total price is 5.0 TEST.
WARNING: Machine rental is non-refundable. You will not get a refund for the already paid term if you cancel.
You are about to sign the following transaction:
Format: plain
Method: roflmarket.InstanceCreate
Body:
  {
    "provider": "oasis1qp2ens0hsp7gh23wajxa4hpetkdek3swyyulyrmz",
    "offer": "0000000000000003",
    "deployment": {
      "app_id": "rofl1qphpdgztdm6edd7fhaulpg47qghtcr7uzyfgua3w",
      "manifest_hash": "8b09c390cadf48a365118b3a254070731627b78fe4d517c6a866b63674112731",
      "metadata": {
        "net.oasis.deployment.orc.ref": "rofl.sh/67ce5956-2253-4a7d-a036-816e48279277:1781344823@sha256:d8b4d6cddf8aaa434509d4165c961cf415dfaaa067572d15081fb78a2174807b"
      }
    },
    "term": 1,
    "term_count": 1
  }
Authorized signer(s):
  1. A3H0gf7Kq/pvahKRi5sgyxaKB8f4bJrY+5MbVXSz53Rt (secp256k1eth)
     Nonce: 5
Fee:
  Amount: 0.0121926 TEST
  Gas limit: 121926
  (gas price: 0.0000001 TEST per gas unit)

Network:  testnet
ParaTime: sapphire
Account:  rofl_go_starter
? Sign this transaction? Yes
(In case you are using a hardware-based signer you may need to confirm on device.)
Broadcasting transaction...
Transaction included in block successfully.
Round:            17522448
Transaction hash: b8b4f8698246b1473ff7705c980e743e51655e45e272c28544707598934c3565
Execution successful.
Created machine: 000000000000062e
Deployment into machine scheduled.
This machine expires on 2026-06-15 13:41:07 +0200 CEST. Use `oasis rofl machine top-up` to extend it.
Use `oasis rofl machine show` to check status.
```

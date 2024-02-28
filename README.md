# Hardhat Boilerplate Project

This project is boilerplate with some config, tasks, docs, coverage, verify scan to use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

## Documents

- [Especificação de contrato inteligente](./Lock.md)
- [Exemplo de auditória interna](./audits/ExampleAudit.md)

We using lint-staged and husky to execute git hooks.

## Try running some of the following tasks:

### Common command

```shell
npx hardhat help
npm run compile
npm run chain
npm run clean
npm run test
npm run test:watch
npm run coverage
npm run contract-size
REPORT_GAS=true npx hardhat test
```

### Deploy

```shell
npx hardhat run scripts/deploy.ts
```

### Tasks

Tasks to create new wallet `--total` is a param to set how munch wallet will be created

```shell
npx hardhat createWallet --total 2 --network localhost
```

### Generate documentation

Add NatSpec comment into contracts to create Markdown documentation

```shell
npm run docs
```

### Lint and Rewrite code style

Add NatSpec comment into contracts to create Markdown documentation

```shell
npm run lint
npm run format
```

### Slither static analysis

static analysis framework and vulnerability detectors for auditing smart contract

```shell
npm run slither
npm run slither-print
```

### EtherScan

This plugin helps you verify the source code for your Solidity contracts. At the moment, it supports Etherscan-based explorers, explorers compatible with its API like Blockscout

```shell
npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"

```

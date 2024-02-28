# Solidity API

## Lock

Você pode usar este contrato para permite saque de Ether após uma data ou período específico

### unlockTime

```solidity
uint256 unlockTime
```

unlockTime guarda a data
Use essa variável para guarda data que será permitida o saque

### unlockTime2

```solidity
uint256 unlockTime2
```

### owner

```solidity
address payable owner
```

owner aguarda a carteira
Carteira que receberá o valor sacado

### Withdrawal

```solidity
event Withdrawal(uint256 amount, uint256 when)
```

Withdrawal evento emitido ao fazer o saque

#### Parameters

| Name   | Type    | Description        |
| ------ | ------- | ------------------ |
| amount | uint256 | Total a ser sacado |
| when   | uint256 | Data do saque      |

### constructor

```solidity
constructor(uint256 _unlockTime) public payable
```

Construtor

#### Parameters

| Name         | Type    | Description                           |
| ------------ | ------- | ------------------------------------- |
| \_unlockTime | uint256 | data que será permitodo fazer o saque |

### receive

```solidity
receive() external payable
```

receive função que a permite o contrato receber valores em ether
use essa função para enviar ethers para o contrato

### withdraw

```solidity
function withdraw() external
```

withdraw função que permite o saque
Use está função fazer saque se você é o owner e se passou o período de bloquei de saque por data.

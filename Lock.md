# Lock Project

## Technical Spec

Desbloqueio de saque por data

- O contrato deve receber uma data de desbloqueio para saques
- O contrato pode receber valor no deploy
- O contrato pode receber valor após deploy
- O dono do contrato deve ser o endereço da carteira responsável de fazer o deploy
- Apenas o dono do contrato poderá sacar se a data para o desbloqueio for igual ou anterior da data atual

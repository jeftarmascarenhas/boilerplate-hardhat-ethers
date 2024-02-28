// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @dev discomente console.log
 */
// import "hardhat/console.sol";

/**
 * @title Desbloqueio de saque por data
 * @author Jeftar Mascarenhas
 * @notice Você pode usar este contrato para permite saque de Ether após uma data ou período específico
 */
contract Lock {
  /**
   * unlockTime guarda a data
   * @notice Use essa variável para guarda data que será permitida o saque
   */
  uint public unlockTime;
  uint public unlockTime2;
  /**
   * owner aguarda a carteira
   * @notice Carteira que receberá o valor sacado
   */
  address payable public owner;
  /**
   * Withdrawal evento emitido ao fazer o saque
   * @param amount Total a ser sacado
   * @param when Data do saque
   */
  event Withdrawal(uint amount, uint when);

  /**
   * Construtor
   * @param _unlockTime data que será permitodo fazer o saque
   */
  constructor(uint _unlockTime) payable {
    require(block.timestamp < _unlockTime, "Unlock time should be in the future");

    unlockTime = _unlockTime;

    owner = payable(msg.sender);
  }

  /**
   * receive função que a permite o contrato receber valores em ether
   * @notice use essa função para enviar ethers para o contrato
   */
  receive() external payable {
    require(msg.value > 0, "Cannot 0 value");
  }

  /**
   * withdraw função que permite o saque
   * @notice Use está função fazer saque se você é o owner e se passou o período de bloquei de saque por data.
   */
  function withdraw() external {
    // Descomente a linha abaixo e o import of "hardhat/console.sol", para printar o logo no terminal
    // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

    require(block.timestamp >= unlockTime, "You can't withdraw yet");
    require(msg.sender == owner, "You aren't the owner");

    emit Withdrawal(address(this).balance, block.timestamp);

    owner.transfer(address(this).balance);
  }
}

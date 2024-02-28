# Contract Peer Micro Audit

Example for create internal audits

In this example we're using a CrowdFunding smart contracts

## Classification Legend

​
Perfect score is **0**
​
| Severity | Code | Points | Description |
| ------------------ | ---- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| High | H | 3 | This issue can take the entire project down. Ownership can get hacked, funds can get stolen, bad actors can grief everyone else, these sorts of things. |
| Medium | M | 2 | There's some large potential risk, but it's not obvious whether the issue will actually happen in practice. |
| Low | L | 1 | A small amount of risk, perhaps unlikely, perhaps not relevant, but notable nonetheless. |
| Unfinished Feature | UF | 1 | Unfinished Features described in the specification |
| Extra Feature | EF | 1 | Extra features added to the project |
| Technical Mistake | TM | 0 up to 3 | No security threats, but not working as intended in the specification |
| Code Quality | Q | 0 | No obvious risk, but fixing it improves code quality, better conforms to standards, and ultimately may reduce unperceived risk in the future. |
| Nitpicking | N | 0 | No risk at all, just a different approach regarding the code and business logic |
​

## Tests

​
Your tests are imcomplete and they don't has the minimum coverage of 100% of the contracts functions!
​
| File | % Stmts | % Branch | % Funcs | % Lines | Uncovered Lines |
| --------------------------- | ---------- | ---------- | ---------- | ---------- | ---------------- |
| contracts/ | 72.55 | 47.37 | 53.33 | 72.73 | |
| CrowdFundingFactory.sol | 100 | 100 | 100 | 100 | |
| CrowdFundingNFT.sol | 0 | 100 | 0 | 0 | ... 30,34,44,45 |
| CrowdFundingTemplate.sol | 82.93 | 47.37 | 87.5 | 83.72 | ... 120,122,123 |
| --------------------------- | ---------- | ---------- | ---------- | ---------- | ---------------- |
| All files | 72.55 | 47.37 | 53.33 | 72.73 | |
​

## Extra Files

​
The CrowdFundingNFT.sol has no use in your repository, consider removing it!
​

## Found Vulnerabilities

​

### **[H-1]** `mintNFT` function is public and without modifiers

​
On line 64-67, CrowdFundingTemplate has the following code:
​

```solidity
function mintNFT(address _donor) public {
  tokendIds++;
  _mint(_donor, tokendIds);
}
```

​
This function is responsible for minting new NFT badges, but it's public and has no checks to verify if a NFT badge should be generated. So one donor could donate the min amount of `0.01 ether` and then call this function N times to create unlimited badges for him.
​
Consider change it to a `internal` function instead of `public`
​

### **[H-2]** Arbitrary contributions value are possible in `pledge` function

​
The pledge function in your code has the following snippet:
​

```solidity
    campaign.pledged += _amout;
    donorsAmount[msg.sender].donor = msg.sender;
    donorsAmount[msg.sender].amount += _amout;
```

​
Where `_amout` (there is a typo here as well), was supposed to represent the value that the user is depositing in the contract.
The problem here is that you didn't write a require that enforces `msg.value` to be equal to `_amout`. So a bad user could send the minimum amount of `0.01 ether` but pass any amount they want in the parameter `_amout` and there is nothing checking if `msg.value == _amout`.
This creates the following vulnerabilities:
​

- A user could "complete" the crowdfund by calling `pledge` with `value: 0.01 ether` and `_amout = campaign.goal`.
- One user can refund more than he deposit.
- A user could get more NFT Badges than what they deserve.
  ​
  In order to fix this, consider removing the parameter `_amout` and use only the `msg.value`:
  ​

```solidity
    campaign.pledged += msg.value;
    donorsAmount[msg.sender].donor = msg.sender;
    donorsAmount[msg.sender].amount += msg.value;
```

​
And in the function signature:
​

```solidity
function pledge() public payable {}
```

​

### **[M-1]** Toggle canceling is an extra feature that introduce a vulnerability

​
Your contract has a function called `toggleCanceled` that can change the `cancel` status of a project.
​
This is an extra feature and can cause grief to users since an owner could cancel the project, withdraw the funds and then reactivate the project allowing for people to deposit again.
​
Consider change this function to be only a cancel function:
​

```solidity
function cancel() external onlyOwner {
  require(campaign.endAt <= block.timestamp + PERIOD, 'greater than 30 days');
  canceled = true;
}
```

​

### **[L-1]** Withdraw funds from the contract can happen only once

​
In your `claim` function you have the check `require(!campaign.claimed, "campaign claimed");` and on the first execution you are setting `campaign.claimed = true;` making it impossible to call `claim` function a second time.
​
Although all the contract balance is withdrawn, more funds could end up in the contract and with this check they would be locked forever in this contract. This could happen, for example if someone calls a `selfdestruct` passing this contract address as parameter. Even though there are no `receive` or `fallback` functions, the funds are transferred to your contract anyway.
​
Consider removing this `require(!campaign.claimed, "campaign claimed");` and adding only a check for the balance in the contract:
`require(address(this).balance > 0, "no balance");`
​

## Extra Features

​

### **[EF-1]** No need for the `crowdFunds` state variable at `CrowdFundingFactory.sol`

​
In your CrowdFundingFactory, you added a variable called `crowndFunds` that saves every crowdfund project created. This is an unnecessary feature and it was not specified in the project specs.
​

### **[EF-2]** Duration time should be only 30 days

​
The user should not have the ability to temper with the funding period, this was not specified in the specs and is an unnecessary feature that only increases the surface attack of your contract.
​

- **[Q-2]** Multiplication in `createBadges` function
  ​
  In your `createBadges` function, consider change the code from this:
  ​

```solidity
uint256 amountSize = totalAmount - (totalBadges * 1000000000000000000);
```

​
To this
​

```solidity
uint256 amountSize = totalAmount - (totalBadges * 10**18);
```

​
This is a more "understandable" way to point out that you are multiplying by the wei decimals
​

- **[Q-3]** Duplicated `require` in `pledge` function
  Your `pledge` functions checks the same condition twice:
  ​
  Line 82
  ​

```solidity
require(!canceled, "canceled");
```

​
Line 91
​

```solidity
require(!canceled, "campaign canceled");
```

​
You can exclude the second one, since will not revert ever
​

## Your score

​
| Severity | Points |
| ------------------ | ------ |
| High | 6 |
| Medium | 2 |
| Low | 1 |
| Unfinished Feature | 0 |
| Extra Feature | 3 |
| Technical Mistake | 0 |
| Code Quality | 0 |
| TOTAL | 12 |
​
Good Job!

// solium-disable linebreak-style
pragma solidity >=0.6.0 <0.7.0;


contract FundFactory{
    address[] public activeFunds;

    function createFund(uint goal,string memory cname,string memory description) public{
        address Fund = address(new Fund(goal,msg.sender,cname,description));
        activeFunds.push(Fund);
    }

    function getActiveFunds() public view returns(address [] memory){
        return activeFunds;
    }
}


contract Fund {
    
    address payable public createrAddress;
    string public createrName;
    
    uint public goal;
    string public description;
    
    uint public totalContribution;
    uint public currentBalance;
    uint public totalContributors;
   
    contributerDetails [] public donators;
    
    struct contributerDetails {
        string contributorName;
        uint contributedAmount;
    }
    
    // mapping(address => address) public checkaddress;
    // mapping(address => bool) public Checknew;
    modifier restricted(){
        require(createrAddress == msg.sender,"This function can be called only by Owner.");
        _;
    }

    constructor (uint amount,address creater,string memory cname,string memory desc) public{
        createrAddress = payable(msg.sender);
        goal = amount;
        createrName =  cname;
        description = desc;
        currentBalance= address(this).balance;
    }
    
    function donate(string memory name) public payable{
        require(msg.value >= 100,"Minimum contribution is 100 Wei");
        totalContribution = totalContribution + msg.value;
        currentBalance= address(this).balance;
        contributerDetails memory newContibutor= contributerDetails({
            contributorName : name,
            contributedAmount : msg.value
        });
        donators.push(newContibutor);
        //Checknew[msg.sender]=true;
        totalContributors++;
    }
    
    function checkout(uint value) public restricted{
        require(address(this).balance>=value,"Requested amount is more than current balance.");
        createrAddress.transfer(value);
        currentBalance = address(this).balance;
    }
}
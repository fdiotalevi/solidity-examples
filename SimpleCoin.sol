pragma solidity ^0.4.0;

contract ERC20Coin{
    function totalSupply() constant returns (uint256 theTotalSupply);
    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract MyCoin is ERC20Coin{
    
    uint256 initialSupply;
    string symbol;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
 
    
    function MyCoin(string _symbol, uint256 theInitialSupply) {
        symbol = _symbol;
        balances[msg.sender] = theInitialSupply;
        initialSupply = theInitialSupply;
    }
    
    function totalSupply() constant returns (uint256) {
        return initialSupply;
    }
    
    function balanceOf(address _owner) constant returns (uint256) {
        return balances[_owner];
    }
    
    function myBalance() constant returns (uint256) {
        return balances[msg.sender];
    }
    
    function transfer(address _to, uint256 _value) returns (bool) {
        if ((balances[msg.sender] >= _value)
            && (balances[_to] + _value > balances[_to])) {
                
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        }
            
        return false;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if ((balances[_from] >= _value)     //fund availability
            && (balances[_to] + _value > balances[_to]) //integer overflow
            && (allowed[_from][msg.sender] >= _value)) {
                
            allowed[_from][msg.sender] -= _value;
            balances[_from] -= _value;
            balances[_to] += _value;
            Transfer(_from, _to, _value);
            return true;                
        }
        
        return false;
    }
    
    function approve(address _spender, uint256 _value) returns (bool) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) constant returns (uint256) {
        return allowed[_owner][_spender];
    }     
    

}


pragma solidity >=0.5.0;

import 'usingtellor/contracts/UsingTellor.sol';
import 'USCDToken/usdc.sol';
import 'tbtcdeposit.sol';

contract MyContract is UsingTellor{
 ...
    constructor(address _userContract) UsingTellor(_userContract) public{}
}

contract BtcPrice1HourAgoContract is UsingTellor {

  uint256 btcPrice;
  uint256 btcRequetId = 2;

  constructor(address payable _tellorAddress) UsingTellor(_tellorAddress) public {}

  function getBtcPriceBefore1HourAgo() public view returns (uint256) {
    bool _didGet;
    uint _timestamp;
    uint _value;

    // Get the price that is older than an hour (looking back at most 60 values)
    (_didGet, _value, _timestamp) = getDataBefore(btcRequetId, now - 1 hours, 60, 0);

    if(_didGet){
      btcPrice = _value;
    }
}
}
}
}

contract EthPrice1HourAgoContract is UsingTellor {

  uint256 EthPrice;
  uint256 ethRequetId = 1;

  constructor(address payable _tellorAddress) UsingTellor(_tellorAddress) public {}

  function getEthPriceBefore1HourAgo() public view returns (uint256) {
    bool _didGet;
    uint _timestamp;
    uint _value;

    // Get the price that is older than an hour (looking back at most 60 values)
    (_didGet, _value, _timestamp) = getDataBefore(ethRequetId, now - 1 hours, 60, 0);

    if(_didGet){
      ethPrice = _value;
    }
}
}

contract TrbPrice1HourAgoContract is UsingTellor {

  uint256 trbPrice;
  uint256 trbRequetId = 43;

  constructor(address payable _tellorAddress) UsingTellor(_tellorAddress) public {}

  function getTrbPriceBefore1HourAgo() public view returns (uint256) {
    bool _didGet;
    uint _timestamp;
    uint _value;

    // Get the price that is older than an hour (looking back at most 60 values)
    (_didGet, _value, _timestamp) = getDataBefore(trbRequetId, now - 1 hours, 60, 0);

    if(_didGet){
      trbPrice = _value;
    }
  }
}

contract usdcPriceContract is UsingTellor {

  uint256 usdcPrice;
  uint256 usdcRequetId = 25;

  constructor(address payable _tellorAddress) UsingTellor(_tellorAddress) public {}

  function setUsdcPrice() public {
    bool _didGet;
    uint _timestamp;
    uint _value;

    (_didGet, usdcPrice, _timestamp) = getCurrentValue(usdcRequetId);
  }



        function readTellorValue(uint256 _tellorID) external view returns (uint256) {
    //Helper function to get latest available value for that Id
    (bool ifRetrieve, uint256 value, uint256 _timestampRetrieved) = getCurrentValue(_tellorID);
    if(!ifRetrieve) return 0;
    return value;
  }


  function readTellorValueBefore(uint256 _tellorId, uint256 _timestamp) external returns (uint256, uint256){
    //Helper Function to get a value before the given timestamp
    (bool _ifRetrieve, uint256 _value, uint256 _timestampRetrieved)  = getDataBefore(_tellorId, _timestamp);
    if(!_ifRetrieve) return (0,0);
    return (_value, _timestampRetrieved);
  |


    uint256 _count = _tellorm.getNewValueCountbyRequestId(_requestId);
        if (_count > 0) {
            for (uint256 i = _count - _offset; i < _count -_offset + _limit; i++) {
                uint256 _time = _tellorm.getTimestampbyRequestIDandIndex(_requestId, i - 1);
                if(_value > 0 && _time > _timestamp){
                    return(true, _value, _timestampRetrieved);
                }
                else if (_time > 0 && _time <= _timestamp && _tellorm.isInDispute(_requestId,_time) == false) {
                    _value = _tellorm.retrieveData(_requestId, _time);
                    _timestampRetrieved = _time;
                    if(i == _count){
                        return(true, _value, _timestampRetrieved);
                    }
                }
            }
        }
        return (false, 0, 0);
    }
}
}

contract UniswapExchangeInterface {
    
    function tokenAddress() external view returns (address token);
    
    function factoryAddress() external view returns (address factory);
    // Provide Liquidity
    function addLiquidity(uint256 min_liquidity, uint256 max_tokens, uint256 deadline) external payable returns (uint256);
    function removeLiquidity(uint256 amount, uint256 min_eth, uint256 min_tokens, uint256 deadline) external returns (uint256, uint256);
    // Get Prices
    function getEthToTokenInputPrice(uint256 eth_sold) external view returns (uint256 tokens_bought);
    function getEthToTokenOutputPrice(uint256 tokens_bought) external view returns (uint256 eth_sold);
    function getTokenToEthInputPrice(uint256 tokens_sold) external view returns (uint256 eth_bought);
    function getTokenToEthOutputPrice(uint256 eth_bought) external view returns (uint256 tokens_sold);
    // Trade ETH to ERC20
    function ethToTokenSwapInput(uint256 min_tokens, uint256 deadline) external payable returns (uint256  tokens_bought);
    function ethToTokenTransferInput(uint256 min_tokens, uint256 deadline, address recipient) external payable returns (uint256  tokens_bought);
    function ethToTokenSwapOutput(uint256 tokens_bought, uint256 deadline) external payable returns (uint256  eth_sold);
    function ethToTokenTransferOutput(uint256 tokens_bought, uint256 deadline, address recipient) external payable returns (uint256  eth_sold);
    
    function tokenToEthSwapInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline) external returns (uint256  eth_bought);
    function tokenToEthTransferInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline, address recipient) external returns (uint256  eth_bought);
    function tokenToEthSwapOutput(uint256 eth_bought, uint256 max_tokens, uint256 deadline) external returns (uint256  tokens_sold);
    function tokenToEthTransferOutput(uint256 eth_bought, uint256 max_tokens, uint256 deadline, address recipient) external returns (uint256  tokens_sold);
    
    function tokenToTokenSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address token_addr) external returns (uint256  tokens_bought);
    function tokenToTokenTransferInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address recipient, address token_addr) external returns (uint256  tokens_bought);
    function tokenToTokenSwapOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address token_addr) external returns (uint256  tokens_sold);
    function tokenToTokenTransferOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address recipient, address token_addr) external returns (uint256  tokens_sold);
    
    function tokenToExchangeSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address exchange_addr) external returns (uint256  tokens_bought);
    function tokenToExchangeTransferInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address recipient, address exchange_addr) external returns (uint256  tokens_bought);
    function tokenToExchangeSwapOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address exchange_addr) external returns (uint256  tokens_sold);
    function tokenToExchangeTransferOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address recipient, address exchange_addr) external returns (uint256  tokens_sold);

    bytes32 public name;
    bytes32 public symbol;
    uint256 public decimals;
    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 value) external returns (bool);
    function approve(address _spender, uint256 _value) external returns (bool);
    function allowance(address _owner, address _spender) external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256);
    function totalSupply() external view returns (uint256);
    
    function setup(address token_addr) external;
}

interface tBTC {
    function totalSupply() public view returns (uint supply);
    function balanceOf(address _owner) public view returns (uint balance);
    function transfer(address _to, uint _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint _value) public returns (bool success);
    function approve(address _spender, uint _value) public returns (bool success);
    function allowance(address _owner, address _spender) public view returns (uint remaining);
    function decimals() public view returns(uint digits);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}





/// 1inch interface
interface inchNetworkProxyInterface {
    function maxGasPrice() public view returns(uint);
    function getUserCapInWei(address user) public view returns(uint);
    function getUserCapInTokenWei(address user, TBTC token) public view returns(uint);
    function enabled() public view returns(bool);
    function info(bytes32 id) public view returns(uint);

    function getExpectedRate(TBTC src, TBTC dest, uint srcQty) public view
        returns (uint expectedRate, uint slippageRate);

    function tradeWithHint(TBTC src, uint srcAmount, TBTC dest, address destAddress, uint maxDestAmount,
        uint minConversionRate, address walletId, bytes hint) public payable returns(uint);

    function swapEtherToToken(TBTC token, uint minRate) public payable returns (uint);

    function swapTokenToEther(TBTC token, uint tokenQty, uint minRate) public returns (uint);


}

interface TellorInterface {
  function getExchangeRate ( string fromSymbol, string toSymbol, string venue, uint256 amount ) external view returns ( uint256 );
  function getTokenDecimalCount ( address tokenAddress ) external view returns ( uint256 );
  function getTokenAddress ( string symbol ) external view returns ( address );
  function getSynthBytes32 ( string symbol ) external view returns ( bytes32 );
  function getForexAddress ( string symbol ) external view returns ( address );
}





contract Trader{

    TBTC constant internal ETH_TOKEN_ADDRESS = TBTC(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee);
    InchNetworkProxyInterface public proxy = InchNetworkProxyInterface();
    TellorInterface liquidity= TellorInterface();
    address usdcAddress = 0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359;
    bytes  PERM_HINT = "PERM";
    address owner;



    modifier onlyOwner() {
        if (msg.sender != owner) {
            throw;
        }
        _;
    }


    constructor(){
     owner = msg.sender;
 }

   function swapEtherToToken (InchNetworkProxyInterface _inchNetworkProxy, TBTC token, address destAddress) internal{

    uint minRate;
    (, minRate) = _inchNetworkProxy.getExpectedRate(ETH_TOKEN_ADDRESS, token, msg.value);

    uint destAmount = _inchNetworkProxy.swapEtherToToken.value(msg.value)(token, minRate);

    
   require(token.transfer(destAddress, destAmount));



    }

    function swapTokenToEther1 (InchNetworkProxyInterface _inchNetworkProxy, TBTC token, uint tokenQty, address destAddress) internal returns (uint) {

        uint minRate =1;
        

        
        token.transferFrom(msg.sender, this, tokenQty);

       token.approve(proxy, 0);

        // Approve tokens so network can take them during the swap
       token.approve(address(proxy), tokenQty);


       uint destAmount = proxy.tradeWithHint(TBTC(usdcAddress), tokenQty, TBTC(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee), this, 8000000000000000000000000000000000000000000000000000000000000000, 0, 0x0000000000000000000000000000000000000004, PERM_HINT);

    return destAmount;
      //uint destAmount = proxy.swapTokenToEther(token, tokenQty, minRate);


    }

     function inchToUniSwapArb(address fromAddress, address uniSwapContract, uint theAmount) public payable onlyOwner returns (bool){

        address theAddress = uniSwapContract;
        UniswapExchangeInterface usi = UniswapExchangeInterface(theAddress);

        TBTC address1 = TBTC(fromAddress);

       uint ethBack = swapTokenToEther1(proxy, address1 , theAmount, msg.sender);

       usi.ethToTokenSwapInput.value(ethBack)(1, block.timestamp);

        return true;
    }


    function () external payable  {

    }



    function withdrawETHAndTokens() onlyOwner{

        msg.sender.send(address(this).balance);
         TBTC usdcToken = TBTC(usdcAddress);
        uint256 currentTokenBalance = usdcToken.balanceOf(this);
        usdcToken.transfer(msg.sender, currentTokenBalance);

    }



    function getInchSellPrice() constant returns (uint256){
       uint256 currentPrice =  liquidity.getExchangeRate("ETH", "USDC", "SELL-Inch-EXCHANGE", 1000000000000000000);
        return currentPrice;
    }


     function getUniswapBuyPrice() constant returns (uint256){
       uint256 currentPrice =  liquidity.getExchangeRate("TBTC", "USDC", "BUY-UNISWAP-EXCHANGE", 1000000000000000000);
        return currentPrice;
    }





}

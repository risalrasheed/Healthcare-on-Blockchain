pragma solidity ^0.4.24;

contract Insuarance {
    
    address owner;
    struct citizen {
        bool isuidgenerated;
        string name;
        uint amountInsuared;
    }
    
    mapping(address=>citizen) public citizenmapping;
    mapping(address=>bool) public doctormapping;
    
    constructor() public {
        owner=msg.sender;
    }
    modifier onlyOwner() {
        require(owner==msg.sender);
        _;
    }
    function setDoctor(address _address) public onlyOwner{
        require(!doctormapping[_address]);
        doctormapping[_address]=true;
    }
    function setCitizenData(string _name, uint _amountInsured) onlyOwner public returns(address) {
        address uniqueid = address(sha256(msg.sender, now));
        require(!citizenmapping[uniqueid].isuidgenerated);
        citizenmapping[uniqueid].isuidgenerated=true;
        citizenmapping[uniqueid].name=_name;
        citizenmapping[uniqueid].amountInsuared=_amountInsured;
        return uniqueid;
    }
    function useInsuarance(address _uniqueid, uint _amountUsed) public returns(string) {
        require(doctormapping[msg.sender]);
        if(citizenmapping[_uniqueid].amountInsuared<=_amountUsed) {
            throw;
        }
        citizenmapping[_uniqueid].amountInsuared-=_amountUsed;
        return "Insuarance has been used successfully";
    }
}

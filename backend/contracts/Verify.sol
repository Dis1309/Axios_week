import './Aadhaar.sol';
import './Structure.sol';
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Verify is Structure{

    mapping (address => policeman) internal police;
    
    event Police(policeman _policeman, string action);
    event aadharVerified(bytes32 _id, address police, string action);

    error AccessDenied(string reason);

     modifier check(policeman memory _policeman) {
    require(bytes(_policeman.name).length != 0 ,"Name needs to be included");
    require(_policeman.dob != 0 ,"Date of birth needs to be included");
    require(bytes(_policeman.stationAddress).length != 0 ,"Station Address needs to be included");
    require(bytes(_policeman.photoId).length != 0 ,"Photo of Id needs to be included");
    _;
    }

    function createPolice(policeman memory _policeman) private check(_policeman)  {
        if(police[msg.sender].dob != 0) revert AccessDenied({reason : "The policeman already exists."});
        police[msg.sender] = _policeman;

        emit Police(_policeman, "Policeman created");
    }

    function getPolice(address _id) public view returns(policeman memory _policeman) {
        if(police[_id].dob == 0) revert AccessDenied({reason : "The policeman doesn't exists."});
         _policeman = police[_id];
    }

    function verify(bytes32 _Aadharid,address _aadharAddress) private check(police[msg.sender]){
        if(police[msg.sender].dob == 0) revert AccessDenied({reason : "The policeman doesn't exists."});
        Aadhaar aadhar = Aadhaar(_aadharAddress);
        aadhar.setVerification(_Aadharid,msg.sender);

        emit aadharVerified(_Aadharid,msg.sender,"Aadhar verified");
    }

}
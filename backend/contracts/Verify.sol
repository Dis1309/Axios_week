import './Aadhaar.sol';
import './Structure.sol';
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
*@title Police Verification
*@author Disha Dwivedi
*@notice Storing policeman data and allowing aadhar cardverification
 */
contract Verify is Structure{

    // Storing the policeman
    mapping (address => policeman) internal police;
    

    // events to notify about the changes
    event Police(policeman  _policeman, string  action);
    event aadharVerified(bytes32 _id, address police, string action);


    // Custom errors to allow notify about the reasons for reverting transaction
    error AccessDenied(string reason);

   
    // modifier to restrict access
     modifier check(policeman memory _policeman) {
    require(bytes(_policeman.name).length != 0 ,"Name needs to be included");
    require(_policeman.dob != 0 ,"Date of birth needs to be included");
    require(bytes(_policeman.stationAddress).length != 0 ,"Station Address needs to be included");
    require(bytes(_policeman.photoId).length != 0 ,"Photo of Id needs to be included");
    _;
    }


/*
*@notice Stores and Registers a policeman
*@param policeman data like name, station address, photoid etc
 */
    function createPolice(policeman memory _policeman) public check(_policeman)  {
        if(police[msg.sender].dob != 0) revert AccessDenied({reason : "The policeman already exists."});
        police[msg.sender] = _policeman;

        emit Police(police[msg.sender], "Policeman created");
    }


/*
*@notice Providing policeman data
*@param address of the policeman
*@return data about the requested policeman like name,id etc 
 */
    function getPolice(address _id) external view returns(policeman memory _policeman) {
        if(police[_id].dob == 0) revert AccessDenied({reason : "The policeman doesn't exists."});
         _policeman = police[_id];
    }


/*
*@notice allows verification of the aadhar data
*@param unique id of Aadhar card being verified and Aadhar contract address for interaction
*@return sets the id to be verified
 */
    function verify(bytes32 _Aadharid,address _aadharAddress) external check(police[msg.sender]){
        Aadhaar aadhar = Aadhaar(_aadharAddress);
        aadhar.setVerification(_Aadharid,msg.sender);

        emit aadharVerified(_Aadharid,msg.sender,"Aadhar verified");
    }

}
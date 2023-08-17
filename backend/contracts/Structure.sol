//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface Structure {
    struct policeman {
        string name;
        uint dob;
        string stationAddress;
        string photoId;
    }
    struct demographicId {
    string  name;
    uint birthDate;
    string  gender;
    string  homeAddress;
    uint mobileNumber;
    string  emailId;
  }
  struct voterdemographicid {
            string name;
            string guardian_name;
            string gender ;
            uint dob ;
            string home_address;
            uint phonenumber;
      }
}
//Baseado em https://medium.com/robhitchens/solidity-crud-part-1-824ffa69509a

pragma solidity 0.5.1;

contract UserCrud {

    struct UserStruct {
        string userEmail;
        uint userAge;
        uint index;
    }

    mapping(address => UserStruct) private userStructs;
    address[] private userIndex;

    function isUser(address userAddress) public view returns(bool isIndeed) {
        if(userIndex.length == 0) return false;
        return (userIndex[userStructs[userAddress].index] == userAddress);
    }

    //Create - Insert
    function insertUser(address userAddress, string memory userEmail, uint userAge) public returns(uint index) {
        require (!isUser(userAddress), "user exists");

        userStructs[userAddress].userEmail = userEmail;
        userStructs[userAddress].userAge = userAge;
        userStructs[userAddress].index = userIndex.push(userAddress)-1;
        return userIndex.length-1;
    }
    
    //Read - Get
    function getUser(address userAddress) public view returns(string memory userEmail, uint userAge, uint index) {
        require (isUser(userAddress), "user not exists");
        return(userStructs[userAddress].userEmail, userStructs[userAddress].userAge, userStructs[userAddress].index);
    }

    function getUserCount() public view returns(uint count) {
        return userIndex.length;
    }

    function getUserAddressAtIndex(uint index) public view returns(address userAddress) {
        return userIndex[index];
    }
    
    //Update
    function updateUserEmail(address userAddress, string memory userEmail) public returns(bool success) {
        require (isUser(userAddress), "user not exists");
        userStructs[userAddress].userEmail = userEmail;
        return true;
    }

    function updateUserAge(address userAddress, uint userAge) public returns(bool success) {
        require (isUser(userAddress), "user not exists");
        userStructs[userAddress].userAge = userAge;
        return true;
    } 
    
    //Delete
    function deleteUser(address userAddress) public returns(uint index) {
        require (isUser(userAddress), "user not exists");
        uint rowToDelete = userStructs[userAddress].index;
        address keyToMove = userIndex[userIndex.length-1];
        userIndex[rowToDelete] = keyToMove;
        userStructs[keyToMove].index = rowToDelete; 
        userIndex.length--;
        return rowToDelete;
    } 
     
}

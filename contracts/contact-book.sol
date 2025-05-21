//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract ContactBook {
    struct Contact {
        string name;
        string phone;
        string email;
        string location;
    }

    mapping(address => mapping(address => Contact)) private contacts;

    event ContactAdded(address indexed user, address indexed walletAddress, string name, string phone, string email, string location);
    event ContactUpdated(address indexed user, address indexed walletAddress, string name, string phone, string email, string location);
    event ContactRemoved(address indexed user, address indexed walletAddress);

    error ContactNotFound(address walletAddress);

    modifier contactExists(address _wallet) {
        if(bytes(contacts[msg.sender][_wallet].name).length == 0) revert ContactNotFound(_wallet);
        _;
    }

    function addContact(
        address _wallet,
        string calldata _name,
        string calldata _phone,
        string calldata _email,
        string calldata _location
    ) external {
        contacts[msg.sender][_wallet] = Contact({
            name: _name,
            phone: _phone,
            email: _email,
            location: _location
        });

        emit ContactAdded(msg.sender, _wallet, _name, _phone, _email, _location);
    }

    function updateContaact(
        address _wallet,
        string calldata _name,
        string calldata _phone,
        string calldata _email,
        string calldata _location
    ) external contactExists(_wallet){
        contacts[msg.sender][_wallet] = Contact({
            name: _name,
            phone: _phone,
            email: _email,
            location: _location
        });

        emit ContactUpdated(msg.sender, _wallet, _name, _phone, _email, _location);
    }

    function removeContact (address _wallet) external contactExists(_wallet) {
        delete contacts[msg.sender][_wallet];

        emit ContactRemoved(msg.sender, _wallet);
    }

    function getContact(address _wallet) external view contactExists(_wallet) returns (Contact memory) {
        return contacts[msg.sender][_wallet];
    }
}
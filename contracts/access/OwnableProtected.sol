// WIP
//
abstract contract OwnableProtected is Ownable {
    function changeOwnerWithPassword(address newOwner, string memory password, bytes32 newPasswordHash) public onlyOwner {
        require(hasPassword(), "No password: Use changeOwner");
        _changePassword(password, newPasswordHash);
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }
    function setPassword(bytes32 newPasswordHash) public isOwner {
        require(hasPassword() == false, "Cannot set password: Use updatePassword");
        passwordHash = newPasswordHash;
    }
    function updatePassword(string memory password, bytes32 newPasswordHash) public isOwner {
        require(hasPassword() == true, "No password: Use setPassword");
        _changePassword(password, newPasswordHash);
    }

    function _changePassword(string memory password, bytes32 newPasswordHash) internal {
        require(passwordHash == hash(password), "Wrong password");
        passwordHash = newPasswordHash;
    }
    function hasPassword() external view returns (bool) {
        return _bytes32 != 0x00;
    }
    function hash(string memory _string) internal pure returns(bytes32) {
        return keccak256(abi.encodePacked(_string));
    }
}

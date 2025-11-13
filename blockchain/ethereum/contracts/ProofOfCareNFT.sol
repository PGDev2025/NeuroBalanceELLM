// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProofOfCareNFT {
    string public name = "ProofOfCareNFT";
    string public symbol = "POCNFT";
    uint256 public nextTokenId;
    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balanceOf;
    mapping(uint256 => address) public getApproved;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    function approve(address to, uint256 tokenId) external {
        address owner = ownerOf[tokenId];
        require(msg.sender == owner, "owner");
        getApproved[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        address owner = ownerOf[tokenId];
        require(owner == from, "owner");
        require(msg.sender == owner || msg.sender == getApproved[tokenId], "approved");
        ownerOf[tokenId] = to;
        balanceOf[from] -= 1;
        balanceOf[to] += 1;
        delete getApproved[tokenId];
        emit Transfer(from, to, tokenId);
    }

    function mint(address to) external returns (uint256) {
        uint256 tokenId = nextTokenId;
        nextTokenId = tokenId + 1;
        ownerOf[tokenId] = to;
        balanceOf[to] += 1;
        emit Transfer(address(0), to, tokenId);
        return tokenId;
    }
}
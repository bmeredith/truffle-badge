// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TruffleBadge is ERC721 {
    constructor() ERC721("TruffleBadge", "TRFL") public {
    }

    function awardBadge(address attendee) public returns (uint256) {
        uint badgeId = 888;
        _mint(attendee, badgeId);
        return badgeId;
    }
}
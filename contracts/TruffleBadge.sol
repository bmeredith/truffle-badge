// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TruffleBadge is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _badgeIdCount;
    
    mapping (address => uint256) public badgeIds;

    constructor() ERC721("TruffleBadge", "TRFL") public {
    }

    function awardBadge(address attendee, string memory attendenceBadgeURI) public returns (uint256) {
        bool hasBadge = _hasBadge(attendee);
        if(hasBadge)
        {
            revert("Only one badge can be awarded per account.");
        }

        uint256 newBadgeId = _badgeIdCount.current();
        _mint(attendee, newBadgeId);
        _setTokenURI(newBadgeId, attendenceBadgeURI);
        _badgeIdCount.increment();

        return newBadgeId;
    }

    function removeBadge(address attendee) public {
        bool hasBadge = _hasBadge(attendee);
        if(!hasBadge)
        {
            return;
        }

        uint256 badge = _getBadge(attendee);
        _burn(badge);
        delete badgeIds[attendee];
        _badgeIdCount.decrement();

        return;
    }

    function _getBadge(address attendee) private view returns (uint256) {
        return badgeIds[attendee];
    }

    function _hasBadge(address attendee) private view returns (bool) {
        return balanceOf(attendee) > 0;
    }
}
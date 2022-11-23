// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockCycle {
    uint256 public lastUpdateBlock;
    uint256 public lastUpdateTimeStamp;
    uint256 public blockCycle;

    constructor() {
        update();
    }

    function update() public returns (uint256, uint256, uint256) {
        uint256 beforeLastUpdateBlock = lastUpdateBlock;
        uint256 beforeLastUpdateTimeStamp = lastUpdateTimeStamp;

        uint256 currentLastUpdateBlock = block.number;
        uint256 currentLastUpdateTimeStamp = block.timestamp;

        if (beforeLastUpdateBlock == currentLastUpdateBlock) {
            return (lastUpdateBlock, lastUpdateTimeStamp, blockCycle);
        }

        uint256 difBlock = currentLastUpdateBlock - beforeLastUpdateBlock;
        uint256 difTimeStamp = currentLastUpdateTimeStamp - beforeLastUpdateTimeStamp;

        uint256 _blockCycle = 86400 * difBlock / difTimeStamp;

        if (blockCycle != _blockCycle) {
            lastUpdateBlock = currentLastUpdateBlock;
            lastUpdateTimeStamp = currentLastUpdateTimeStamp;
            blockCycle = _blockCycle;
        }

        return (lastUpdateBlock, lastUpdateTimeStamp, blockCycle);
    }


    function getTime() public view returns (uint256) {
        return block.timestamp;
    }

    function getBlock() public view returns (uint256) {
        return block.number;
    }
}

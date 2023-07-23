pragma solidity ^0.8.0;
contract VerificationContract {
    bytes32 public S2; // Variable S2 already stored within the blockchain node
    mapping(bytes32 => bytes32) public verificationTable;

    function verifyM2(bytes32 identity, uint256 RNm, bytes32 M1, bytes32 M2, bytes32 challenge, uint256 T) internal pure returns (bool) {
        bytes32 M2start = keccak256(abi.encodePacked(identity, RNm, M1, S2, T));
        return (M2start == M2);
    }
    function calculateAndSendS5S6(uint256 RNm, bytes32 response, uint256 RNg, uint256 T2) internal view returns (bytes32, bytes32, uint256) {
        bytes32 S5 = bytes32(RNm) ^ keccak256(abi.encodePacked(response, RNg, T2));
        bytes32 S6 = keccak256(abi.encodePacked(response, bytes32(RNg), S2, T2));
        return (S5, S6, T2);
    }
    function calculateAndSendS7CsT3(bytes32 R5, bytes32 IDs, bytes32 Rs) external view returns (bytes32, bytes32, uint256) {
        bytes32 RNgXORIDs = bytes32(uint256(R5)) ^ S2 ^ IDs;
        bytes32 R3 = R5 ^ RNgXORIDs;  
        bytes32[] memory allIdentities = new bytes32[](2);
        allIdentities[0] = IDs;
        allIdentities[1] = Rs;
        bytes32[] memory allChallengesResponses = new bytes32[](2);
        allChallengesResponses[0] = verificationTable[IDs];
        allChallengesResponses[1] = verificationTable[Rs];
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, allIdentities))) % 2;
        bytes32 Cs = allChallengesResponses[randomIndex];
        bytes32 RsNew = allIdentities[randomIndex];

        bytes32 Sstar = keccak256(abi.encodePacked(S2, IDs, RNgXORIDs, RsNew, RNm));
        bytes32 T3 = block.timestamp; //new timestamp
        bytes32 S7 = Sstar ^ keccak256(abi.encodePacked(R3));
        return (S7, Cs, T3);
    }
   function verifyAndCalculateS9S10T4T5(bytes32 S8, bytes32 S9, bytes32 IDs, uint256 RNm, uint256 RNg, bytes32 R3, uint256 T4, uint256 T5) external view returns (bytes32, bytes32, uint256, uint256) {
        bytes32 S8part = keccak256(abi.encodePacked(IDs, bytes32(RNg), R3));
        bytes32 S8start = keccak256(abi.encodePacked(bytes32(RNm), IDs, S8part));
        require(S8start == S8, "S8 verification failed");
        bytes32 S10part = keccak256(abi.encodePacked(bytes32(RNm), bytes32(RNg), S2, T5));
        bytes32 S10 = S10part ^ keccak256(abi.encodePacked(IDs, bytes32(RNm)));
        return (S9, S10, T4, T5);
    }
    }
    
}
}

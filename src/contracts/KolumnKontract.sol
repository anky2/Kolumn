// SPDX-License-Identifier: GPL
pragma solidity ^0.8.0;

contract KolumnKontract {
    //Kolumn Structure
    struct Kolumn {
        string title;
        string content;
        uint256 timestamp;
        address payable author;
    }

    uint256 public kolumnKount = 0;
    mapping(uint256 => Kolumn) public kolumns;

    //Add a new Kolumn
    function createKolumn(
        string memory _title,
        string memory _content,
        uint256 _timestamp
    ) public {
        require(msg.sender != address(0x0));
        require(bytes(_title).length * bytes(_content).length > 0);
        kolumnKount++;
        kolumns[kolumnKount] = Kolumn(
            _title,
            _content,
            _timestamp,
            payable(msg.sender)
        );
    }

    //View Kolumn by ID
    function viewKolumn(uint256 _id)
        public
        view
        returns (string memory _title, string memory _content)
    {
        _title = kolumns[_id].title;
        _content = kolumns[_id].content;
    }

    //View Latest Columns
    function viewLatestKolumns()
        public
        view
        returns (Kolumn[] memory latestKolumns)
    {
        for (uint256 i = kolumnKount; i > 0 || i > (kolumnKount - 10); i--) {
            latestKolumns[i] = kolumns[i];
        }
        return latestKolumns;
    }
}

pragma solidity ^0.6.0;

contract StudentMarks{

    struct Student{
        string name;
        uint256 marks;
        string walletAddress;
    }

    Student[] public students;

    string addOfStudent;
    uint256 currentMarks;
    
    mapping(string => string) public nameTOWallet; //address
    
    mapping(string => uint256) walletToMarks;


    function addStudent(string memory _name, string memory _walletAddress, uint256 _marks) public{
        students.push(Student({name: _name, marks: _marks, walletAddress: _walletAddress}));
        nameTOWallet[_name] = _walletAddress;
        walletToMarks[_walletAddress] = _marks;
    }


    function retMarks(string memory _address) public {
        currentMarks =  walletToMarks[_address];
    }

    function retiveMarks() public view returns (uint256){
        return currentMarks;  //marks
    }

    function retMarksByName(string memory studentName) public {
        currentMarks =  walletToMarks[nameTOWallet[studentName]];
    }

    function retiveMarksByName() public view returns (uint256){
        return currentMarks;  //marks
    }

}
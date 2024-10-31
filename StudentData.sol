// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract StudentData {
    // Structure to hold student details
    struct Student {
        uint id;
        string name;
        uint age;
        uint grade;
    }
    
    // Array to store students
    Student[] public students;
    
    // Mapping to store student existence by ID for quick checks
    mapping(uint => bool) private studentExists;

    // Event to notify when a new student is added
    event StudentAdded(uint id, string name, uint age, uint grade);
    
    // Function to add a new student
    function addStudent(uint _id, string memory _name, uint _age, uint _grade) public {
        require(!studentExists[_id], "Student with this ID already exists.");
        students.push(Student(_id, _name, _age, _grade));
        studentExists[_id] = true;
        emit StudentAdded(_id, _name, _age, _grade);
    }
    
    // Function to retrieve a student by ID
    function getStudentById(uint _id) public view returns (string memory name, uint age, uint grade) {
        for (uint i = 0; i < students.length; i++) {
            if (students[i].id == _id) {
                return (students[i].name, students[i].age, students[i].grade);
            }
        }
        revert("Student not found");
    }

    // Fallback function
    fallback() external payable {
        // Fallback can receive ether and can handle unexpected calls
    }

    // Receive function to accept ether transfers
    receive() external payable {}
    
    // Function to check contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

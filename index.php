<?php include 'config.php'; ?>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <h1>Employee Management System</h1>
            </div>
        </div>
    </header>
    
    <div class="container">
        <div class="nav">
            <a href="index.php">Employees</a>
            <a href="loans.php">Loans</a>
            <a href="add_employee.php">Add Employee</a>
            <a href="add_loan.php">Add Loan</a>
        </div>
        
        <div class="card">
            <h2>Employee List</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Salary</th>
                        <th>Age</th>
                        <th>Address</th>
                        <th>Department</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $sql = "SELECT e.*, d.DeptDescription 
                            FROM EmployeeInfo e 
                            LEFT JOIN DepartmentInfo d ON e.DeptCode = d.DeptCode";
                    $result = $conn->query($sql);
                    
                    if ($result->num_rows > 0) {
                        while($row = $result->fetch_assoc()) {
                            echo "<tr>
                                <td>".$row["Eid"]."</td>
                                <td>".$row["Name"]."</td>
                                <td>".$row["Position"]."</td>
                                <td>".$row["Salary"]."</td>
                                <td>".$row["Age"]."</td>
                                <td>".$row["Address"]."</td>
                                <td>".$row["DeptDescription"]."</td>
                              <td class='action-links'>
    <a href='edit_employee.php?id=".$row["Eid"]."' class='btn'>Edit</a> | 
    <a href='delete_employee.php?id=".$row["Eid"]."' class='btn btn-danger' onclick='return confirm(\"Are you sure?\");'>Delete</a>
</td>
                            </tr>";
                        }
                    } else {
                        echo "<tr><td colspan='8' class='empty-message'>No employees found</td></tr>";
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
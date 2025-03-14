<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mc_cab.model.User" %>
<%@ page import="com.mc_cab.dao.UserDAO" %>

<%
    // Initialize UserDAO and fetch all users
    UserDAO userDAO = new UserDAO();
    List<User> userList = userDAO.getAllUsers();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* General Styles */
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2); /* Light gradient background */
            font-family: 'Poppins', sans-serif;
            color: #333; /* Dark text for better readability */
            padding: 20px;
        }

        /* Glass Effect Container */
        .container {
            background: rgba(255, 255, 255, 0.2); /* Semi-transparent white */
            backdrop-filter: blur(15px); /* Blur effect */
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease-in-out;
        }

        /* Glass Effect Table */
        .table {
            background: rgba(255, 255, 255, 0.3); /* Semi-transparent white */
            backdrop-filter: blur(10px); /* Blur effect */
            border-radius: 10px;
            overflow: hidden;
            color: #333; /* Dark text for better readability */
        }

        .table thead th {
            background: rgba(198, 224, 115, 0.4); /* Lighter Lime Green with transparency */
            color: #333; /* Dark text */
            border-color: rgba(255, 255, 255, 0.2); /* Light border */
        }

        .table tbody td {
            background: rgba(255, 255, 255, 0.2); /* Semi-transparent white */
            border-color: rgba(255, 255, 255, 0.2); /* Light border */
        }

        /* Buttons with Glow Effect */
        .btn {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-primary {
            background: rgba(198, 224, 115, 0.9); /* Lighter Lime Green */
            color: #000000; /* Black text */
        }

        .btn-primary:hover {
            background: rgba(198, 224, 115, 1); /* Lighter Lime Green */
            box-shadow: 0 0 15px rgba(198, 224, 115, 0.8); /* Glow effect */
        }

        .btn-warning {
            background: rgba(255, 193, 7, 0.9); /* Yellow */
            color: #000000; /* Black text */
        }

        .btn-warning:hover {
            background: rgba(255, 193, 7, 1); /* Yellow */
            box-shadow: 0 0 15px rgba(255, 193, 7, 0.8); /* Glow effect */
        }

        .btn-danger {
            background: rgba(255, 0, 0, 0.9); /* Red */
            color: #FFFFFF; /* White text */
        }

        .btn-danger:hover {
            background: rgba(255, 0, 0, 1); /* Red */
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.8); /* Glow effect */
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Form Validation */
        .is-invalid {
            border-color: #ff4444 !important;
        }

        .invalid-feedback {
            color: #ff4444;
            font-size: 0.875em;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Manage Customers</h2>

        <!-- User Registration Form -->
        <form id="addUserForm" class="mb-4 row g-3">
            <div class="col-md-4">
                <input type="text" id="name" class="form-control" placeholder="Name" required>
                <div class="invalid-feedback">Please enter a valid name.</div>
            </div>
            <div class="col-md-4">
                <input type="email" id="email" class="form-control" placeholder="Email" required>
                <div class="invalid-feedback">Please enter a valid email.</div>
            </div>
            <div class="col-md-2">
                <input type="text" id="phone" class="form-control" placeholder="Phone" required>
                <div class="invalid-feedback">Please enter a valid phone number.</div>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Add User</button>
            </div>
        </form>

        <!-- Message Container -->
        <div id="messageContainer"></div>

        <!-- User Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="userList">
                <% for (User user : userList) { %>
                <tr id="user_<%= user.getId() %>">
                    <td><%= user.getId() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhone() %></td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editUser(<%= user.getId() %>)">Edit</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteUser(<%= user.getId() %>)">Delete</button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editUserId">
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" id="editName" required>
                        <div class="invalid-feedback">Please enter a valid name.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" required>
                        <div class="invalid-feedback">Please enter a valid email.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" class="form-control" id="editPhone" required>
                        <div class="invalid-feedback">Please enter a valid phone number.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="saveEditUserBtn">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Custom Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function () {
            // Handle adding a new user
            $('#addUserForm').on('submit', function (event) {
                event.preventDefault();
                if (validateForm()) {
                    const name = $('#name').val();
                    const email = $('#email').val();
                    const phone = $('#phone').val();

                    $.ajax({
                        url: '/admin/UserController?action=add',
                        type: 'POST',
                        data: { name: name, email: email, phone: phone },
                        success: function (response) {
                            handleResponse(response, 'add');
                        },
                        error: function () {
                            showMessage('Failed to add user. Please try again.', 'danger');
                        }
                    });
                }
            });

            // Handle saving changes to an existing user
            $('#saveEditUserBtn').on('click', function () {
                if (validateEditForm()) {
                    const userId = $('#editUserId').val();
                    const name = $('#editName').val();
                    const email = $('#editEmail').val();
                    const phone = $('#editPhone').val();

                    $.ajax({
                        url: '/UserController?action=edit',
                        type: 'POST',
                        data: { id: userId, name: name, email: email, phone: phone },
                        success: function (response) {
                            handleResponse(response, 'edit', userId);
                        },
                        error: function () {
                            showMessage('Failed to save changes. Please try again.', 'danger');
                        }
                    });
                }
            });
        });

        // Validate the add user form
        function validateForm() {
            let isValid = true;
            $('#addUserForm input').each(function () {
                if (!$(this).val()) {
                    $(this).addClass('is-invalid');
                    isValid = false;
                } else {
                    $(this).removeClass('is-invalid');
                }
            });
            return isValid;
        }

        // Validate the edit user form
        function validateEditForm() {
            let isValid = true;
            $('#editUserModal input').each(function () {
                if (!$(this).val()) {
                    $(this).addClass('is-invalid');
                    isValid = false;
                } else {
                    $(this).removeClass('is-invalid');
                }
            });
            return isValid;
        }

        // Handle the response for adding/editing users
        function handleResponse(response, action, userId = null) {
            if (response.success) {
                showMessage(response.message, 'success');
                if (action === 'add') {
                    $('#addUserForm')[0].reset();
                    const user = response.user;
                    $('#userList').append(`
                        <tr id="user_${user.id}">
                            <td>${user.id}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="editUser(${user.id})">Edit</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteUser(${user.id})">Delete</button>
                            </td>
                        </tr>
                    `);
                } else if (action === 'edit') {
                    $(`#user_${userId}`).find('td:nth-child(2)').text(response.user.fullName);
                    $(`#user_${userId}`).find('td:nth-child(3)').text(response.user.email);
                    $(`#user_${userId}`).find('td:nth-child(4)').text(response.user.phone);
                    $('#editUserModal').modal('hide');
                }
            } else {
                showMessage(response.message, 'danger');
            }
        }

        // Show a message in the message container
        function showMessage(message, type) {
            $('#messageContainer').html(`<div class="alert alert-${type}">${message}</div>`);
        }

        // Show edit user modal with user details
        function editUser(userId) {
            $.ajax({
                url: '/admin/UserController?action=editForm',
                type: 'GET',
                data: { id: userId },
                success: function (response) {
                    const user = response.user;
                    $('#editUserId').val(user.id);
                    $('#editName').val(user.fullName);
                    $('#editEmail').val(user.email);
                    $('#editPhone').val(user.phone);
                    $('#editUserModal').modal('show');
                },
                error: function () {
                    showMessage('Error loading user details.', 'danger');
                }
            });
        }

        // Confirm and delete a user
        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                $.ajax({
                    url: '/admin/UserController?action=delete',
                    type: 'POST',
                    data: { id: userId },
                    success: function (response) {
                        if (response.success) {
                            $(`#user_${userId}`).remove();
                            showMessage(response.message, 'success');
                        } else {
                            showMessage(response.message, 'danger');
                        }
                    },
                    error: function () {
                        showMessage('Error deleting user.', 'danger');
                    }
                });
            }
        }
    </script>
</body>
</html>
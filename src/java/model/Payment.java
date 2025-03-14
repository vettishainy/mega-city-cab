package com.mc_cab.model;

import java.util.Date;

public class Payment {
    private int id;
    private int bookingId;
    private double amount;
    private String paymentMethod;
    private String status;
    private Date paymentDate;

    // Default constructor
    public Payment() {}

    // Parameterized constructor
    public Payment(int id, int bookingId, double amount, String paymentMethod, String status, Date paymentDate) {
        this.id = id;
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.paymentDate = paymentDate;
    }

    // Getters
    public int getId() { return id; }
    public int getBookingId() { return bookingId; }
    public double getAmount() { return amount; }
    public String getPaymentMethod() { return paymentMethod; }
    public String getStatus() { return status; }
    public Date getPaymentDate() { return paymentDate; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public void setAmount(double amount) { this.amount = amount; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public void setStatus(String status) { this.status = status; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }

    // Override toString() for debugging
    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", bookingId=" + bookingId +
                ", amount=" + amount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", status='" + status + '\'' +
                ", paymentDate=" + paymentDate +
                '}';
    }
}

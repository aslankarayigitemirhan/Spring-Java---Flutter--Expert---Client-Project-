package com.easoft.model;

import java.time.LocalDate;

public class WrapperClientLocalDate {
    private LocalDate localDate;
    private Client client;

    public WrapperClientLocalDate(LocalDate localDate, Client client) {
        this.localDate = localDate;
        this.client = client;
    }

    public WrapperClientLocalDate() {
    }

    public LocalDate getLocalDate() {
        return localDate;
    }

    public void setLocalDate(LocalDate localDate) {
        this.localDate = localDate;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }
}

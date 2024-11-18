package com.easoft.model;

public class ExpertClientWrapper {
    private Expert expert;
    private Client client;

    public ExpertClientWrapper(Expert expert, Client client) {
        this.expert = expert;
        this.client = client;
    }

    public ExpertClientWrapper() {
    }

    // Getters and setters
    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }
}


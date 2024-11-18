package com.easoft.model;

public class ClientString {
    Client client;

    String dailyNoteID;

    public ClientString(Client client, String dailyNoteID) {
        this.client = client;
        this.dailyNoteID = dailyNoteID;
    }

    public ClientString() {
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public String getDailyNoteID() {
        return dailyNoteID;
    }

    public void setDailyNoteID(String dailyNoteID) {
        this.dailyNoteID = dailyNoteID;
    }
}

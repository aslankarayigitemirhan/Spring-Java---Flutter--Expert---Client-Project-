package com.easoft.model;

public class WrapperClientDNotesMessage {
    Client client;
    DailyNote dailyNote;
    String message;

    public WrapperClientDNotesMessage(Client client, DailyNote dailyNote, String message) {
        this.client = client;
        this.dailyNote = dailyNote;
        this.message = message;
    }

    public WrapperClientDNotesMessage() {
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public DailyNote getDailyNote() {
        return dailyNote;
    }

    public void setDailyNote(DailyNote dailyNote) {
        this.dailyNote = dailyNote;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}

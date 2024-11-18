package com.easoft.model;

public class WrapperDailyNoteClient {
    private Client client;
    private String message;

    public WrapperDailyNoteClient() {
    }

    public WrapperDailyNoteClient(Client client, DailyNote dailyNote, String message) {
        this.client = client;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public WrapperDailyNoteClient(Client client, DailyNote dailyNote) {
        this.client = client;
        this.message = dailyNote.getText();
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }


}

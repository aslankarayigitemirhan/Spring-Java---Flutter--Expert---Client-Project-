package com.easoft.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "dailyNotes")
public class DailyNote {

    @Column(name = "date")
    private LocalDate date;
    @Id
    @Column(name = "dailyNoteID")
    private String dailynoteID;
    @ManyToOne
    @JsonIgnore
    private Client client;
    @Column(name = "text")
    private String text;
    @Column(name = "AI_comment")//provided by AI
    private String analyzer;

    public DailyNote(Client client) {
        this.date = LocalDate.now();
        this.client = client;
        this.dailynoteID = UUID.randomUUID().toString();
    }

    public DailyNote() {
        this.date = LocalDate.now();
        this.dailynoteID = UUID.randomUUID().toString();
    }

    public String getDailynoteID() {
        return dailynoteID;
    }

    public void setDailynoteID(String dailynoteID) {
        this.dailynoteID = dailynoteID;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getAnalyzer() {
        return analyzer;
    }

    public void setAnalyzer(String analyzer) {
        this.analyzer = analyzer;
    }
}

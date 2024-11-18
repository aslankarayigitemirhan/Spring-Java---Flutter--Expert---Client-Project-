package com.easoft.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "clients")
public class Client {
    @Id
    @Column(name = "username")
    private String username;
    @Column(name = "firstName")
    private String firstName;
    @Column(name = "lastName")
    private String lastName;

    @ManyToOne
    @JsonIgnore
    private Expert expert;
    @Column(name = "password")
    private String password;

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @OneToMany(mappedBy = "client")
    private List<DailyNote> notes;

    public Client(String firstName, String lastName, String username, String password) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.username = username;
        this.password = password;
        this.notes = new ArrayList<>();
    }

    public Client() {
    }

    public List<DailyNote> getNotes() {
        return notes;
    }

    public void setNotes(List<DailyNote> notes) {
        this.notes = notes;
    }

    //Editting to note as method:editMyNote(DailyNote dailyNote, String newText)
    public DailyNote editMyNote(DailyNote dailyNote, String newText) {
        for (int i = 0; i < this.notes.size(); i++) {
            if (this.notes.get(i) == (DailyNote) dailyNote) {
                this.notes.get(i).setText(newText);
                this.notes.get(i).setDate(LocalDate.now());
                return this.notes.get(i);
            }
        }
        return null;
    }

    public DailyNote createDailyNote() {
        DailyNote dailyNote = new DailyNote(this);
        this.notes.add(dailyNote);
        return dailyNote;

    }

    public DailyNote deleteDailyNote(DailyNote dailyNote) {
        for (int i = 0; i < this.notes.size(); i++) {
            if ((DailyNote) dailyNote == this.notes.get(i)) {
                return this.notes.remove(i);
            }
        }
        return null;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("RESULTS : \n");
        for (DailyNote dailyNote : this.notes) {
            sb.append(dailyNote.getAnalyzer() + "\n");
        }
        return sb.toString();
    }
}


package com.easoft.service;

import com.easoft.model.Client;
import com.easoft.model.DailyNote;

import java.time.LocalDate;
import java.util.List;

public interface IDailyNoteService {
    public DailyNote getDailyNote(Client client, LocalDate localDate);
    public DailyNote deleteDailyNote(Client client, String dailyNote);
    public DailyNote createDailyNote(Client client);
    public DailyNote editMyNote(Client client,DailyNote dailyNote, String newText);
}

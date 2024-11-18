package com.easoft.service.implementation;

import com.easoft.model.Client;
import com.easoft.model.DailyNote;
import com.easoft.repository.ClientRepository;
import com.easoft.repository.DailyNoteRepository;
import com.easoft.repository.ExpertRepository;
import com.easoft.service.IDailyNoteService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class DailyNoteService implements IDailyNoteService{
    @Autowired
    private ClientRepository clientRepository;
    @Autowired
    private ExpertRepository expertRepository;
    @Autowired
    private DailyNoteRepository dailyNoteRepository;
    @Override
    public DailyNote getDailyNote(Client client, LocalDate localDate) {
        List<DailyNote> dailyNotes = this.dailyNoteRepository.findAll();
        for(DailyNote dailyNote : dailyNotes){
            if(dailyNote.getClient().getUsername().equals(client.getUsername())&& dailyNote.getDate().equals(localDate)){
                return this.dailyNoteRepository.findById(dailyNote.getDailynoteID()).get();
            }
        }
        return null;
    }
    @Override
    public DailyNote deleteDailyNote(Client client, String dailyNote) {
        DailyNote dailyNote1 = this.dailyNoteRepository.findById(dailyNote).get();
        this.dailyNoteRepository.delete(dailyNote1);
        return dailyNote1;
    }
    @Override
    public DailyNote createDailyNote(Client client) {
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        DailyNote dailyNote = new DailyNote(client1);
        //olusturugum zamanki tarihi alacak...
        client1.getNotes().add(dailyNote);
        this.dailyNoteRepository.save(dailyNote);
        return dailyNote;
    }

    @Override
    @Transactional
    public DailyNote editMyNote(Client client, DailyNote dailyNote, String message) {
        Optional<Client> client1 = this.clientRepository.findById(client.getUsername());
        Optional<DailyNote> dailyNote1 = this.dailyNoteRepository.findById(dailyNote.getDailynoteID());
        if(dailyNote1.isPresent()){
            System.out.println(dailyNote1.get().getText());
            dailyNote1.get().setText(message);
            return this.dailyNoteRepository.save(dailyNote1.get());
        }
        return null;
    }
}

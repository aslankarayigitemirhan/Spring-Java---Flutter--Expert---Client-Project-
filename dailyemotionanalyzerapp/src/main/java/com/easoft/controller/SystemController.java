package com.easoft.controller;

import com.easoft.model.*;
import com.easoft.service.implementation.ClientService;
import com.easoft.service.implementation.DailyNoteService;
import com.easoft.service.implementation.ExpertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
@RequestMapping(path = "/appapi")
public class SystemController {
    @Autowired
    ClientService clientService;
    @Autowired
    DailyNoteService dailyNoteService;
    @Autowired
    ExpertService expertService;

    //-----------------------------------------------------------------CLIENT
    @DeleteMapping(path = "/deleteClient")
    public void deleteClient(@RequestBody Client client) {
        this.clientService.deleteClient(client);
    }

    @PostMapping(path = "/saveClient")
    public Client saveClient(@RequestBody Client client) {
        return this.clientService.saveClient(client);
    }

    @PutMapping(path = "/request")
    public void request(@RequestBody ExpertClientWrapper wrapper) {
        Expert expert = wrapper.getExpert();
        Client client = wrapper.getClient();
        this.clientService.request(client, expert);
    }

    public boolean validateClient(Client client) {
        return this.clientService.validateClient(client);
    }


    @PostMapping(path = "/logIn/client")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Client client) {
        Map<String, Object> response = new HashMap<>();

        if (this.validateClient(client)) {
            Client authenticatedExpert = this.clientService.getClient(client);

            // Başarılı yanıt
            response.put("success", true);
            response.put("username", authenticatedExpert.getUsername());
            response.put("password", authenticatedExpert.getPassword());
            response.put("firstName" ,authenticatedExpert.getFirstName());
            response.put("lastName",authenticatedExpert.getLastName());
            return ResponseEntity.ok(response);
        } else {
            // Başarısız yanıt
            response.put("success", false);
            response.put("message", "Hatalı kullanıcı adı veya şifre");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
    }
//-----------------------------------------------------------------EXPERT

    @PostMapping(path = "/getMyClients")
    public List<Client> getMyClients(@RequestBody Expert expert){
        return this.expertService.getMyClients(expert);
    }

    @PutMapping(path = "/breakUpClient")
    public Client breakUpClients(@RequestBody ExpertClientWrapper expertClientWrapper) {
        Expert expert = expertClientWrapper.getExpert();
        Client client = expertClientWrapper.getClient();
        return this.expertService.deleteResponsibility(expert, client);
    }


    @DeleteMapping(path = "deleteExpert")
    public Expert deleteExpert(@RequestBody Expert expert) {
        return this.expertService.deleteExpert(expert);
    }

    @PostMapping(path = "/saveExpert")
    public Expert saveExpert(@RequestBody Expert expert) {
        return this.expertService.saveExpert(expert);
    }


    public boolean validateExpert(Expert expert) {
        return this.expertService.validateExpert(expert);
    }


    @PostMapping(value = "/logIn/expert")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Expert expert) {
        Map<String, Object> response = new HashMap<>();

        if (this.validateExpert(expert)) {
            Expert authenticatedExpert = this.expertService.getExpert(expert);

            // Başarılı yanıt
            response.put("success", true);
            response.put("username", authenticatedExpert.getUsername());
            response.put("password", authenticatedExpert.getPassword());
            response.put("firstName" ,authenticatedExpert.getFirstName());
            response.put("lastName",authenticatedExpert.getLastName());
            response.put("branch", authenticatedExpert.getBranch());
            return ResponseEntity.ok(response);
        } else {
            // Başarısız yanıt
            response.put("success", false);
            response.put("message", "Hatalı kullanıcı adı veya şifre");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
    }
    @PutMapping(path = "/acceptClient")
    public void getAnswerForAcceptingClient(@RequestBody ExpertClientWrapper expertClientWrapper){
        Expert expert = expertClientWrapper.getExpert();
        Client client = expertClientWrapper.getClient();
        this.expertService.getAnswerForAcceptingClient(client,expert);
    }
    @PostMapping(path = "/getFollowRequests")
    public List<Client> getFollowRequests(@RequestBody Expert expert){
        return this.expertService.getFollowRequests(expert);
    }
    //-----------------------------------------------------------------DailyNote

    @GetMapping(path = "/getDailyNote")
    public DailyNote getDailyNote(@RequestBody WrapperClientLocalDate wrapperClientLocalDate) {
        Client client = wrapperClientLocalDate.getClient();
        LocalDate localDate = wrapperClientLocalDate.getLocalDate();
        return this.dailyNoteService.getDailyNote(client, localDate);
    }

    @PostMapping(path = "/getAllNotes")
    public List<DailyNote> getAllNotes(@RequestBody Client client){
        return this.expertService.getAllNotes(client);
    }

    @PutMapping(path = "/editNote")
    public DailyNote editNote(@RequestBody WrapperClientDNotesMessage wrapperClientDNotesMessage){
        DailyNote dailyNote = wrapperClientDNotesMessage.getDailyNote();
        Client client = wrapperClientDNotesMessage.getClient();
        String message = wrapperClientDNotesMessage.getMessage();

        return this.dailyNoteService.editMyNote(client,dailyNote,message);
    }

    @PutMapping(path = "/createNote")
    public DailyNote createNote(@RequestBody WrapperDailyNoteClient wrapperDailyNoteClient) {

        Client client = wrapperDailyNoteClient.getClient();
        Client client1 = this.clientService.getClient(client);

        DailyNote dailyNote = createDailyNote(client1);
        String message = wrapperDailyNoteClient.getMessage();
        return this.dailyNoteService.editMyNote(client1, dailyNote, message);
    }
    public DailyNote createDailyNote(@RequestBody Client client) {
        return this.dailyNoteService.createDailyNote(client);
    }


    @DeleteMapping(path = "/deleteDailyNote")
    public DailyNote deleteDailyNote(@RequestBody ClientString clientString) {
        Client client1 = this.clientService.getClient(clientString.getClient());

        return this.dailyNoteService.deleteDailyNote(client1, clientString.getDailyNoteID());
    }
    @GetMapping(path = "/getAllExperts")
    public List<Expert> getAllExperts(){
        return this.expertService.getAllExperts();
    }
    //---------------------------------------ortak
}

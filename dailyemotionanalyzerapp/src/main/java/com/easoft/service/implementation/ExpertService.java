package com.easoft.service.implementation;

import com.easoft.model.Client;
import com.easoft.model.DailyNote;
import com.easoft.model.Expert;
import com.easoft.repository.ClientRepository;
import com.easoft.repository.DailyNoteRepository;
import com.easoft.repository.ExpertRepository;
import com.easoft.service.IExpertService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExpertService implements IExpertService {
    @Autowired
    private ClientRepository clientRepository;
    @Autowired
    private ExpertRepository expertRepository;
    @Autowired
    private DailyNoteRepository dailyNoteRepository;
    @Transactional
    public void getAnswerForAcceptingClient(Client client,Expert expert){
        //Requestler arasından gezinerek ilgili client bulunursa kabul edilecek..
        //Yeşil buton Expert danışan sayfasında gözükecek..kabul butonu
        //Sorumluluk istegi gelecek ve danışman isterse kabul edecek...
        Expert expert1 = this.expertRepository.findById(expert.getUsername()).get();
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        if (expert1.getFollowedClientCurrently().contains(client1)) {
return;        }
        List<Client> tempRequestList = new ArrayList<>(expert1.getRequestForClient());
        for (Client reqClient : tempRequestList) {
            if (reqClient.getUsername().equals(client1.getUsername())) {
                expert1.getFollowedClientCurrently().add(client1);
                expert1.getRequestForClient().remove(client1);
                client1.setExpert(expert1);
                break;
            }
        }

    }

    
@Transactional
    public Client deleteResponsibility(Expert expert,Client client) {
        Expert expert1 = this.expertRepository.findById(expert.getUsername()).get();
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        return expert1.deleteResponsibility(client1);
    }


    public Expert deleteExpert(Expert expert) {
        Expert expert1 = this.expertRepository.findById(expert.getUsername()).get();
        this.expertRepository.delete(expert1);
        return expert1;
    }


    public Expert saveExpert(Expert expert) {
        return this.expertRepository.save(expert);
    }

    public Expert getExpert(Expert expert){
        return this.expertRepository.findById(expert.getUsername()).get();
    }
    public boolean validateExpert(Expert expert) {
        //Database içerisinden arar..
        //Bulursa true döner...
        //Password içerebilir.
        for(Expert expert1 : this.expertRepository.findAll()){
            if(expert1.getUsername().equals(expert.getUsername()) && expert1.getPassword().equals(expert.getPassword())){
                return true;
            }
        }
        return false;
    }
    public List<DailyNote> getAllNotes(Client client){
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        return client1.getNotes();
    }
    public List<Client> getMyClients( Expert expert){
        return this.expertRepository.findById(expert.getUsername()).orElseThrow().getFollowedClientCurrently();
    }
    public List<Expert> getAllExperts(){
        return this.expertRepository.findAll();
    }
    public List<Client> getFollowRequests(Expert expert){
        Expert expert1 = this.expertRepository.findById(expert.getUsername()).get();
        return expert1.getRequestForClient();
    }
}

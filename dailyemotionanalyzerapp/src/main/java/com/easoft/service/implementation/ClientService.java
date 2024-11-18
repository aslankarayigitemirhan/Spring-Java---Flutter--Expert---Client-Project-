package com.easoft.service.implementation;

import com.easoft.model.Client;
import com.easoft.model.DailyNote;
import com.easoft.model.Expert;
import com.easoft.repository.ClientRepository;
import com.easoft.repository.DailyNoteRepository;
import com.easoft.repository.ExpertRepository;
import com.easoft.service.IClientService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClientService implements IClientService {
    @Autowired
    private ClientRepository clientRepository;
    @Autowired
    private ExpertRepository expertRepository;
    @Autowired
    private DailyNoteRepository dailyNoteRepository;

    @Override
    public void deleteClient(Client client) {
        //Database 'deki client ....
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        this.clientRepository.delete(client1);
        //Database 'deki clientin experti ....
        Expert expert = this.expertRepository.findById(client.getExpert().getUsername()).get();
        if(expert != null){
            expert.deleteResponsibility(client1);
        }

        //DailyRepo Temizlemesi
        for (DailyNote dailyNote : client1.getNotes()) {
            this.dailyNoteRepository.delete(dailyNote);
        }

    }
    @Transactional
    public void request(Client client, Expert expert) {
        Expert expert1 = this.expertRepository.findById(expert.getUsername()).get();
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        List<Client> expertList= expert1.getRequestForClient();
        expertList.add(client1);
        return;
    }

    @Override
    public Client saveClient(Client client) {
        return this.clientRepository.save(client);
    }

    @Override
    public boolean validateClient(Client client) {
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        if(client1 != null && client1.getPassword().equals(client.getPassword())){
            return true;
        }
        return false;
    }

    @Override
    public Client getClient(Client client) {
        Client client1 = this.clientRepository.findById(client.getUsername()).get();
        if (client1 != null) {
            return client1;
        } else {
            return null;
        }
    }
}

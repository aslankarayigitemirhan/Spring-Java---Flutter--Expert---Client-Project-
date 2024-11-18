package com.easoft.service;

import com.easoft.model.Client;


public interface IClientService {
    public void deleteClient(Client client);
    public Client saveClient(Client client);
    public boolean validateClient(Client client);
    public Client getClient(Client client);
}

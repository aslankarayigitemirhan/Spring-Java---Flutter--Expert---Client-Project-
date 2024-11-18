package com.easoft.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;
@Entity
@Table(name = "experts")
public class Expert{
    @Id
    @Column(name = "username")
    private String username;
    @Column(name = "password")
    private String password;
    @Column(name = "firstName")
    private String firstName;
    @Column(name = "lastName")
    private String lastName;
    @Column(name = "branch")
    private String branch;
    @OneToMany
    @JoinTable(
            name = "followed_clients",
            joinColumns = @JoinColumn(name = "expert_username"),
            inverseJoinColumns = @JoinColumn(name = "client_username")
    )    private List<Client> followedClientCurrently;
    @OneToMany
    @JoinTable(
            name = "requested_clients",
            joinColumns = @JoinColumn(name = "expert_username"),
            inverseJoinColumns = @JoinColumn(name = "client_username")
    )
    private List<Client> requestForClient;
    public Expert(String firstName, String lastName, String username, String password,String branch) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.password = password;
        this.branch = branch;
        this.followedClientCurrently = new ArrayList<>();
        this.requestForClient = new ArrayList<>();
    }

    public List<Client> getRequestForClient() {
        return requestForClient;
    }

    public void setRequestForClient(List<Client> requestForClient) {
        this.requestForClient = requestForClient;
    }

    public Expert() {
        this.followedClientCurrently = new ArrayList<>();
        this.requestForClient = new ArrayList<>();
    }

    public Client acceptClient(Client client){
        this.followedClientCurrently.add(client);
        return client;
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

    public Client deleteResponsibility(Client client){
        for(int i = 0; i < this.followedClientCurrently.size(); i++){
            if(this.followedClientCurrently.get(i).getUsername().equals(client.getUsername())){
                client.setExpert(null);
                return this.followedClientCurrently.remove(i);

            }
        }return null;
    }
    public List<DailyNote> showResults(Client client){
        for(int i = 0 ; i < this.followedClientCurrently.size(); i++){
            if((Client) client == this.followedClientCurrently.get(i)){
                return this.followedClientCurrently.get(i).getNotes();
            }
        }
        return null;
    }

    public List<Client> getFollowedClientCurrently() {
        return followedClientCurrently;
    }

    public void setFollowedClientCurrently(List<Client> followedClientCurrently) {
        this.followedClientCurrently = followedClientCurrently;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
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
}

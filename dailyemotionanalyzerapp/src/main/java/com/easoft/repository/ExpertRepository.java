package com.easoft.repository;

import com.easoft.model.Client;
import com.easoft.model.Expert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExpertRepository extends JpaRepository<Expert,String> {

}

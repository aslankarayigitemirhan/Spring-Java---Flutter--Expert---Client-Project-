package com.easoft.repository;

import com.easoft.model.Client;
import com.easoft.model.DailyNote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
@Repository
public interface DailyNoteRepository extends JpaRepository<DailyNote, String> {
}

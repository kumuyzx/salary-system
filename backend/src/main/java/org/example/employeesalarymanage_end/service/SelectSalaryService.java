package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SelectSalaryService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> selectSalary(String start, String end, String id) {
        String sql = String.format("call getRecordsBetweenDatesById(%s,'%s','%s')", id, start, end);
        return jdbcTemplate.queryForList(sql);
    }
}

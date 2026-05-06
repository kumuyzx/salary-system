package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class ResetPasswordService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void reset(String id) {
        String sql = String.format("call SetDefaultPassword('%s')", id);
        jdbcTemplate.execute(sql);
    }
}

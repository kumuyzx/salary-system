package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EditEmployeeService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void edit(String id, String name, String sex, String phone, String email, String password) {
        String sql = String.format("CALL UpdateEmployeeInfo('%s', '%s', '%s', '%s', '%s', '%s')", id, name, sex, phone, email, password);
        jdbcTemplate.execute(sql);
    }
}

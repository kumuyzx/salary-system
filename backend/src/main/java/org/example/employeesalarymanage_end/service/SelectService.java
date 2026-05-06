package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SelectService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> selectEmployee(String key) {
        String sql = "SELECT * FROM employee WHERE id = '" + key + "'";
        List<Map<String, Object>> data = jdbcTemplate.queryForList(sql);
        return data;
    }
}

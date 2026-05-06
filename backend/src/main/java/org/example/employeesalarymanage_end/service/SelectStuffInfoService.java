package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SelectStuffInfoService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> selectInfo(String id) {
        String sql = String.format("CALL GetEmployeeInfoById('%s')", id);
        return jdbcTemplate.queryForList(sql);
    }
}

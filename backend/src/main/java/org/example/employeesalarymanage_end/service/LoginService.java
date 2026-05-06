package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class LoginService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> login(String id, String pass) {
        String sql = "select * from employee where id = '"+id+"' and password = '"+pass+"'";
        List<Map<String, Object>> data = jdbcTemplate.queryForList(sql);
        System.out.println(data);
        return data;
    }
}

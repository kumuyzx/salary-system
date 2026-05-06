package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SelectStuffBonusService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> selectBonus(String year) {
        String sql = String.format("call CalculateYearlyBonus('%s')", year);
        return jdbcTemplate.queryForList(sql);
    }
}

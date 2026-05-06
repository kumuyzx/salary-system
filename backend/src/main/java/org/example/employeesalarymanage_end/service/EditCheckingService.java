package org.example.employeesalarymanage_end.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class EditCheckingService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void edit(String month, String id, String over_hours, String weekend_overtime, String holiday_overtime, String leave_day, String late_day, String early_leave) {
        String sql = String.format("CALL UpdateCheckingIn('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')", month, id, over_hours, weekend_overtime, holiday_overtime, leave_day, late_day, early_leave);
        jdbcTemplate.execute(sql);
    }
}

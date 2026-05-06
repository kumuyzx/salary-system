package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.EditCheckingService;
import org.example.employeesalarymanage_end.service.EditEmployeeService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/edit")
public class EditCheckingController {
    @Resource
    private EditCheckingService editCheckingService;

    @PostMapping("/editChecking")
    public void loginToSystem(@RequestBody JSONObject jsonObject) {
        String month = jsonObject.getString("month");
        String id = jsonObject.getString("id");
        String over_hours = jsonObject.getString("over_hours");
        String weekend_overtime = jsonObject.getString("weekend_overtime");
        String holiday_overtime = jsonObject.getString("holiday_overtime");
        String leave_day = jsonObject.getString("leave_day");
        String late_day = jsonObject.getString("late_day");
        String early_leave = jsonObject.getString("early_leave");
        editCheckingService.edit(month, id, over_hours, weekend_overtime, holiday_overtime, leave_day, late_day, early_leave);
    }
}

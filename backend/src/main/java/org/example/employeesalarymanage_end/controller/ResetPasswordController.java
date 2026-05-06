package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.EditEmployeeService;
import org.example.employeesalarymanage_end.service.ResetPasswordService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/edit")
public class ResetPasswordController {
    @Resource
    private ResetPasswordService resetPasswordService;

    @PostMapping("/resetPassword")
    public void loginToSystem(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        resetPasswordService.reset(id);
    }
}

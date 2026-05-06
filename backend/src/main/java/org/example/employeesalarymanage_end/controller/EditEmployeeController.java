package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.EditEmployeeService;
import org.example.employeesalarymanage_end.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/edit")
public class EditEmployeeController {
    @Resource
    private EditEmployeeService editEmployeeService;

    @PostMapping("/editEmployee")
    public void loginToSystem(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        String name = jsonObject.getString("name");
        String sex = jsonObject.getString("sex");
        String phone = jsonObject.getString("phone");
        String email = jsonObject.getString("email");
        String password = jsonObject.getString("password");
        editEmployeeService.edit(id, name, sex, phone, email, password);
    }
}

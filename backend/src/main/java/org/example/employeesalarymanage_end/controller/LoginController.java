package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.LoginService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/login")
public class LoginController {
    @Resource
    private LoginService loginService;

    @PostMapping("/loginToSystem")
    public List<Map<String, Object>> loginToSystem(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        String pass = jsonObject.getString("pass");
        return loginService.login(id, pass);
    }
}

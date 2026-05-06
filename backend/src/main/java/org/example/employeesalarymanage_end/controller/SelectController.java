package org.example.employeesalarymanage_end.controller;


import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.SelectService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/select")
public class SelectController {
    @Resource
    private SelectService selectService;

    @PostMapping("/selectEmployee")
    public List<Map<String, Object>> selectEmployee(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        return selectService.selectEmployee(id);
    }
}

package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.SelectSalaryService;
import org.example.employeesalarymanage_end.service.SelectStuffSalaryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/select")
public class SelectStuffSalaryController {
    @Resource
    private SelectStuffSalaryService selectStuffSalaryService;

    @PostMapping("/selectStuffSalary")
    public List<Map<String, Object>> selectSalary(@RequestBody JSONObject jsonObject) {
        String start = jsonObject.getString("start");
        String end = jsonObject.getString("end");
        return selectStuffSalaryService.selectSalary(start, end);
    }
}

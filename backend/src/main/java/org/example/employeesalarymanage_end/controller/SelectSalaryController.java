package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.SelectSalaryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/select")
public class SelectSalaryController {
    @Resource
    private SelectSalaryService selectSalaryService;

    @PostMapping("/selectSalary")
    public List<Map<String, Object>> selectEmployee(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        String start = jsonObject.getString("start");
        String end = jsonObject.getString("end");
        return selectSalaryService.selectSalary(start, end, id);
    }
}

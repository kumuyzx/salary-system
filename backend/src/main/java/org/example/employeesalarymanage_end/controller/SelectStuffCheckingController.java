package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.SelectStuffCheckingService;
import org.example.employeesalarymanage_end.service.SelectStuffInfoService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/select")
public class SelectStuffCheckingController {
    @Resource
    private SelectStuffCheckingService selectStuffCheckingService;

    @PostMapping("/selectStuffChecking")
    public List<Map<String, Object>> selectChecking(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        return selectStuffCheckingService.selectChecking(id);
    }
}

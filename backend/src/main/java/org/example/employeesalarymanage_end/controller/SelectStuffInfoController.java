package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.SelectStuffInfoService;
import org.example.employeesalarymanage_end.service.SelectStuffSalaryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/select")
public class SelectStuffInfoController {
    @Resource
    private SelectStuffInfoService selectStuffInfoService;

    @PostMapping("/selectStuffInfo")
    public List<Map<String, Object>> selectInfo(@RequestBody JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        return selectStuffInfoService.selectInfo(id);
    }
}

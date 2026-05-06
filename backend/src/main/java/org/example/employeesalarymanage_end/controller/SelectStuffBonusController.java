package org.example.employeesalarymanage_end.controller;

import com.alibaba.fastjson.JSONObject;
import jakarta.annotation.Resource;
import org.example.employeesalarymanage_end.service.SelectStuffBonusService;
import org.example.employeesalarymanage_end.service.SelectStuffSalaryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/select")
public class SelectStuffBonusController {
    @Resource
    private SelectStuffBonusService selectStuffBonusService;

    @PostMapping("/selectStuffBonus")
    public List<Map<String, Object>> selectBonus(@RequestBody JSONObject jsonObject) {
        String year = jsonObject.getString("year");
        return selectStuffBonusService.selectBonus(year);
    }
}

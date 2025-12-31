package com.team2.dbbuddy.controller;

import com.team2.dbbuddy.service.SampleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/samples")
@RequiredArgsConstructor
public class SampleController {

    private final SampleService sampleService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("samples", sampleService.getAllSamples());
        return "sample/list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Integer id, Model model) {
        model.addAttribute("sample", sampleService.getSampleById(id));
        return "sample/detail";
    }

    // Add Create, Update, Delete methods as needed for the GUI
}

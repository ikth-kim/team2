package com.team2.dbbuddy.service;

import com.team2.dbbuddy.dto.SampleDTO;
import com.team2.dbbuddy.mapper.SampleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SampleService {

    private final SampleMapper sampleMapper;

    @Transactional(readOnly = true)
    public List<SampleDTO> getAllSamples() {
        return sampleMapper.findAll();
    }

    @Transactional(readOnly = true)
    public SampleDTO getSampleById(Integer id) {
        return sampleMapper.findById(id);
    }

    @Transactional
    public void createSample(SampleDTO sampleDTO) {
        sampleMapper.save(sampleDTO);
    }

    @Transactional
    public void updateSample(SampleDTO sampleDTO) {
        sampleMapper.update(sampleDTO);
    }

    @Transactional
    public void deleteSample(Integer id) {
        sampleMapper.delete(id);
    }
}

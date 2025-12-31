package com.team2.dbbuddy.mapper;

import com.team2.dbbuddy.dto.SampleDTO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface SampleMapper {
    List<SampleDTO> findAll();

    SampleDTO findById(Integer id);

    int save(SampleDTO sampleDTO);

    int update(SampleDTO sampleDTO);

    int delete(Integer id);
}

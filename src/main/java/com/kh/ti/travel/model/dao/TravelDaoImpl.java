package com.kh.ti.travel.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.member.model.vo.Member;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;
import com.kh.ti.travel.model.vo.Place;
import com.kh.ti.travel.model.vo.SchFile;
import com.kh.ti.travel.model.vo.Tag;
import com.kh.ti.travel.model.vo.Travel;
import com.kh.ti.travel.model.vo.TrvCity;
import com.kh.ti.travel.model.vo.TrvCost;
import com.kh.ti.travel.model.vo.TrvDay;
import com.kh.ti.travel.model.vo.TrvSchedule;
import com.kh.ti.travel.model.vo.TrvTag;

@Repository
public class TravelDaoImpl implements TravelDao {

	@Override
	public ArrayList<Travel> selectTrvList(SqlSessionTemplate sqlSession, int memberId) {
		return (ArrayList)sqlSession.selectList("Travel.selectTrvList", memberId);
	}
	
	@Override
	public int insertTravel(SqlSessionTemplate sqlSession, Travel trv) {
		return sqlSession.insert("Travel.insertTravel", trv);
	}
	@Override
	public int selectTrvId(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Travel.selectTrvId");
	}
	@Override
	public City selectCity(SqlSessionTemplate sqlSession, int cityId) {
		return sqlSession.selectOne("Travel.selectCity", cityId);
	}	
	@Override
	public int insertTrvCity(SqlSessionTemplate sqlSession, TrvCity trvCity) {
		return sqlSession.insert("Travel.insertTrvCity", trvCity);
	}
	@Override
	public int insertTrvDay(SqlSessionTemplate sqlSession, TrvDay trvDay) {
		return sqlSession.insert("Travel.insertTrvDay", trvDay);
	}
	@Override
	public Travel selectTravel(SqlSessionTemplate sqlSession, int trvId) {
		return sqlSession.selectOne("Travel.selectTravel", trvId);
	}
	@Override
	public ArrayList<TrvCity> selectTrvCityList(SqlSessionTemplate sqlSession, int trvId) {
		return (ArrayList)sqlSession.selectList("Travel.selectTrvCityList", trvId);
	}
	@Override
	public ArrayList<TrvDay> selectTrvDayList(SqlSessionTemplate sqlSession, int trvId) {
		return (ArrayList)sqlSession.selectList("Travel.selectTrvDayList", trvId);
	}

	@Override
	public ArrayList<Country> selectCountryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("Travel.selectCountryList");
	}
	@Override
	public ArrayList<City> selectCityList(SqlSessionTemplate sqlSession, int countryId) {
		return (ArrayList)sqlSession.selectList("Travel.selectCityList", countryId);
	}
	@Override
	public ArrayList<Tag> selectTagList(SqlSessionTemplate sqlSession) {
		return(ArrayList)sqlSession.selectList("Travel.selectAllTagList");
	}
	
	@Override
	public int updateTravel(SqlSessionTemplate sqlSession, Travel trv) {
		return sqlSession.update("Travel.updateTravel", trv);
	}
	@Override
	public int deleteTrvCity(SqlSessionTemplate sqlSession, TrvCity trvCity) {
		return sqlSession.delete("Travel.deleteTrvCity", trvCity);
	}
	@Override
	public int updateTrvDay(SqlSessionTemplate sqlSession, TrvDay trvDay) {
		return sqlSession.update("Travel.updateTrvDay", trvDay);
	}
	@Override
	public int deleteTrvDay(SqlSessionTemplate sqlSession, TrvDay trvDay) {
		return sqlSession.delete("Travel.deleteTrvDay", trvDay);
	}
	

	@Override
	public int completeTravel(SqlSessionTemplate sqlSession, int trvId) {
		return sqlSession.update("Travel.completeTravel", trvId);
	}	

	@Override
	public int deleteTravel(SqlSessionTemplate sqlSession, int trvId) {
		return sqlSession.update("Travel.deleteTravel", trvId);
	}
	
	
	@Override
	public int selectSchCount(SqlSessionTemplate sqlSession, int dayId) {
		return sqlSession.selectOne("Travel.selectSchCount", dayId);
	}
	
	@Override
	public ArrayList<TrvSchedule> selectSchList(SqlSessionTemplate sqlSession, int dayId) {
		return (ArrayList)sqlSession.selectList("Travel.selectSchList", dayId);
	}
	
	@Override
	public int insertTrvSchedule(SqlSessionTemplate sqlSession, TrvSchedule sch) {
		return sqlSession.insert("Travel.insertSch", sch);
	}
		
	@Override
	public int selectSchId(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Travel.selectSchId");
	}
	
	@Override
	public int updateSchNumber(SqlSessionTemplate sqlSession, TrvSchedule sch) {
		return sqlSession.update("Travel.updateSchNumber", sch);
	}
	
	@Override
	public int insertTrvCost(SqlSessionTemplate sqlSession, TrvCost cost) {
		return sqlSession.insert("Travel.insertTrvCost", cost);
	}
	
	@Override
	public TrvCost selectTrvCost(SqlSessionTemplate sqlSession, int schId) {
		return sqlSession.selectOne("Travel.selectTrvCost", schId);
	}
	@Override
	public int updateTrvCost(SqlSessionTemplate sqlSession, TrvCost cost) {
		return sqlSession.update("Travel.updateTrvCost", cost);
	}
	@Override
	public int deleteTrvCost(SqlSessionTemplate sqlSession, TrvCost cost) {
		return sqlSession.delete("Travel.deleteTrvCost", cost);
	}
	
	@Override
	public TrvSchedule selectTrvSchedule(SqlSessionTemplate sqlSession, int schId) {
		return sqlSession.selectOne("Travel.selectSch", schId);
	}
	
	@Override
	public int updateTrvSchedule(SqlSessionTemplate sqlSession, TrvSchedule sch) {
		return sqlSession.update("Travel.updateSch", sch);
	}
	
	@Override
	public int deleteTrvSchedule(SqlSessionTemplate sqlSession, int schId) {
		return sqlSession.delete("Travel.deleteSch", schId);
	}

	@Override
	public int updateTrvDayMemo(SqlSessionTemplate sqlSession, TrvDay trvDay) {
		return sqlSession.update("Travel.updateTrvDayMemo", trvDay);
	}



	
	
	
	
	
	
	
	



//	@Override
//	public int insertPlace(SqlSessionTemplate sqlSession, Place plc) {
//		/* return sqlSession.insert("Travel.insertTrvPlace"); */
//		return 0;
//	}
//	@Override
//	public int selectPlcId(SqlSessionTemplate sqlSession) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
	
	
	
	@Override
	public int updateSchPlcId(SqlSessionTemplate sqlSession, TrvSchedule sch) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	
	@Override
	public int insertTag(SqlSessionTemplate sqlSession, TrvTag trvTag) {
		return sqlSession.insert("Travel.insertTrvTag", trvTag);
	}

	@Override
	public int deleteTrvTag(SqlSessionTemplate sqlSession, TrvTag trvTag) {
		return sqlSession.delete("Travel.deleteTrvTag", trvTag);
	}
	
	@Override
	public ArrayList<TrvTag> selectTrvTagList(SqlSessionTemplate sqlSession, int trvId) {
		return (ArrayList)sqlSession.selectList("Travel.selectTrvTagList", trvId);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@Override
	public int insertTrvCompany(SqlSessionTemplate sqlSession, Travel trv, Member m) {
		// TODO Auto-generated method stub
		return 0;
	}




	@Override
	public int insertTrvCost(SqlSessionTemplate sqlSession, Travel trv, TrvCost cost) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSchFile(SqlSessionTemplate sqlSession, SchFile schFile) {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public ArrayList selectAllSchList(SqlSessionTemplate sqlSession, Travel trv, int day) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public HashMap selectSpotList(SqlSessionTemplate sqlSession, Travel trv, int cityId) {
		// TODO Auto-generated method stub
		return null;
	}




	@Override
	public int deleteTrvComp(SqlSessionTemplate sqlSession, Travel trv, int memberId) {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int deleteSchFile(SqlSessionTemplate sqlSession, SchFile file) {
		// TODO Auto-generated method stub
		return 0;
	}





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

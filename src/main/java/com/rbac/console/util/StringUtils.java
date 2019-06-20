package com.rbac.console.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StringUtils {
	protected static final Logger LOGGER = LoggerFactory.getLogger(StringUtils.class);
	
	public static boolean isNull(String param){
		boolean result = false;
		if(param == null  || param.trim().equals("")){
			result = true;
		}
		return result;
	}
	
	public static boolean isNull(Object param){
		boolean result = false;
		if(param == null ){
			result = true;
		}
		return result;
	}
	

	public static boolean isNull(String... paramOtherString) {
		boolean result = false;
		for (String string : paramOtherString) {
			if ((string == null) || (string.trim().equals(""))) {
				result = true;
				break;
			}
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public static<T> List<T> strToList(String param, String... splitParam){
		List<T> resultList = null;
		if(isNull(param)){
			LOGGER.error("字符串转换Json失败：传入的字符串为空");
			return resultList;
		}
		resultList = new ArrayList<T>();
		if(splitParam.length < 1){
			resultList = (List<T>) Arrays.asList(param.split(","));
		}else{
			resultList = (List<T>) Arrays.asList(param.split(splitParam[0]));
		}
		return resultList;
	}
	

	public static String getNotNull(String param){
		if(param==null || param.trim().length()==0)
			return "";
		return param;
	}
	
	public static int getInt(String sSrc,int iDefault){
		int iReturn = iDefault;
		if(sSrc==null||sSrc.trim().equals(""))
		{
			return iDefault;
		}
		else
		{
			try
			{
				iReturn = Integer.parseInt(sSrc);
			}
			catch(Exception e)
			{
				iReturn = iDefault;
			}
			return iReturn;
		}			
	}
}

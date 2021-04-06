package com.rbac.console.util;

import org.springframework.util.ObjectUtils;


public class EmptyUtil {

    @SuppressWarnings("rawtypes")
    public static boolean isEmpty(Object obj) {
        //null
        if (obj == null) {
            return true;
        }
        //String
        if (obj instanceof String) {
            return ((String) obj).trim().equals("");
        }
        //Others
        return  ObjectUtils.isEmpty(obj);

    }
    public static boolean isNotEmpty(Object obj) {
        return !isEmpty(obj);
    }
}

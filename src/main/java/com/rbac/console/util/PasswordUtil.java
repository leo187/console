package com.rbac.console.util;

import java.util.Random;
public class PasswordUtil {

	/**
	 * 
	 */
	public PasswordUtil() {
		super();
	}
	public static void main(String[] args) throws Exception
	{
		String s = getRandomPassword(8);
		System.out.println(s);
		System.out.println(encrypt("1"));
	}
	
	public static String encrypt(String _src) throws Exception
	{
		return _src;
	}
	
	public static String getRandomPassword(int len) 
	{
        if (len < 8)
        {
            len = 8;
        }
        Random rand = new Random();
        StringBuffer sb = new StringBuffer(len);
        //48-57	0-9
        //65-90	A-Z
        //97-122	a-z
        int i = 0;
        while(i<len)
        {
            int b = rand.nextInt(127);
            if(b>47&&b<58)
            {
            	sb.append((char) b);
            	i++;
            	continue;
            }
            else if(b>64&&b<91)
            {
            	sb.append((char) b);
            	i++;
            	continue;
            }
            else if(b>96&&b<123)
            {
            	sb.append((char) b);
            	i++;
            	continue;
            }
            else
            {
            	continue;
            }

        }
        String random = sb.toString();
        return random.toLowerCase();
    }
}
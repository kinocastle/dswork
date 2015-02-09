package common.auth;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

public class AuthPassport
{
	private static Map<Long, String> mapEp = new HashMap<Long, String>();
	private static Map<Long, String> mapPerson = new HashMap<Long, String>();
	private static Timer _timer = null;
	
	static
	{
		TimerTask _timerTask = new TimerTask()
		{
			public void run()
			{
				System.out.println("--清理找回密码任务启动。--");
				try
				{
					long now = java.util.Calendar.getInstance().getTimeInMillis();//取得当前时间
					if(mapEp.size() > 0)
					{
						//清空超时的记录
						for(Map.Entry<Long, String> entry: mapEp.entrySet())
						{
							if(entry.getKey() < now)
							{
								mapEp.put(entry.getKey(), null);
							}
						}
					}
					if(mapPerson.size() > 0)
					{
						//清空超时的记录
						for(Map.Entry<Long, String> entry: mapPerson.entrySet())
						{
							if(entry.getKey() < now)
							{
								mapPerson.put(entry.getKey(), null);
							}
						}
					}
				}
				catch(Exception ex)
				{
					System.out.println("--清理找回密码任务程序异常。--");
				}
			}
		};
		_timer = new Timer(true);
		_timer.schedule(_timerTask, 0, 3600000);// 从服务器启动开始运行,每period毫秒执行
		System.out.println("--清理找回密码任务执行间隔3600000毫秒。--");
	}
	
	public static String addAccountEp(String account)
	{
		Long code = java.util.Calendar.getInstance().getTimeInMillis() + 1800000;
		mapEp.put(code, account.toLowerCase());
		return "ep" + code;
	}
	public static String getAccountEp(String code)
	{
		String account = mapEp.get(Long.parseLong(code));
		return account == null ? "" : account;
	}
	public static void clearAccountEp(Long code)
	{
		mapEp.put(code, null);
	}
	
	public static String addAccountPerson(String account)
	{
		Long code = java.util.Calendar.getInstance().getTimeInMillis() + 1800000;
		mapPerson.put(code, account.toLowerCase());
		return "" + code;
	}
	public static String getAccountPerson(String code)
	{
		String account = mapPerson.get(Long.parseLong(code));
		return account == null ? "" : account;
	}
	public static void clearAccountPerson(Long code)
	{
		mapPerson.put(code, null);
	}
	

}

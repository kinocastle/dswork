/**
 * 应用系统Model
 */
package dswork.base.model;

public class DsBaseSystem
{
	// 主键
	private Long id = 0L;
	// 名称
	private String name = "";
	// 系统标识
	private String alias = "";
	// 访问密码
	private String password = "";
	// 备注
	private String memo = "";
	// 网络地址和端口
	private String domainurl = "";
	// 应用根路径
	private String rooturl = "";
	// 菜单路径
	private String menuurl = "";
	// 状态(1启用,0禁用)
	private Integer status = 1;

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getId()
	{
		return this.id;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getName()
	{
		return this.name;
	}

	public void setAlias(String alias)
	{
		this.alias = String.valueOf(alias).trim();
	}

	public String getAlias()
	{
		return this.alias;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public void setMemo(String memo)
	{
		this.memo = memo;
	}

	public String getMemo()
	{
		return this.memo;
	}

	public void setDomainurl(String domainurl)
	{
		this.domainurl = domainurl;
	}

	public String getDomainurl()
	{
		return this.domainurl;
	}

	public void setRooturl(String rooturl)
	{
		this.rooturl = rooturl;
	}

	public String getRooturl()
	{
		return this.rooturl;
	}

	public String getMenuurl()
	{
		return menuurl;
	}

	public void setMenuurl(String menuurl)
	{
		this.menuurl = menuurl;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = (status == null || status.intValue() != 1) ? 0 : 1;
	}

	@Override
	public String toString()
	{
		try
		{
			return new StringBuilder().append("{\"id\":").append(id).append(",\"pid\":-1,\"isParent\":true,\"status\":").append(status).append(",\"name\":\"").append(name.replaceAll("\\\\", "\\\\\\\\").replaceAll("\"", "\\\\\\\"")).append("\"}").toString();
		}
		catch(Exception e)
		{
			return "{\"id\":0,\"pid\":-1,\"isParent\":true,\"status\":0,\"name\":\"\"}";
		}
	}
}

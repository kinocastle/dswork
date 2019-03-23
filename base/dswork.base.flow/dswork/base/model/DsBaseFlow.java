/**
 * 流程Model
 */
package dswork.base.model;

import java.util.ArrayList;
import java.util.List;

public class DsBaseFlow
{
	// 主键
	private Long id = 0L;
	// 分类
	private Long categoryid = 0L;
	// 流程标识
	private String alias = "";
	// 内部版本0为编辑版本
	private Integer vnum = 0;
	// 流程发布ID，VNUM为0的放最新版本
	private String deployid = "";
	// 名字
	private String name = "";
	// 状态(1启用,0禁用)
	private Integer status = 0;
	// 流程图配置XML
	private String flowxml = "";
	// 数据结构
	private String datatable = "";
	// 数据视图
	private String dataview = "";
	private List<DsBaseFlowTask> taskList = null;

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getCategoryid()
	{
		return categoryid;
	}

	public void setCategoryid(Long categoryid)
	{
		this.categoryid = categoryid;
	}

	public String getAlias()
	{
		return alias;
	}

	public void setAlias(String alias)
	{
		this.alias = alias;
	}

	public Integer getVnum()
	{
		return vnum;
	}

	public void setVnum(Integer vnum)
	{
		this.vnum = vnum;
	}

	public String getDeployid()
	{
		return deployid;
	}

	public void setDeployid(String deployid)
	{
		this.deployid = deployid;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public String getFlowxml()
	{
		return flowxml;
	}

	public void setFlowxml(String flowxml)
	{
		this.flowxml = flowxml;
	}

	public String getDatatable()
	{
		return datatable;
	}

	public void setDatatable(String datatable)
	{
		this.datatable = datatable;
	}

	public String getDataview()
	{
		return dataview;
	}

	public void setDataview(String dataview)
	{
		this.dataview = dataview;
	}

	public List<DsBaseFlowTask> getTaskList()
	{
		if (taskList == null)
		{
			return new ArrayList<DsBaseFlowTask>();
		}
		return taskList;
	}

	public void setTaskList(List<DsBaseFlowTask> taskList)
	{
		this.taskList = taskList;
	}
}

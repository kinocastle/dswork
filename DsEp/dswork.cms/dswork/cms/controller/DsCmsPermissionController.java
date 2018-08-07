package dswork.cms.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dswork.cms.model.DsCmsCategory;
import dswork.cms.model.DsCmsCategoryEdit;
import dswork.cms.model.DsCmsPermission;
import dswork.cms.model.DsCmsSite;
import dswork.cms.service.DsCmsPermissionService;
import dswork.core.page.Page;
import dswork.core.page.PageNav;
import dswork.core.page.PageRequest;
import dswork.core.util.UniqueId;

@Scope("prototype")
@Controller
@RequestMapping("/cms/permission")
public class DsCmsPermissionController extends DsCmsBaseController
{
	@Autowired
	private DsCmsPermissionService service;

	// 获取用户分页
	@RequestMapping("getUser")
	public String getUser()
	{
		try
		{
			PageRequest pr = getPageRequest();
			pr.getFilters().put("own", getOwn());
			Page<Map<String, Object>> pageModel = service.queryPageUser(pr);
			put("pageModel", pageModel);
			put("pageNav", new PageNav<Map<String, Object>>(request, pageModel));
			return "/cms/permission/getUser.jsp";
		}
		catch(Exception e)
		{
		}
		return null;
	}

	// 用户权限
	@RequestMapping("/updPermission1")
	public String updPermission1()
	{
		try
		{
			long siteid = req.getLong("siteid", -1);
			String account = req.getString("account", null);
			if(account == null)
			{
				return null;
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("siteid", siteid);
			map.put("own", getOwn());
			List<DsCmsSite> siteList = service.queryListSite(map);
			List<DsCmsCategory> categoryList = null;
			if(siteList != null && siteList.size() > 0)
			{
				if(siteid == -1)
				{
					siteid = siteList.get(0).getId();
				}
				categoryList = service.queryListCategory(siteid);
			}
			DsCmsPermission permission = service.get(siteid, account);
			if(permission == null)
			{
				permission = new DsCmsPermission();
			}
			put("permission", permission);
			put("siteid", siteid);
			put("siteList", siteList == null ? new ArrayList<DsCmsSite>() : siteList);
			put("categoryList", categorySetting(categoryList == null ? new ArrayList<DsCmsCategory>() : categoryList));
			return "/cms/permission/updPermission.jsp";
		}
		catch(Exception e)
		{
			return null;
		}
	}

	@RequestMapping("/updPermission2")
	public void updPermission2()
	{
		try
		{
			String account = req.getString("account", null);
			Long siteid = req.getLong("siteid", -1);
			if(account == null || siteid == -1)
			{
				print("0:参数错误");
				return;
			}
			DsCmsPermission po = service.get(siteid, account);
			if(po == null)
			{
				po = new DsCmsPermission();
				po.setId(UniqueId.genId());
				po.setSiteid(siteid);
				po.setAccount(account);
			}

			String msg = "";
			String audit_old = po.getAudit();
			String audit_new = req.getString("audit", "");
			if(audit_old.length() > 2)
			{
				Set<String> set = new HashSet<String>(Arrays.asList(audit_old.split(",")));
				set.removeAll(Arrays.asList(audit_new.split(",")));
				set.remove("");
				if(set.size() > 0)
				{
					List<DsCmsPermission> list = service.queryListPermission(siteid);
					for(DsCmsPermission p : list)
					{
						if(!p.getAccount().equals(po.getAccount()))
						{
							set.removeAll(Arrays.asList(p.getAudit().split(",")));
						}
					}
					if(set.size() > 0)
					{
						List<Long> idList = new ArrayList<Long>();
						for(String s : set)
						{
							long id = Long.parseLong(s);
							DsCmsCategory c = service.getCategory(id);
							if(c.getScope() == 0)
							{
								Map<String, Object> map = new HashMap<String, Object>();
								map.put("categoryid", c.getId());
								map.put("auditstatus", 1);// 状态为审核中的
								if(service.queryCountPageEdit(map) > 0)
								{
									idList.add(c.getId());
									continue;
								}
							}
							DsCmsCategoryEdit _c = service.getCategoryEdit(c.getId());
							if(_c != null && _c.isAudit())
							{
								idList.add(_c.getId());
							}
						}
						if(idList.size() > 0)
						{
							for(long id : idList)
							{
								msg += id + ",";
								audit_new += id + ",";
							}
							msg += "栏目正在由该用户审核，不能取消";
						}
					}
				}
			}
			po.setAudit(audit_new);
			po.setEditall(req.getString("editall", ""));
			po.setEditown(req.getString("editown", ""));
			po.setPublish(req.getString("publish", ""));
			service.save(po);
			print(msg.length() > 0 ? "2:" + msg : 1);
		}
		catch(Exception e)
		{
			print("0:" + e.getMessage());
		}
	}

	// 获得栏目列表
	@RequestMapping("/getCategory")
	public String getCategory()
	{
		try
		{
			long siteid = req.getLong("siteid", -1);
			List<DsCmsCategory> list = null;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("own", getOwn());
			List<DsCmsSite> siteList = service.queryListSite(map);
			if(siteList != null && siteList.size() > 0)
			{
				for(DsCmsSite s : siteList)
				{
					if(s.getId() == siteid)
					{
						list = service.queryListCategory(siteid);
						break;
					}
				}
				if(list == null)
				{
					siteid = siteList.get(0).getId();
					list = service.queryListCategory(siteid);
				}
			}
			put("siteid", siteid);
			put("siteList", siteList);
			put("list", categorySetting(list == null ? new ArrayList<DsCmsCategory>() : list));
			put("sitePermission", getSitePermission(siteid));
			return "/cms/permission/getCategory.jsp";
		}
		catch(Exception e)
		{
		}
		return null;
	}
}

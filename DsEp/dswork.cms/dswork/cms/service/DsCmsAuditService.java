/**
 * 采编审核Service
 */
package dswork.cms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dswork.cms.dao.DsCmsAuditCategoryDao;
import dswork.cms.dao.DsCmsLogDao;
import dswork.cms.dao.DsCmsAuditPageDao;
import dswork.cms.dao.DsCmsCategoryDao;
import dswork.cms.dao.DsCmsPageDao;
import dswork.cms.dao.DsCmsPermissionDao;
import dswork.cms.dao.DsCmsSiteDao;
import dswork.cms.model.DsCmsAuditCategory;
import dswork.cms.model.DsCmsLog;
import dswork.cms.model.DsCmsAuditPage;
import dswork.cms.model.DsCmsCategory;
import dswork.cms.model.DsCmsPage;
import dswork.cms.model.DsCmsPermission;
import dswork.cms.model.DsCmsSite;
import dswork.core.page.Page;
import dswork.core.page.PageRequest;
import dswork.core.util.UniqueId;

@Service
public class DsCmsAuditService
{
	@Autowired
	private DsCmsAuditPageDao auditPageDao;
	@Autowired
	private DsCmsAuditCategoryDao auditCategoryDao;
	@Autowired
	private DsCmsLogDao logDao;
	@Autowired
	private DsCmsPermissionDao permissionDao;
	@Autowired
	private DsCmsPageDao pageDao;
	@Autowired
	private DsCmsCategoryDao categoryDao;
	@Autowired
	private DsCmsSiteDao siteDao;

	public DsCmsSite getSite(Long siteid)
	{
		return (DsCmsSite) siteDao.get(siteid);
	}

	public DsCmsCategory getCategory(Long categoryid)
	{
		return (DsCmsCategory) categoryDao.get(categoryid);
	}

	public List<DsCmsSite> queryListSite(Map<String, Object> map)
	{
		return permissionDao.queryListSite(map);
	}

	@SuppressWarnings("unchecked")
	public List<DsCmsCategory> queryListCategory(Long siteid)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("siteid", siteid);
		return categoryDao.queryList(map);
	}

	public DsCmsPermission getPermission(Long siteid, String account)
	{
		return permissionDao.get(siteid, account);
	}

	public DsCmsAuditPage getPage(Long pageid)
	{
		return (DsCmsAuditPage) pageDao.get(pageid);
	}

	public DsCmsAuditCategory saveAuditCategory(Long id)
	{
		DsCmsAuditCategory po = new DsCmsAuditCategory();
		DsCmsCategory _po = (DsCmsCategory) categoryDao.get(id);
		if(_po.getScope() != 0) // 非列表
		{
			po.setId(_po.getId());
			po.setSiteid(_po.getSiteid());
			po.setSummary(_po.getSummary());
			po.setMetakeywords(_po.getMetakeywords());
			po.setMetadescription(_po.getMetadescription());
			po.setReleasesource(_po.getReleasesource());
			po.setReleaseuser(_po.getReleaseuser());
			po.setImg(_po.getImg());
			po.setContent(_po.getContent());
			po.setReleasetime(_po.getReleasetime());
			po.setUrl(_po.getUrl());
			po.setAuditstatus(DsCmsAuditCategory.EDIT);// 草稿
			po.setStatus(0);// 初始设置为新增状态
			auditCategoryDao.save(po);
		}
		return po;
	}

	public DsCmsAuditCategory getAuditCategory(Long id)
	{
		return (DsCmsAuditCategory) auditCategoryDao.get(id);
	}

	public int updateAuditCategory(DsCmsAuditCategory po, DsCmsCategory cate, boolean isEnablelog)
	{
		if(po.isPass())// 通过
		{
			if(cate.getScope() == 1)
			{
				cate.setSummary(po.getSummary());
				cate.setMetakeywords(po.getMetakeywords());
				cate.setMetadescription(po.getMetadescription());
				cate.setReleasesource(po.getReleasesource());
				cate.setReleaseuser(po.getReleaseuser());
				cate.setImg(po.getImg());
				cate.setContent(po.getContent());
				cate.setReleasetime(po.getReleasetime());
				if(cate.getStatus() != 0)
				{
					cate.setStatus(1);
				}
				categoryDao.updateContent(cate);
			}
			else
			{
				cate.setUrl(po.getUrl());
				cate.setStatus(8);// 更改至已发布状态（因为外链不需要发布操作）
				categoryDao.update(cate);
			}
			po.setStatus(1);// 审核栏目设置为修改状态
		}
		if(isEnablelog)
		{
			writeLogCategory(po);
		}
		return auditCategoryDao.update(po);
	}

	public int updateAuditPage(DsCmsAuditPage po, boolean isEnablelog)
	{
		if(po.isPass())// 通过
		{
			DsCmsPage page = (DsCmsPage) pageDao.get(po.getId());
			boolean isSave = false;
			if(page == null)
			{
				page = new DsCmsPage();
				page.setId(po.getId());
				isSave = true;
			}
			page.setSiteid(po.getSiteid());
			page.setCategoryid(po.getCategoryid());
			page.setStatus(po.getStatus());
			page.setTitle(po.getTitle());
			page.setMetakeywords(po.getMetakeywords());
			page.setMetadescription(po.getMetadescription());
			page.setSummary(po.getSummary());
			page.setContent(po.getContent());
			page.setReleasetime(po.getReleasetime());
			page.setReleasesource(po.getReleasesource());
			page.setReleaseuser(po.getReleaseuser());
			page.setImg(po.getImg());
			page.setImgtop(po.getImgtop());
			page.setPagetop(po.getPagetop());
			page.setScope(po.getScope());
			if(isSave)
			{
				page.setStatus(0);// 内容设置为新建未发布状态
				pageDao.save(page);
				pageDao.updateURL(po.getId(), po.getUrl());
			}
			else
			{
				if(page.getStatus() != 0)
				{
					page.setStatus(1);// 更新至更新未发布状态
				}
				pageDao.update(page);
			}
			po.setStatus(1);// 审核内容设置为修改状态
		}
		if(isEnablelog)
		{
			writeLogPage(po);
		}
		return auditPageDao.update(po);
	}

	public int deleteAuditPage(DsCmsAuditPage po, boolean isEnablelog)
	{
		if(po.isPass())// 通过
		{
			DsCmsPage page = (DsCmsPage) pageDao.get(po.getId());
			if(page != null)
			{
				page.setStatus(-1);
				pageDao.update(page);
			}
			auditPageDao.delete(po.getId());
		}
		else
		{
			po.setStatus(1);// 更新为修改状态
			auditPageDao.update(po);
		}
		if(isEnablelog)
		{
			writeLogPage(po);
		}
		return 1;
	}

	public DsCmsAuditPage getAuditPage(Long id)
	{
		return (DsCmsAuditPage) auditPageDao.get(id);
	}

	@SuppressWarnings("unchecked")
	public Page<DsCmsAuditPage> queryPageAuditPage(PageRequest pr)
	{
		return auditPageDao.queryPage(pr);
	}

	private void writeLogPage(DsCmsAuditPage po)
	{
		try
		{
			DsCmsLog log = new DsCmsLog();
			log.setId(UniqueId.genId());
			log.setSiteid(po.getSiteid());
			log.setCategoryid(po.getCategoryid());
			log.setPageid(po.getId());
			log.setAuditid(po.getAuditid());
			log.setAuditmsg(po.getMsg());
			log.setAuditname(po.getAuditname());
			log.setAudittime(po.getAudittime());
			log.setStatus(po.getStatus());
			log.setAuditstatus(po.getAuditstatus());
			log.setTitle(po.getTitle());
			log.setScope(po.getScope());
			log.setUrl(po.getUrl());
			log.setMetakeywords(po.getMetakeywords());
			log.setMetadescription(po.getMetadescription());
			log.setSummary(po.getSummary());
			log.setReleasetime(po.getReleasetime());
			log.setReleasesource(po.getReleasesource());
			log.setReleaseuser(po.getReleaseuser());
			log.setImg(po.getImg());
			log.setContent(po.getContent());
			log.setImgtop(po.getImgtop());
			log.setPagetop(po.getPagetop());
			logDao.save(log);
		}
		catch(Exception e)
		{
		}
	}

	private void writeLogCategory(DsCmsAuditCategory po)
	{
		try
		{
			DsCmsLog log = new DsCmsLog();
			log.setId(UniqueId.genId());
			log.setSiteid(po.getSiteid());
			log.setCategoryid(po.getId());
			log.setAuditid(po.getAuditid());
			log.setAuditmsg(po.getMsg());
			log.setAuditname(po.getAuditname());
			log.setAudittime(po.getAudittime());
			log.setStatus(po.getStatus());
			log.setAuditstatus(po.getAuditstatus());
			log.setTitle(po.getName());
			log.setScope(po.getScope());
			log.setUrl(po.getUrl());
			log.setMetakeywords(po.getMetakeywords());
			log.setMetadescription(po.getMetadescription());
			log.setSummary(po.getSummary());
			log.setReleasetime(po.getReleasetime());
			log.setReleasesource(po.getReleasesource());
			log.setReleaseuser(po.getReleaseuser());
			log.setImg(po.getImg());
			log.setContent(po.getContent());
			logDao.save(log);
		}
		catch(Exception e)
		{
		}
	}
}
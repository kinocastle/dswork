/**
 * 栏目Service
 */
package dswork.cms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dswork.cms.dao.DsCmsCategoryDao;
import dswork.cms.dao.DsCmsCategoryEditDao;
import dswork.cms.dao.DsCmsPageDao;
import dswork.cms.dao.DsCmsPageEditDao;
import dswork.cms.dao.DsCmsSiteDao;
import dswork.cms.model.DsCmsCategory;
import dswork.cms.model.DsCmsCategoryEdit;
import dswork.cms.model.DsCmsPage;
import dswork.cms.model.DsCmsPageEdit;
import dswork.cms.model.DsCmsSite;
import dswork.core.db.BaseService;
import dswork.core.db.EntityDao;
import dswork.core.page.Page;
import dswork.core.page.PageRequest;

@Service
@SuppressWarnings("all")
public class DsCmsCategoryService extends BaseService<DsCmsCategory, Long>
{
	@Autowired
	private DsCmsCategoryDao dao;
	@Autowired
	private DsCmsSiteDao siteDao;
	@Autowired
	private DsCmsPageDao pageDao;
	@Autowired
	private DsCmsPageEditDao pageEditDao;
	@Autowired
	private DsCmsCategoryEditDao categoryEditDao;

	@Override
	protected EntityDao getEntityDao()
	{
		return dao;
	}

	@Override
	public int save(DsCmsCategory po)
	{
		dao.save(po);
		if(po.getScope() != 2)
		{
			po.setUrl("/a/" + po.getId() + "/index.html");
			dao.update(po);
		}
		return 1;
	}

	@Override
	public int update(DsCmsCategory po)
	{
		if(po.getScope() != 2)
		{
			po.setUrl("/a/" + po.getId() + "/index.html");
		}
		dao.update(po);
		dao.updateScope(po);
		return 1;
	}

	@Override
	@Deprecated
	public void deleteBatch(Long[] primaryKeys)
	{
	}

	/**
	 * 更新排序
	 * @param ids 主键数组
	 * @param seqArr 排序位置数组
	 * @param siteid 站点ID
	 */
	public void updateSeq(long[] idArr, int[] seqArr, long siteid)
	{
		for(int i = 0; i < idArr.length && i < seqArr.length; i++)
		{
			dao.updateSeq(idArr[i], seqArr[i], siteid);
		}
	}

	/**
	 * 获得节点的子节点个数
	 * @param pid 上级栏目主键
	 * @return int
	 */
	public int getCountByPid(long pid)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pid", pid);
		return dao.queryCount(new PageRequest(map));
	}

	/**
	 * 获得栏目节点的内容数量
	 * @param siteid 站点主键
	 * @param categoryid 栏目主键
	 * @return int
	 */
	public int getCountByCategoryid(long siteid, long categoryid)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("siteid", siteid);
		map.put("categoryid", categoryid);
		return pageDao.queryCount(new PageRequest(map));
	}

	public DsCmsSite getSite(Long siteid)
	{
		return (DsCmsSite) siteDao.get(siteid);
	}

	public List<DsCmsSite> queryListSite(Map<String, Object> map)
	{
		return siteDao.queryList(map);
	}

	public List<DsCmsCategory> queryListByPid(long pid)
	{
		return dao.queryListByPid(pid);
	}

	public void updateRecycled(List<DsCmsCategory> list)
	{
		for(DsCmsCategory c : list)
		{
			if(c.getScope() == 1)
			{
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("categoryid", c.getId());
				List<DsCmsPage> plist = pageDao.queryList(map);
				for(DsCmsPage p : plist)
				{
					// 以DsCmsPage表的状态为基准，保证DsCmsPage和DsCmsPageEdit是一致的
					if(p.getStatus() == -1)
					{
						pageDao.delete(p.getId());
						pageEditDao.delete(p.getId());
					}
					else
					{
						pageDao.updateStatus(p.getId(), 0);
						DsCmsPageEdit pe = (DsCmsPageEdit) pageEditDao.get(p.getId());
						// 防止因两表数据可能不一致而产生NPE
						if(pe != null)
						{
							pe.setStatus(0);
							pe.setAuditstatus(DsCmsCategoryEdit.EDIT);
							pageEditDao.update(pe);
						}
					}
				}
			}
			categoryEditDao.delete(c.getId());
			c.setPid(null);
			c.setStatus(-1);
			dao.update(c);
			dao.updateStatus(c.getId(), -1);
		}
	}

	public void deleteRecycled(List<DsCmsCategory> list)
	{
		for(DsCmsCategory c : list)
		{
			if(c.getStatus() == -1)
			{
				if(c.getScope() == 1)
				{
					pageDao.deleteByCategoryid(c.getId());
					pageEditDao.deleteByCategoryid(c.getId());
				}
				dao.delete(c.getId());
			}
		}
	}

	public void updateRestore(DsCmsCategory po)
	{
		dao.update(po);
		dao.updateStatus(po.getId(), 0);
	}

	public Page<DsCmsPageEdit> queryPagePageEdit(PageRequest pr)
	{
		return pageEditDao.queryPage(pr);
	}
}

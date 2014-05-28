/**
 * 应用系统Dao
 */
package dswork.common.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import dswork.common.model.DsCommonSystem;
import dswork.core.db.BaseDao;

@Repository
@SuppressWarnings("all")
public class DsCommonSystemDao extends BaseDao<DsCommonSystem, Long>
{
	@Override
	public Class getEntityClass()
	{
		return DsCommonSystem.class;
	}

	/**
	 * 修改状态
	 * @param id 系统主键
	 * @param status 状态
	 */
	public void updateStatus(long id, int status)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("status", status);
		executeUpdate("updateStatus", map);
	}

	/**
	 * 判断标识是否存在
	 * @param alias 标识
	 * @return boolean 存在true，不存在false
	 */
	public boolean isExistByAlias(String alias)
	{
		DsCommonSystem m = (DsCommonSystem) executeSelect("getByAlias", alias);
		if (m != null && m.getId().longValue() != 0)
		{
			return true;
		}
		return false;
	}
}
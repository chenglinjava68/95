package com.dhcc.flow.task;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.apache.commons.beanutils.BeanUtils;

import com.dhcc.common.database.OracleDBManager;



public class PortIpsDao
{
   
   /*public BaseVo loadFromRS(ResultSet rs)
   {
	   ErrorCorrectionModel vo = new ErrorCorrectionModel();
       try
       {
    	   vo.setIpaddress(rs.getString("ipaddress")); //ip��ַ
    		vo.setEntity(rs.getString("entity"));		//OutBandwidthUtilHdx��InBandwidthUtilHdx
    		vo.setSubentity(rs.getString("subentity"));	//�˿�����
    		vo.setCollecttime(rs.getString("collecttime")); //�ɼ�ʱ��
    		vo.setRestype(rs.getString("restype"));   
    		vo.setCategory(rs.getString("category"));
    		vo.setUtilhdxunit(rs.getString("utilhdxunit"));
    		vo.setUtilhdx(rs.getString("utilhdx"));  //����
    		vo.setUtilhdxperc(rs.getString("utilhdxperc"));  //����������
    		vo.setDiscardsperc(rs.getString("discardsperc"));// ������
    		vo.setErrorsperc(rs.getString("errorsperc"));  //������
    		vo.setPercunit(rs.getString("percunit"));   //�����ʵ�λ
    		vo.setUtilhdxflag(rs.getString("utilhdxflag"));  //�Ƿ�Ϊ�쳣
    		vo.setRecover(rs.getString("recover"));      //���������
    		vo.setIfspeed(rs.getString("ifspeed"));     //����
       }
       catch(Exception e)
       {
 	       SysLogger.error("ErrorCorrectionModel.loadFromRS()",e); 
       }	   
       return vo;
   }	*/
	/**
	 * ��ȡ1Сʱʱ������
	 */
	public void gethalfyearData(String ip) {
		OracleDBManager dbm=new OracleDBManager();
		
		Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.MONTH, -6);
        //ǰ6���µ�����
        String halfyear = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        String sql = "select a.ipaddress,a.restype,a.category,a.entity,a.subentity,round(avg(a.utilhdx),2) as utilhdx,round(avg(a.utilhdxperc),2) as utilhdxperc,round(avg(a.discardsperc),2) as discardsperc ,round(avg(a.errorsperc),2) as errorsperc, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeed from (select  ipaddress,restype,category,entity,subentity,utilhdx,utilhdxperc,discardsperc,errorsperc,TO_CHAR(collecttime,'YYYY/MM/DD hh24') as collecttime ,utilhdxunit,percunit,ifspeed from portips"+ip+" t where t.collecttime<to_date('"+halfyear+"','YYYY/MM/DD'))  a  group by a.collecttime,a.ipaddress,a.restype,a.category,a.entity,a.subentity, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeed";
		//select a.ipaddress,a.restype,a.category,a.entity,a.subentity,avg(a.utilhdx) as utilhdx,avg(a.utilhdxperc) as utilhdxperc,avg(a.discardsperc) as discardsperc ,avg(a.errorsperc) as errorsperc, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeed from (select  ipaddress,restype,category,entity,subentity,utilhdx,utilhdxperc,discardsperc,errorsperc,TO_CHAR(collecttime,'YYYY/MM/DD hh24') as collecttime ,utilhdxunit,percunit,ifspeed from portips183_203_0_111 t)  a group by a.collecttime,a.ipaddress,a.restype,a.category,a.entity,a.subentity,a.utilhdx,a.utilhdxperc,a.discardsperc,a.errorsperc, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeeda
		List<PortIpsModel> list = null;
		try {
			list = dbm.getObjectList(PortIpsModel.class, sql);
			if(list==null||list.size()==0) return; 
			PortIpsDao dao = new PortIpsDao();
			List insertsql = dao.inserthelfyear(list, ip,"hour");
			
			//ִ��ɾ������
			String deletesql = "delete from portips"+ip+" t where t.collecttime<to_date('"+halfyear+"','YYYY/MM/DD')";
			insertsql.add(deletesql);
			boolean t = dbm.excuteBatchSql(insertsql);
			System.out.println(t);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			dbm.close();
		}
	
	}
	
	/**
	 * ��ȡһ��ʱ������
	 */
	public void getyearData(String ip) {
		OracleDBManager dbm=new OracleDBManager();
		
		Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.MONTH, -18);
        //ǰ12���µ�����
        String year = new SimpleDateFormat( "yyyy-MM-dd").format(cal.getTime());
        String sql = "select a.ipaddress,a.restype,a.category,a.entity,a.subentity,round(avg(a.utilhdx),2) as utilhdx,round(avg(a.utilhdxperc),2) as utilhdxperc,round(avg(a.discardsperc),2) as discardsperc ,round(avg(a.errorsperc),2) as errorsperc, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeed from (select  ipaddress,restype,category,entity,subentity,utilhdx,utilhdxperc,discardsperc,errorsperc,TO_CHAR(collecttime,'YYYY/MM/DD') as collecttime ,utilhdxunit,percunit,ifspeed from portipshour"+ip+" t where t.collecttime<to_date('"+year+"','YYYY/MM/DD'))  a  group by a.collecttime,a.ipaddress,a.restype,a.category,a.entity,a.subentity, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeed";
		//select a.ipaddress,a.restype,a.category,a.entity,a.subentity,avg(a.utilhdx) as utilhdx,avg(a.utilhdxperc) as utilhdxperc,avg(a.discardsperc) as discardsperc ,avg(a.errorsperc) as errorsperc, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeed from (select  ipaddress,restype,category,entity,subentity,utilhdx,utilhdxperc,discardsperc,errorsperc,TO_CHAR(collecttime,'YYYY/MM/DD hh24') as collecttime ,utilhdxunit,percunit,ifspeed from portips183_203_0_111 t)  a group by a.collecttime,a.ipaddress,a.restype,a.category,a.entity,a.subentity,a.utilhdx,a.utilhdxperc,a.discardsperc,a.errorsperc, a.collecttime ,a.utilhdxunit,a.percunit,a.ifspeeda
		List<PortIpsModel> list = null;
		try {
			list = dbm.getObjectList(PortIpsModel.class, sql);
			if(list==null||list.size()==0) return; 
			PortIpsDao dao = new PortIpsDao();
			List insertsql = dao.inserthelfyear(list, ip,"day");
			//ִ��ɾ������
			String deletesql = "delete from portipshour"+ip+" t where t.collecttime<to_date('"+year+"','YYYY/MM/DD')";
			insertsql.add(deletesql);
			boolean t = dbm.excuteBatchSql(insertsql);
			System.out.println(t);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			dbm.close();
		}
	
	}
	
	/**
	 * ����ip���ɲ������ ��PORTIPSDAY�� ����ΪСʱ  
	 * @param list
	 * @param ip
	 * @return
	 */
   public List inserthelfyear(List list,String ip,String flag)
   {	
		String allipstr = ip.replaceAll("\\.", "_");
	    List insertsql = new ArrayList();
			//�˿�״̬��Ϣ���
			Calendar tempCal = null;
			Date cc = null;
			//StringBuffer sBuffer = null;
			String time = null;
			//UtilHdx
			List portipslist  = list;
			String tablename="";
			if (portipslist != null && portipslist.size() > 0) {
				if(flag.equals("day")) {
					tablename = "PORTIPSDAY" + allipstr;
				}else {
					tablename = "PORTIPSHOUR" + allipstr;
				}
				 
				PortIpsModel utilhdx = null;
				for (int si = 0; si < portipslist.size(); si++) {
					
						utilhdx = (PortIpsModel) portipslist.get(si);
						if (utilhdx.getRestype().equals("dynamic")) {
							time = utilhdx.getCollecttime();
							StringBuffer sBuffer = new StringBuffer();
							sBuffer.append("insert into ");
							sBuffer.append(tablename);
							sBuffer.append("(ipaddress,restype,category,entity,subentity,utilhdxunit,utilhdx,utilhdxperc,discardsperc,errorsperc,percunit,utilhdxflag,recover,ifspeed,collecttime) ");
							sBuffer.append("values('");
							sBuffer.append(utilhdx.getIpaddress());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getRestype());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getCategory());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getEntity());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getSubentity());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getUtilhdxunit());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getUtilhdx());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getUtilhdxperc());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getDiscardsperc());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getErrorsperc());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getPercunit());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getUtilhdxflag());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getRecover());
							sBuffer.append("','");
							sBuffer.append(utilhdx.getIfspeed());
							sBuffer.append("',");
							sBuffer.append("to_date('"+time+"','YYYY-MM-DD HH24:MI:SS')");
							sBuffer.append(")");
							 //System.out.println(sBuffer.toString());
							 insertsql.add(sBuffer.toString());
							//GathersqlListManager.Addsql(sBuffer.toString());
					sBuffer = null;
				}
						
			}
			}
			return insertsql;
   }

   /**
    * ��ȡ������豸��ip
    * @return
    */
   public List getNodeHost() {
	   OracleDBManager dbm=new OracleDBManager();
	   List list =null;
	   try {
		   String sql = "select distinct thn.ip_address from TOPO_HOST_NODE thn,topo_interface ti where thn.ip_address=ti.node_id";
		   list = dbm.getObjectList(HostNode.class, sql);
		   
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			dbm.close();
		}
	   
	   return list;
	   
   }

	
}

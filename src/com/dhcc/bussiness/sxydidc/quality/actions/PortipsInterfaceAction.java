package com.dhcc.bussiness.sxydidc.quality.actions;

import java.text.ParseException;
import java.util.List;

import com.dhcc.bussiness.sxydidc.customer95.models.Customer;
import com.dhcc.bussiness.sxydidc.customer95.models.ProductIp;
import com.dhcc.bussiness.sxydidc.quality.dao.PortipsDao;
import com.dhcc.bussiness.sxydidc.quality.dao.TopoInterfaceDao;
import com.dhcc.bussiness.sxydidc.quality.models.Portips;
import com.dhcc.bussiness.sxydidc.quality.models.TopoInterface;
import com.opensymphony.xwork2.ActionSupport;

public class PortipsInterfaceAction  extends ActionSupport{

	private String type;
	private String dateFormat;
	private String date;
	private Customer customer;
	
	private List<TopoInterface> gatherInterfaceList;
	

	/**
	 * @return the dateFormat
	 */
	public String getDateFormat() {
		return dateFormat;
	}

	/**
	 * @param dateFormat the dateFormat to set
	 */
	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}



	/**
	 * @return the gatherInterfaceList
	 */
	public List<TopoInterface> getGatherInterfaceList() {
		return gatherInterfaceList;
	}

	/**
	 * @param gatherInterfaceList the gatherInterfaceList to set
	 */
	public void setGatherInterfaceList(List<TopoInterface> gatherInterfaceList) {
		this.gatherInterfaceList = gatherInterfaceList;
	}



	private List<Portips> list;
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the date
	 */
	public String getDate() {
		return date;
	}

	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
	}

	/**
	 * @return the customer
	 */
	public Customer getCustomer() {
		return customer;
	}

	/**
	 * @param customer the customer to set
	 */
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}


	
	/* 指定客户的按天，月，年的丢包率、错包率
	 * @see com.opensymphony.xwork2.ActionSupport#execute()
	 */
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		TopoInterfaceDao interfaceDao = new TopoInterfaceDao();
//		每个客户的IP所在的设备IP表和所对端口序号索引
		List<TopoInterface> interfaceList = interfaceDao.queryGatherInterfaceListFor(customer);
		
		try{
			PortipsDao portipsDao = new PortipsDao(type,dateFormat,date);
			this.list = portipsDao.queryPortipsForInterface(interfaceList);
		}catch(IllegalArgumentException e){
			e.printStackTrace();
		}catch(ParseException e){
			e.printStackTrace();
		}
		
		return SUCCESS;
	}

	/**
	 * @return the list
	 */
	public List<Portips> getList() {
		return list;
	}

	/**
	 * @param list the list to set
	 */
	public void setList(List<Portips> list) {
		this.list = list;
	}

	
	/* 指定索引的采集口按天，月，年的丢包率、错包率
	 * @see com.opensymphony.xwork2.ActionSupport#execute()
	 */
	public String executeForGatherInterface() throws Exception {
		// TODO Auto-generated method stub
		TopoInterfaceDao interfaceDao = new TopoInterfaceDao();

		try{
			PortipsDao portipsDao = new PortipsDao(type,dateFormat,date);
			this.list = portipsDao.queryPortipsForInterface(this.gatherInterfaceList);
		}catch(ParseException e){
//			日期格式和日期不匹配
			e.printStackTrace();
		}catch(IllegalArgumentException e){
//			非法日期格式
			e.printStackTrace();
		}
		
		return SUCCESS;
	}

}
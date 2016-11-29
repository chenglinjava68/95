package com.dhcc.bussiness.sxydidc.quality.models;

// Generated 2016-11-24 11:37:02 by Hibernate Tools 4.3.1

/**
 * TopoInterface generated by hbm2java
 */
public class TopoInterface implements java.io.Serializable {

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		return result;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TopoInterface other = (TopoInterface) obj;
		if (id != other.id)
			return false;
		return true;
	}

	private long id;
	private String nodeId;
	private String ifIndex;
	private String ifDesc;
	private String customerId;

	public TopoInterface() {
	}

	public TopoInterface(long id) {
		this.id = id;
	}

	public TopoInterface(long id, String nodeId, String ifIndex, String ifDesc,
			String customerId) {
		this.id = id;
		this.nodeId = nodeId;
		this.ifIndex = ifIndex;
		this.ifDesc = ifDesc;
		this.customerId = customerId;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNodeId() {
		return this.nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getIfIndex() {
		return this.ifIndex;
	}

	public void setIfIndex(String ifIndex) {
		this.ifIndex = ifIndex;
	}

	public String getIfDesc() {
		return this.ifDesc;
	}

	public void setIfDesc(String ifDesc) {
		this.ifDesc = ifDesc;
	}

	public String getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TopoInterface [id=" + id + ", nodeId=" + nodeId + ", ifIndex="
				+ ifIndex + ", ifDesc=" + ifDesc + ", customerId=" + customerId
				+ "]";
	}

}
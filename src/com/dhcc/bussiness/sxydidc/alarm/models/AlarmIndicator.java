package com.dhcc.bussiness.sxydidc.alarm.models;

// Generated 2016-11-1 10:20:58 by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * AlarmIndicator generated by hbm2java
 */
public class AlarmIndicator implements java.io.Serializable {

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((indicatorId == null) ? 0 : indicatorId.hashCode());
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
		AlarmIndicator other = (AlarmIndicator) obj;
		if (indicatorId == null) {
			if (other.indicatorId != null)
				return false;
		} else if (!indicatorId.equals(other.indicatorId))
			return false;
		return true;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AlarmIndicator [indicatorId=" + indicatorId + ", name=" + name
				+ ", unit=" + unit + "]";
	}

	private BigDecimal indicatorId;
	private String name;
	private String unit;
	private Set<AlarmRule> alarmRules = new HashSet<AlarmRule>(0);

	public AlarmIndicator() {
	}

	public AlarmIndicator(BigDecimal indicatorId, String name) {
		this.indicatorId = indicatorId;
		this.name = name;
	}

	public AlarmIndicator(BigDecimal indicatorId, String name, String unit,
			Set<AlarmRule> alarmRules) {
		this.indicatorId = indicatorId;
		this.name = name;
		this.unit = unit;
		this.alarmRules = alarmRules;
	}

	public BigDecimal getIndicatorId() {
		return this.indicatorId;
	}

	public void setIndicatorId(BigDecimal indicatorId) {
		this.indicatorId = indicatorId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Set<AlarmRule> getAlarmRules() {
		return this.alarmRules;
	}

	public void setAlarmRules(Set<AlarmRule> alarmRules) {
		this.alarmRules = alarmRules;
	}

}

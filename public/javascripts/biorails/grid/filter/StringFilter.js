Ext.ux.grid.filter.StringFilter = Ext.extend(Ext.ux.grid.filter.Filter, {
	updateBuffer: 500,
	icon: '/img/small_icons/famfamfam/find.png',
	
	init: function(){
		var value = this.value = new Ext.ux.menu.EditableItem(
				{icon: this.icon});
		value.on('keyup', this.onKeyUp, this);
		this.menu.add(value);
		
		this.updateTask = new Ext.util.DelayedTask(this.fireUpdate, this);
	},
	
	onKeyUp: function(event){
		if(event.getKey() == event.ENTER){
			this.menu.hide(true);
			return;
		}
			
		this.updateTask.delay(this.updateBuffer);
	},
	
	isActivatable: function(){
		return this.value.getValue().length > 0;
	},
	
	fireUpdate: function(){		
		if(this.active)
			this.fireEvent("update", this);
			
		this.setActive(this.isActivatable());
	},
	
	setValue: function(value){
		this.value.setValue(value);
		this.fireEvent("update", this);
	},
	
	getValue: function(){
		return this.value.getValue();
	},
	
	serialize: function(){
		return {type: 'string', value: this.getValue()};
	},
	
	validateRecord: function(record){
		var val = record.get(this.dataIndex);
		
		if(typeof val != "string")
			return false;
			
		return val.indexOf(this.getValue()) > -1;
	}
});
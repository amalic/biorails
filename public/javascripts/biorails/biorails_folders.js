//---------------------------------------- Folders Document ----------------------------------------------------------
Ext.namespace("Biorails");

Ext.namespace("Biorails.Document");
/*
 * Panel for handling a biorails folder display. This is basically a grid with some custom D&D code.
 */
Biorails.Document = function(config){  
    
     Biorails.Document.superclass.constructor.call(this, Ext.apply(config,{
           autoLoad: '/folders/document/'+config.folder_id,
           id: 'folder-doc-'+config.folder_id,
           enableDragDrop: true,
           tbar:[{
                    text:'Add File',
                    tooltip:'Add a image or other file to the folder',
                    href: '/asset/new/'+config.folder_id, 
                    handler: this.toolbarClick,                               
                    iconCls:'icon-file'
                },'-', {
                    text:'Add Article',
                    tooltip:'Add some textual content to the folder',
                    href: '/content/new/'+config.folder_id,                              
                    handler: this.toolbarClick,                               
                    iconCls:'icon-note'
                },'-', {
                    text:'Add Sub-folder',
                    tooltip:'Add a new sub folder',
                    href: '/folders/new/'+config.folder_id,                                
                    handler: this.toolbarClick,                               
                    iconCls:'icon-folder'
                }, '-', {
                    text:'Folder',
                    tooltip:'Show as Folder',
                    folder_id: config.folder_id,                                
                    handler : function(item){
                        Biorails.showFolder(item.folder_id);
                    }, 
                    iconCls:'icon-print'
                },'-', {
                    text:'Preview',
                    tooltip:'Preview',
                    href: '/folders/print/'+config.folder_id,                                
                    handler : function(item){
                        window.open(item.href);
                    }, 
                    iconCls:'icon-print'
                },'-',{
                    text:'Sign',
                    tooltip:'Sign as the author',
                   href: '/folders/sign/'+config.folder_id+'?format=js',                            
                   	handler : function(item){
                       window.open(item.href);
                   },                  
                    iconCls:'icon-sign'
                },'-',{
                    text:'Print',
                    tooltip:'Print the folder as a report',
                    href: '/folders/print/'+config.folder_id+'?format=pdf',                                
                    handler : function(item){
                        window.open(item.href);
                    },                               
                    iconCls:'icon-pdf'
                }]   
         }));
};

Ext.extend(Biorails.Document,  Ext.Panel, {
/*
 * Fire AJAX call for tool bar functions
 */    
    toolbarClick: function(item) {
         new Ajax.Request( item.href,  {asynchronous:true, evalScripts:true });         
    },
    
    resync: function(){
    }

   });	
//---------------------------------------- Folders Grid ----------------------------------------------------------

Ext.namespace("Biorails.Folder");
/*
 * Panel for handling a biorails folder display. This is basically a grid with some custom D&D code.
 * 
 */
Biorails.Folder = function(config){  
    
     var _store = new Ext.data.GroupingStore({
               remoteSort: true,
               sortInfo: {params:{sort: 'left_limit',dir:'ASC'}},
               lastOptions: {params:{sort: 'left_limit',dir:'ASC',start: 0, limit: 25}},
               proxy: new Ext.data.HttpProxy({ url: '/folders/grid/'+config.folder_id, method: 'get' }),
               reader: new Ext.data.JsonReader({
                             root: 'items', totalProperty: 'total'}, [
                                   {name: 'id', type: 'int' },
                                   {name: 'icon'},
                                   {name: 'position', type: 'int'},
                                   {name: 'left_limit', type: 'int'},
                                   {name: 'right_limit', type: 'int'},
                                   {name: 'name'},
                                   {name: 'summary'},
                                   {name: 'reference_type'},
                                   {name: 'updated_by'},
                                   {name: 'updated_at', type: 'date', dateFormat: 'Y-m-d H:i:s'},
                                   {name: 'actions'}]  )
                        });
                       
                         
     Biorails.Folder.superclass.constructor.call(this, Ext.apply(config,{
           id: 'folder-grid-'+config.folder_id,
           ds:  _store ,
           sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
           loadMask: true,
           enableDragDrop: true,
           cm: new Ext.grid.ColumnModel([
                {header: "Pos", width: 50, sortable: true, renderer: this.renderNum,  dataIndex: 'left_limit'},
                {header: "Icon", width: 32, sortable: false,renderer: this.renderIcon,  dataIndex: 'icon'},
                {header: "Name", width: 150, sortable: true,  dataIndex: 'name'},
                {header: "Style", width: 100, sortable: true,  dataIndex: 'reference_type'},
                {header: "Summmary", width: 300, sortable: false,   dataIndex: 'summary'},
                {header: "Updated By", width: 55, sortable: false,  dataIndex: 'updated_by'},
                {header: "Updated At", width: 85, sortable: true,
                          renderer: Ext.util.Format.dateRenderer('d/m/Y'), dataIndex: 'updated_at'},
                {header: "Actions", width: 75,   dataIndex: 'actions'}
                ]),
           view: new Ext.grid.GroupingView(),
           viewConfig: {
                 forceFit:false
               },
           tbar:[{
                    text:'Add File',
                    xtype:'tbbutton',
                    tooltip:'Add a image or other file to the folder',
                    href: '/asset/new/'+config.folder_id, 
                    handler: this.toolbarClick,                               
                    iconCls: 'icon-file'
                },'-', {
                    text:'Add Article',
                    tooltip:'Add some textual content to the folder',
                    xtype:'tbbutton',
                    href: '/content/new/'+config.folder_id,                              
                    handler: this.toolbarClick,                               
                    iconCls: 'icon-note'
                },'-', {
                    text:'Add Sub-folder',
                    tooltip:'Add a new sub folder',
                    xtype:'tbbutton',
                    href: '/folders/new/'+config.folder_id,                                
                    handler: this.toolbarClick,                               
                    iconCls: 'icon-folder'
                },'-', {
                    text:'Document',
                    tooltip:'Show as Document',
                    xtype:'tbbutton',
                    folder_id: config.folder_id,                                
                    handler : function(item){
                        Biorails.showDocument(item.folder_id);
                    }, 
                    iconCls: 'icon-print'
                }, '-', {
                    text:'Preview',
                    tooltip:'Preview',
                    xtype:'tbbutton',
                    href: '/folders/print/'+config.folder_id,                                
                    handler : function(item){
                        window.open(item.href);
                    }, 
                    iconCls: 'icon-print'
                },'-',{
                    text:'Sign',
                    xtype:'tbbutton',
                    tooltip:'Sign as the author',
                    href: '/folders/sign/'+config.folder_id,                              
                    handler : function(item){
                        window.open(item.href);
                    },                  
                    iconCls:'icon-sign'
                },'-',{
                    text:'Print',
                    xtype:'tbbutton',
                    tooltip:'Print the folder as a report',
                    href: '/folders/print/'+config.folder_id+'?format=pdf',                                
                    handler : function(item){
                        window.open(item.href);
                    },                               
                    iconCls:'icon-pdf'
                }],
                bbar: new Ext.PagingToolbar({
				            pageSize: 25,
				            store: _store,
				            displayInfo: true,
				            displayMsg: 'Displaying {0} - {1} of {2}',
				            emptyMsg: "No results to display"
				        })
   
         }));
         if (_store.getCount() < 1){
             _store.load();             
         }
         
         this.on('render',    function(grid){
             grid.enableDD();
         });
};

Ext.extend(Biorails.Folder,  Ext.grid.GridPanel, {
/*
 * Fire AJAX call for tool bar functions
 */    
    toolbarClick: function(item) {
         new Ajax.Request( item.href,
                            {asynchronous:true,
                             evalScripts:true });         
       
    },
    renderIcon: function(val){
        return '<img src="' + val + '" />';
    },
    renderNum: function(val,cell,record,row,col,ds){
        return '1.'+record.get('position');
    },
    
 /*
  * dropped Item Handler to update the layout 
  * with new row added via clipboard or tree
  */      
   droppedItem: function(source,event,data){
       try{ 
           // Get selection for default row
            var sm=this.grid.getSelectionModel();
            var rows=sm.getSelections();

            // Test for case of a row from a grid
            if (data.rowIndex) {
                var source_row = data.grid.store.getAt(data.rowIndex);
                var  dest_row  = this.grid.store.getAt( source.getDragData(event).rowIndex );
                
                 new Ajax.Request("/folders/reorder_element/"+
                          source_row.data.id,
                        {asynchronous:true, 
                         onComplete: function(req) {
                             data.grid.store.load();
                             } ,
                         parameters:'before='+dest_row.data.id+'&folder_id='+data.grid.folder_id });  
                         
            }
            // Test for case of a node from a folder tree 
            else if (data.node) {
                
                new Ajax.Request('/folders/add_element/'+data.node.id,
                            {asynchronous:true,
                             onComplete: this.grid.resync,
                             parameters:'folder_id='+this.folder_id });  
            }  
        } catch (e) {
              console.log('Problem cant handle Dropped Item ');
              console.log(e);
        } 
        return true;  
   },
   
/*
 * Custom Rendering function to add drop zone on grid after its rendered
 */    
   enableDD: function(){
    try {
          var dropzone = new Ext.dd.DropTarget(this.id, {
                ddGroup : 'GridDD',
                folder_id: this.folder_id,
                grid: this,
                notifyDrop : this.droppedItem  });
            
             dropzone.addToGroup("ClipboardDD"); 
             dropzone.addToGroup("TreeDD"); 
        } catch (e) {
              console.log('Problem with setup drop zone on folder grid ');
              console.log(e);
        }        
   }

   });	
   
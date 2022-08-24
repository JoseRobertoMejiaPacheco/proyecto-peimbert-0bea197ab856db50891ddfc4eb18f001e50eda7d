# -*- coding: utf-8 -*-
{
    'name': "stps",

    'summary': """
        Short (1 phrase/line) summary of the module's purpose, used as
        subtitle on modules listing or apps.openerp.com""",

    'description': """
        Long description of module's purpose
    """,

    'author': "My Company",
    'website': "http://www.yourcompany.com",

    # Categories can be used to filter modules in modules listing
    # Check https://github.com/odoo/odoo/blob/15.0/odoo/addons/base/data/ir_module_category_data.xml
    # for the full list
    'category': 'Uncategorized',
    'version': '0.1',

    # any module necessary for this one to work correctly
    'depends': ['base'],

    # always loaded
    'data': [
        
        
        
        'data/stps.state.csv',
        'data/stps.sector.csv',
        'data/stps.municipality.csv',
        'security/security.xml',
        'security/ir.model.access.csv', 
        'views/stps_statistical_sector.xml',                      
        'views/stps_state.xml',
        'views/stps_municipality.xml',
       
        'views/stps_sector.xml',                
        'views/stps_menu.xml',
        
    ],
    # only loaded in demonstration mode
    'demo': [
        'demo/demo.xml',
    ],
    'application':True,
    # 'category': 'STPS/Statics',
    #base.module_stps_statics
}

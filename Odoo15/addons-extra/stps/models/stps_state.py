from odoo import _, api, fields, models


class municipio(models.Model):
    _name = 'stps.state'
    _description = 'Estados de la República Mexicana'
    _rec_name = 'name'
 
    state_number = fields.Char(string='Folio', default=lambda self: self.env['ir.sequence'].next_by_code('stps.state'))

    code = fields.Char(string='Clave Estado')
    country_code = fields.Char(string='Clave País')
    name = fields.Char(string='Estado')
    
    
    
    
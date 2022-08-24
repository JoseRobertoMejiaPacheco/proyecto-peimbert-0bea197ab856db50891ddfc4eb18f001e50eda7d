from odoo import _, api, fields, models


class municipio(models.Model):
    _name = 'stps.municipality'
    _description = 'Municipios de la República Mexicana'
    _rec_name = 'name'
 
    municipality_number = fields.Char(string='Folio', default=lambda self: self.env['ir.sequence'].next_by_code('stps.municipality'))
    code = fields.Char(string='Clave Municipio')
    code_state = fields.Char(string='Clave Estado')
    name = fields.Char(string='Municipio')
    


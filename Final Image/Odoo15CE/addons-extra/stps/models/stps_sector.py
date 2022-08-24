from odoo import _, api, fields, models


class municipio(models.Model):
    _name = 'stps.sector'
    _description = 'Sectores Industriales de la República Mexicana'
    _rec_name = 'name'
 
    sector_number = fields.Char(string='Folio', default=lambda self: self.env['ir.sequence'].next_by_code('stps.sector'))

    code = fields.Char(string='Clave Sector')
    name = fields.Char(string='Sector')


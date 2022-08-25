from odoo import models, fields, api
from odoo.exceptions import UserError, ValidationError
import requests
import json


class stps(models.Model):
    _name = 'stps.statistical_sector'
    _description = 'Polígonos STPS- Estadísticas del Sector Laboral'
    _rec_name = 'statistical_sector_number'

    statistical_sector_number = fields.Char(
        string='Folio', default=lambda self: self.env['ir.sequence'].next_by_code('stps.statistical_sector'))
    year = fields.Selection(
        string='Año',
        selection=[('2021', '2021'), ('2022', '2022'), ('2023', '2023')],required=True   
    )

    month = fields.Selection(
        string='Mes',
        selection=[('enero', 'ENERO'),
                   ('febrero', 'FEBRERO'),
                   ('marzo', 'MARZO'),
                   ('abril', 'ABRIL'),
                   ('mayo', 'MAYO'),
                   ('junio', 'JUNIO'),
                   ('julio', 'JULIO'),
                   ('agosto', 'AGOSTO'),
                   ('septiembre', 'SEPTIEMBRE'),
                   ('octubre', 'OCTUBRE'),
                   ('noviembre', 'NOVIEMBRE'),
                   ('diciembre', 'DICIEMBRE')
                   ],required=True)
    salary = fields.Float(string='Salario Mensual Libre de Impuestos',required=True)
    age = fields.Integer(string='Edad',required=True)
    gender = fields.Selection(string='Género', selection=[
                              ('M', 'Masculino'), ('F', 'Femenino')],required=True)
    sector_id = fields.Many2one('stps.sector', string='Sector Industrial',required=True)
    state_id = fields.Many2one('stps.state', string='Estado',required=True)
    municipality_id = fields.Many2one('stps.municipality', string='Municipio',required=True)
    _id = fields.Char(string='UUID',readonly=True)

    @api.model
    def create(self, values):
        # Add code here
        URL = 'http://34.125.137.210:3000/statisticalsector'
        response = requests.post(URL, json=values)
        if response.status_code in [200]:
            response_dict = json.loads(response.text)
            values.update({'_id': response_dict['_id']})
            return super(stps, self).create(values)
        else:
            raise ValidationError(
                "Error al registrar código de error %s" % (response.status_code))

    def write(self, values):
        URL = 'http://34.125.137.210:3000/statisticalsector/%s' % (self._id)
        new_vals = {
            "year": self.year,
            "month": self.month,
            "salary": self.salary,
            "age": self.age,
            "gender": self.gender,
            "state_id": self.state_id.id,
            "sector_id":self.sector_id.id,
            "municipality_id": self.municipality_id.id
        }
        new_vals.update(values)
        response = requests.put(URL, json=new_vals)
        if response.status_code in [200]:
            return super().write(values)
        else:
            raise ValidationError(
                "Error al actualizar el registro código de error %s" % (response.status_code))

    def unlink(self):
        
        for record in self:
            URL = 'http://34.125.137.210:3000/statisticalsector/%s' % (record._id)
            response = requests.delete(URL)
            if response.status_code in [200]:
                super(stps, record).unlink()
            else:
                raise ValidationError(
                    "Error al eliminar el registro código de error %s" % (response.status_code))
        return



    def copy(self, default=None):
        default = dict(default or {})
        URL = 'http://34.125.137.210:3000/statisticalsector'
        default.update( {
            "year": self.year,
            "month": self.month,
            "salary": self.salary,
            "age": self.age,
            "gender": self.gender,
            "state_id": self.state_id.id,
            "sector_id":self.sector_id.id,
            "municipality_id": self.municipality_id.id,
            "statistical_sector_number":self.env['ir.sequence'].next_by_code('stps.statistical_sector')
        })
        return super().copy(default)   
            

        # for item in response_dict:
        #     keys_to_remove = []
        #     fields_keys = self._fields.keys()
        #     api_keys = item.keys()
        #     for key in api_keys:
        #         if key not in fields_keys:
        #             keys_to_remove.append(key)
        #     for key_to_remove in keys_to_remove:
        #         item.pop(key_to_remove)

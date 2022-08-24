# -*- coding: utf-8 -*-
# from odoo import http


# class Stps(http.Controller):
#     @http.route('/stps/stps', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/stps/stps/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('stps.listing', {
#             'root': '/stps/stps',
#             'objects': http.request.env['stps.stps'].search([]),
#         })

#     @http.route('/stps/stps/objects/<model("stps.stps"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('stps.object', {
#             'object': obj
#         })

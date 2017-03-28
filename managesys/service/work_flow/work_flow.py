#coding:utf-8

from flask import request
from flask_login import login_required

from managesys import db
from flask import Blueprint

from managesys.moudel.util import ok,objs_to_json
from managesys.service.login.models import User
from managesys.service.role.models import Role
from models import FlowInfo
work_flow = Blueprint('work_flow', __name__, url_prefix='/workflow')


@work_flow.route('/')
def index():
    return 'work flow!'

@work_flow.route('/flowinfos',methods=['GET','POST'])
def flow_infos():
    query = db.session.query(FlowInfo)
    if request.method == "GET":
        flow_infos=query.all()
        if flow_infos:
            return ok(objs_to_json(flow_infos))

@work_flow.route('/flowinfo/<user_name>',methods=['GET','POST'])
@login_required
def flow_infos_by_role(user_name):
    '''
    获取和添加角色拥有的流程
    :param role_name:
    :return:
    '''
    if request.method=="GET":
        users=User.query.filter_by(name=user_name)
        if users:
            roles=users.first().roles.all()
            return ok(objs_to_json(roles))
        return ok(u"没有数据")
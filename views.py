#-*- coding:utf-8 -*-
import sys
import importlib
importlib.reload(sys)

from django.http.response import HttpResponse, HttpResponseBadRequest
from django.views.decorators.csrf import csrf_exempt
from wechat_sdk import WechatConf
from wechat_sdk import WechatBasic
from wechat_sdk.exceptions import ParseError
from wechat_sdk.messages import (TextMessage, VoiceMessage, ImageMessage, VideoMessage, LinkMessage, LocationMessage, EventMessage, ShortVideoMessage)
conf = WechatConf(
        token='YOUR_TOKEN_HERE',
        appid='YOUR_APPID',
        appsecret='YOUR_APPSECRET',
        encrypt_mode='YOUR_MODE',
        encoding_aes_key='YOUR_AES_KEY'
)
@csrf_exempt
def wechat_home(request):
        signature = request.GET.get('signature')
        timestamp = request.GET.get('timestamp')
        nonce = request.GET.get('nonce')
        wechat_instance = WechatBasic(conf=conf)
        if not wechat_instance.check_signature(signature=signature, timestamp=timestamp, nonce=nonce):
            return HttpResponseBadRequest('Verify Failed')
        else:
            if request.method == 'GET':
                response = request.GET.get('echostr', 'error')
            else:
                try:
                    wechat_instance.parse_data(request.body)    
                    message = wechat_instance.get_message()         
                    if isinstance(message, TextMessage):            
                        reply_text = 'text'
                    elif isinstance(message, VoiceMessage):         
                        reply_text = 'voice'
                    elif isinstance(message, ImageMessage):         
                        reply_text = 'image'
                    elif isinstance(message, LinkMessage):          
                        reply_text = 'link'
                    elif isinstance(message, LocationMessage):      
                        reply_text = 'location'
                    elif isinstance(message, VideoMessage):         
                        reply_text = 'video'
                    elif isinstance(message, ShortVideoMessage):    
                        reply_text = 'shortvideo'
                    else:
                        reply_text = 'other'
                    response = wechat_instance.response_text(content=reply_text)
                except ParseError:  
                    return HttpResponseBadRequest('Invalid XML Data')
            return HttpResponse(response, content_type="application/xml")


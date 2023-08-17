Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22777F79E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcvu-0000Cb-Rs; Thu, 17 Aug 2023 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWcvq-0000Be-Dg
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:20:58 -0400
Received: from smtpnm6-09.21cn.com ([182.42.152.55] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWcvn-00020O-6Y
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:20:58 -0400
HMM_SOURCE_IP: 192.168.138.117:56503.1606458528
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 5E9A7111064AF;
 Thu, 17 Aug 2023 21:09:24 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-56d86dc765-7s8sf with ESMTP id
 b6869a31012e402386102557cde15b68 for marcandre.lureau@gmail.com; 
 Thu, 17 Aug 2023 21:09:42 CST
X-Transaction-ID: b6869a31012e402386102557cde15b68
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <c6b2fb49-d263-4e9c-940d-c97ee9deb62f@chinatelecom.cn>
Date: Thu, 17 Aug 2023 21:09:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, kraxel@redhat.com, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn
Subject: Re: [PATCH 1/2] ui/vdagent: call vdagent_disconnect() when agent
 connection is lost
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRTWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@gmail.com>
References: <cover.1692268800.git.tugy@chinatelecom.cn>
 <d285e8729552a6206ffa1cd4520fc8f9c6be5957.1692268800.git.tugy@chinatelecom.cn>
 <CAJ+F1C+_fGHq3odW6=2krDMhSkOX0krNTUjPnLAuiXHb62naAg@mail.gmail.com>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <CAJ+F1C+_fGHq3odW6=2krDMhSkOX0krNTUjPnLAuiXHb62naAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.152.55; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 2023/8/17 20:49, 【外部账号】Marc-André Lureau wrote:
> Hi
> 
> On Thu, Aug 17, 2023 at 3:32 PM <tugy@chinatelecom.cn> wrote:
>>
>> From: Guoyi Tu <tugy@chinatelecom.cn>
>>
>> when the agent connection is lost, the input handler of the mouse
>> doesn't deactivate, which results in unresponsive mouse events in
>> VNC windows.
>>
>> To fix this issue, call vdagent_disconnect() to reset the state
>> each time the frontend disconncect
>>
>> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
>> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
>> ---
>>   ui/vdagent.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/ui/vdagent.c b/ui/vdagent.c
>> index 8a651492f0..386dc5abe0 100644
>> --- a/ui/vdagent.c
>> +++ b/ui/vdagent.c
>> @@ -870,8 +870,11 @@ static void vdagent_disconnect(VDAgentChardev *vd)
>>
>>   static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
>>   {
>> +    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(chr);
>> +
>>       if (!fe_open) {
>>           trace_vdagent_close();
>> +        vdagent_disconnect(vd);
>>           /* To reset_serial, we CLOSED our side. Make sure the other end knows we
>>            * are ready again. */
>>           qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>> @@ -922,7 +925,6 @@ static void vdagent_chr_fini(Object *obj)
>>       VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
>>
>>       migrate_del_blocker(vd->migration_blocker);
>> -    vdagent_disconnect(vd);
> 
> why remove this cleanup ? (the function seems safe to call multiple
> times, if it is the case during finalize)
> 
Before the instance finalize, the connection will be closed and the
vdagent_chr_set_fe_open() will be called with be_open set to false,
which in turn call vdagent_disconnect to clean up resources.

>>       buffer_free(&vd->outbuf);
>>       error_free(vd->migration_blocker);
>>   }
>> --
>> 2.27.0
>>
>>
> 
> 


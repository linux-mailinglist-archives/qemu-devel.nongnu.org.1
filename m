Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EF786858
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:32:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ4o3-0000pm-IB; Thu, 24 Aug 2023 03:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ4nK-0000RT-E0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:30:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ4nE-0001YM-5t
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:30:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a6f6a66e1so1959059b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692862090; x=1693466890;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xk1t0f2poM7JoihgUljePfmXgf6B4GSHEfDAU97lk4=;
 b=xcmzsniYvKYuoglbgZU6O0WrZ3GwigFhdcAYXinihgR+BXZHyxiPsETug50u1NuKTV
 QOSMMhmN6eNNlgNUXX9TOMsUFDYixYWTi9JQpNCqxo7uUYy2wl1nxSV+19lypE10hkJ9
 +tQAEXlNS2uJVd3TyRODxoJR4mouH02q8oe9kpQmmZHS/t6OnOBvh0akTnXCRgKW0Jm4
 DJZzYMVuGC4MKcS2zwLvo2bZB7olXyZA2hdn1HPyNsyQoeOTqQV0plZTWMvxRW9VQHwF
 HKUzuofWfg1hqUV4mcO7JFnfBAT6MlmEHwI/0c4H553VJNzQ86qagHfzssAQh9LoZ/WC
 0OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692862090; x=1693466890;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xk1t0f2poM7JoihgUljePfmXgf6B4GSHEfDAU97lk4=;
 b=ELZcQq+a9/GCu8dAQe5ZLEyLLILmjnHND0ZJUxixB23aCxmSFtRHzTu84vRp1rDJ+m
 IWKfTw9w1qeSsVE1ouzkWGFlXjpJEXsnbAIesiXocMYszfzx7T+HLlPNVhRC9oblE9+r
 aCnHVSAuJIg8faTCdIVA6DFWhCS3iG9EKKd9kB6f3dhCBcPymR3GhCGmvTsaw2joRM3m
 zAmKNBYVMwrgesINCUcrDjdGDFlSg4dfr3xF0hrIWBVX29CjXwjS/pqPRh23H4AaoLmQ
 I5AmlaszzndbWZYFChmEQVvx6/YM1UPu6AV4lPnPQWKutnQVGLlQnHZTddfqW764m8vL
 riDg==
X-Gm-Message-State: AOJu0YyHZDw82UDu1li+gbG0w1vBLoL2To+2umDKkavVHxRgKTEQS8yc
 lcFmLLQxk4eAOhBf0+98xwf1Qw==
X-Google-Smtp-Source: AGHT+IHzYgqs3czfHi9TUe+XjVxtymPLEuPraVXhzzefQN990N6MTWsYw621jQGlFwXhMX1kr/DaXA==
X-Received: by 2002:a05:6a20:3948:b0:13f:8153:7e31 with SMTP id
 r8-20020a056a20394800b0013f81537e31mr15094082pzg.20.1692862089204; 
 Thu, 24 Aug 2023 00:28:09 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a170902ce8900b001ae0a4b1d3fsm12029298plg.153.2023.08.24.00.28.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Aug 2023 00:28:08 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <C6558A0B-3BF3-4AE1-8E73-0085FD82568B@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_3B86AF78-50CF-41FF-A914-92ABB6BB5759"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 1/2] vhost-user: fix lost reconnect
Date: Thu, 24 Aug 2023 15:27:55 +0800
In-Reply-To: <EBB49CB4-E0AE-4131-9A66-0C50D06E60CB@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-2-fengli@smartx.com>
 <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
 <F0FCF1EC-8E24-4515-A800-BD01D9D3D526@smartx.com>
 <2D662C4C-B636-453A-B2D0-F4EDA4B43041@nutanix.com>
 <CAHckoCxZFe78ghhuxrxF-SzO4XHvAOry993f-rH+kFdK6OPE0w@mail.gmail.com>
 <EBB49CB4-E0AE-4131-9A66-0C50D06E60CB@nutanix.com>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_3B86AF78-50CF-41FF-A914-92ABB6BB5759
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 22 Aug 2023, at 6:17 PM, Raphael Norwitz =
<raphael.norwitz@nutanix.com> wrote:
>=20
>=20
>=20
>> On Aug 22, 2023, at 12:49 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>>=20
>>=20
>>> On 22 Aug 2023, at 8:38 AM, Raphael Norwitz =
<raphael.norwitz@nutanix.com> wrote:
>>>=20
>>>>=20
>>>> On Aug 17, 2023, at 2:40 AM, Li Feng <fengli@smartx.com> wrote:
>>>>=20
>>>>=20
>>>>> 2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRa=
phael Norwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>> Why can=E2=80=99t we rather fix this by adding a =E2=80=9Cevent_cb=E2=
=80=9D param to vhost_user_async_close and then call =
qemu_chr_fe_set_handlers in vhost_user_async_close_bh()?
>>>>>=20
>>>>> Even if calling vhost_dev_cleanup() twice is safe today I worry =
future changes may easily stumble over the reconnect case and introduce =
crashes or double frees.
>>>>>=20
>>>> I think add a new event_cb is not good enough. =
=E2=80=98qemu_chr_fe_set_handlers=E2=80=99 has been called in =
vhost_user_async_close, and will be called in event->cb, so why need add =
a
>>>> new event_cb?
>>>>=20
>>>=20
>>> I=E2=80=99m suggesting calling the data->event_cb instead of the =
data->cb if we hit the error case where vhost->vdev is NULL. Something =
like:
>>>=20
>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>> index 8dcf049d42..edf1dccd44 100644
>>> --- a/hw/virtio/vhost-user.c
>>> +++ b/hw/virtio/vhost-user.c
>>> @@ -2648,6 +2648,10 @@ typedef struct {
>>> static void vhost_user_async_close_bh(void *opaque)
>>> {
>>>    VhostAsyncCallback *data =3D opaque;
>>> +
>>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(data->dev);
>>> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>> +
>>>    struct vhost_dev *vhost =3D data->vhost;
>>>=20
>>>    /*
>>> @@ -2657,6 +2661,9 @@ static void vhost_user_async_close_bh(void =
*opaque)
>>>     */
>>>    if (vhost->vdev) {
>>>        data->cb(data->dev);
>>> +    } else if (data->event_cb) {
>>> +        qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, =
data->event_cb,
>>> +                                 NULL, data->dev, NULL, true);
>>>    }
>>>=20
>>>    g_free(data);
>>>=20
>>> data->event_cb would be vhost_user_blk_event().
>>>=20
>>> I think that makes the error path a lot easier to reason about and =
more future proof.
>>>=20
>>>> For avoiding to call the vhost_dev_cleanup() twice, add a =
=E2=80=98inited=E2=80=99 in struct vhost-dev to mark if it=E2=80=99s =
inited like this:
>>>>=20
>>>=20
>>> This is better than the original, but let me know what you think of =
my alternative.
>>=20
>> The vhost_user_async_close_bh() is a common function in vhost-user.c, =
and vhost_user_async_close() is used by vhost-user-scsi/blk/gpio,=20
>> However, in your patch it=E2=80=99s limited to VhostUserBlk, so I =
think my fix is more reasonable.
>=20
> I did not write out the full patch.=20
>=20
> vhost-user-scsi/blk/gpio would each provide their own ->event_cb, just =
like they each provide a different ->cb today. Looking at it again, data =
has the chardev, so no need to use VIRTO_DEVICE() or VHOST_USER_BLK().
>=20
> The fix generalizes to all device types.
OK, I will change it in V2.
>=20
>>=20
>> Thanks,
>> LI
>>>=20
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index e2f6ffb446..edc80c0231 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -1502,6 +1502,7 @@ int vhost_dev_init(struct vhost_dev *hdev, =
void *opaque,
>>>>       goto fail_busyloop;
>>>>   }
>>>>=20
>>>> +    hdev->inited =3D true;
>>>>   return 0;
>>>>=20
>>>> fail_busyloop:
>>>> @@ -1520,6 +1521,10 @@ void vhost_dev_cleanup(struct vhost_dev =
*hdev)
>>>> {
>>>>   int i;
>>>>=20
>>>> +    if (!hdev->inited) {
>>>> +        return;
>>>> +    }
>>>> +    hdev->inited =3D false;
>>>>   trace_vhost_dev_cleanup(hdev);
>>>>=20
>>>>   for (i =3D 0; i < hdev->nvqs; ++i) {
>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>>>> index ca3131b1af..74b1aec960 100644
>>>> --- a/include/hw/virtio/vhost.h
>>>> +++ b/include/hw/virtio/vhost.h
>>>> @@ -123,6 +123,7 @@ struct vhost_dev {
>>>>   /* @started: is the vhost device started? */
>>>>   bool started;
>>>>   bool log_enabled;
>>>> +    bool inited;
>>>>   uint64_t log_size;
>>>>   Error *migration_blocker;
>>>>   const VhostOps *vhost_ops;
>>>>=20
>>>> Thanks.
>>>>=20
>>>>>=20
>>>>>> On Aug 4, 2023, at 1:29 AM, Li Feng <fengli@smartx.com> wrote:
>>>>>>=20
>>>>>> When the vhost-user is reconnecting to the backend, and if the =
vhost-user fails
>>>>>> at the get_features in vhost_dev_init(), then the reconnect will =
fail
>>>>>> and it will not be retriggered forever.
>>>>>>=20
>>>>>> The reason is:
>>>>>> When the vhost-user fail at get_features, the vhost_dev_cleanup =
will be called
>>>>>> immediately.
>>>>>>=20
>>>>>> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct =
vhost_dev))'.
>>>>>>=20
>>>>>> The reconnect path is:
>>>>>> vhost_user_blk_event
>>>>>> vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>>>>>> qemu_chr_fe_set_handlers <----- clear the notifier callback
>>>>>>   schedule vhost_user_async_close_bh
>>>>>>=20
>>>>>> The vhost->vdev is null, so the vhost_user_blk_disconnect will =
not be
>>>>>> called, then the event fd callback will not be reinstalled.
>>>>>>=20
>>>>>> With this patch, the vhost_user_blk_disconnect will call the
>>>>>> vhost_dev_cleanup() again, it's safe.
>>>>>>=20
>>>>>> All vhost-user devices have this issue, including =
vhost-user-blk/scsi.
>>>>>>=20
>>>>>> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED =
handling")
>>>>>>=20
>>>>>> Signed-off-by: Li Feng <fengli@smartx.com>
>>>>>> ---
>>>>>> hw/virtio/vhost-user.c | 10 +---------
>>>>>> 1 file changed, 1 insertion(+), 9 deletions(-)
>>>>>>=20
>>>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>>>> index 8dcf049d42..697b403fe2 100644
>>>>>> --- a/hw/virtio/vhost-user.c
>>>>>> +++ b/hw/virtio/vhost-user.c
>>>>>> @@ -2648,16 +2648,8 @@ typedef struct {
>>>>>> static void vhost_user_async_close_bh(void *opaque)
>>>>>> {
>>>>>> VhostAsyncCallback *data =3D opaque;
>>>>>> -    struct vhost_dev *vhost =3D data->vhost;
>>>>>>=20
>>>>>> -    /*
>>>>>> -     * If the vhost_dev has been cleared in the meantime there =
is
>>>>>> -     * nothing left to do as some other path has completed the
>>>>>> -     * cleanup.
>>>>>> -     */
>>>>>> -    if (vhost->vdev) {
>>>>>> -        data->cb(data->dev);
>>>>>> -    }
>>>>>> +    data->cb(data->dev);
>>>>>>=20
>>>>>> g_free(data);
>>>>>> }
>>>>>> --=20
>>>>>> 2.41.0


--Apple-Mail=_3B86AF78-50CF-41FF-A914-92ABB6BB5759
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote type=3D"cite"><div>On 22 =
Aug 2023, at 6:17 PM, Raphael Norwitz =
&lt;raphael.norwitz@nutanix.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Monaco; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;">On Aug 22, =
2023, at 12:49 AM, Li Feng &lt;fengli@smartx.com&gt; =
wrote:<br><br><br><br><blockquote type=3D"cite">On 22 Aug 2023, at 8:38 =
AM, Raphael Norwitz &lt;raphael.norwitz@nutanix.com&gt; =
wrote:<br><br><blockquote type=3D"cite"><br>On Aug 17, 2023, at 2:40 AM, =
Li Feng &lt;fengli@smartx.com&gt; wrote:<br><br><br><blockquote =
type=3D"cite">2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=
=BC=8CRaphael Norwitz &lt;raphael.norwitz@nutanix.com&gt; =
=E5=86=99=E9=81=93=EF=BC=9A<br><br>Why can=E2=80=99t we rather fix this =
by adding a =E2=80=9Cevent_cb=E2=80=9D param to vhost_user_async_close =
and then call qemu_chr_fe_set_handlers in =
vhost_user_async_close_bh()?<br><br>Even if calling vhost_dev_cleanup() =
twice is safe today I worry future changes may easily stumble over the =
reconnect case and introduce crashes or double =
frees.<br><br></blockquote>I think add a new event_cb is not good =
enough. =E2=80=98qemu_chr_fe_set_handlers=E2=80=99 has been called in =
vhost_user_async_close, and will be called in event-&gt;cb, so why need =
add a<br>new event_cb?<br><br></blockquote><br>I=E2=80=99m suggesting =
calling the data-&gt;event_cb instead of the data-&gt;cb if we hit the =
error case where vhost-&gt;vdev is NULL. Something like:<br><br>diff =
--git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>index =
8dcf049d42..edf1dccd44 100644<br>--- a/hw/virtio/vhost-user.c<br>+++ =
b/hw/virtio/vhost-user.c<br>@@ -2648,6 +2648,10 @@ typedef struct =
{<br>static void vhost_user_async_close_bh(void =
*opaque)<br>{<br>&nbsp;&nbsp;&nbsp;VhostAsyncCallback *data =3D =
opaque;<br>+<br>+ &nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D =
VIRTIO_DEVICE(data-&gt;dev);<br>+ &nbsp;&nbsp;&nbsp;VHostUserBlk *s =3D =
VHOST_USER_BLK(vdev);<br>+<br>&nbsp;&nbsp;&nbsp;struct vhost_dev *vhost =
=3D data-&gt;vhost;<br><br>&nbsp;&nbsp;&nbsp;/*<br>@@ -2657,6 +2661,9 @@ =
static void vhost_user_async_close_bh(void =
*opaque)<br>&nbsp;&nbsp;&nbsp;&nbsp;*/<br>&nbsp;&nbsp;&nbsp;if =
(vhost-&gt;vdev) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;data-&gt;cb(data-&gt;dev);<=
br>+ &nbsp;&nbsp;&nbsp;} else if (data-&gt;event_cb) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;s-=
&gt;chardev, NULL, NULL, data-&gt;event_cb,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NULL, data-&gt;dev, NULL, =
true);<br>&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;g_free(data);<br><b=
r>data-&gt;event_cb would be vhost_user_blk_event().<br><br>I think that =
makes the error path a lot easier to reason about and more future =
proof.<br><br><blockquote type=3D"cite">For avoiding to call the =
vhost_dev_cleanup() twice, add a =E2=80=98inited=E2=80=99 in struct =
vhost-dev to mark if it=E2=80=99s inited like =
this:<br><br></blockquote><br>This is better than the original, but let =
me know what you think of my alternative.<br></blockquote><br>The =
vhost_user_async_close_bh() is a common function in vhost-user.c, and =
vhost_user_async_close() is used by vhost-user-scsi/blk/gpio,<span =
class=3D"Apple-converted-space">&nbsp;</span><br>However, in your patch =
it=E2=80=99s limited to VhostUserBlk, so I think my fix is more =
reasonable.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I did =
not write out the full patch.<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">vhost-user-scsi/blk/gpio would each provide =
their own -&gt;event_cb, just like they each provide a different -&gt;cb =
today. Looking at it again, data has the chardev, so no need to use =
VIRTO_DEVICE() or VHOST_USER_BLK().</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">The fix =
generalizes to all device types.</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote>OK, I will change it in =
V2.<br><blockquote type=3D"cite"><div><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br>Thanks,<br>LI<br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">diff --git =
a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>index e2f6ffb446..edc80c0231 =
100644<br>--- a/hw/virtio/vhost.c<br>+++ b/hw/virtio/vhost.c<br>@@ =
-1502,6 +1502,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void =
*opaque,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
fail_busyloop;<br>&nbsp;&nbsp;}<br><br>+ =
&nbsp;&nbsp;&nbsp;hdev-&gt;inited =3D true;<br>&nbsp;&nbsp;return =
0;<br><br>fail_busyloop:<br>@@ -1520,6 +1521,10 @@ void =
vhost_dev_cleanup(struct vhost_dev *hdev)<br>{<br>&nbsp;&nbsp;int =
i;<br><br>+ &nbsp;&nbsp;&nbsp;if (!hdev-&gt;inited) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;hdev-&gt;inited =3D =
false;<br>&nbsp;&nbsp;trace_vhost_dev_cleanup(hdev);<br><br>&nbsp;&nbsp;fo=
r (i =3D 0; i &lt; hdev-&gt;nvqs; ++i) {<br>diff --git =
a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h<br>index =
ca3131b1af..74b1aec960 100644<br>--- a/include/hw/virtio/vhost.h<br>+++ =
b/include/hw/virtio/vhost.h<br>@@ -123,6 +123,7 @@ struct vhost_dev =
{<br>&nbsp;&nbsp;/* @started: is the vhost device started? =
*/<br>&nbsp;&nbsp;bool started;<br>&nbsp;&nbsp;bool log_enabled;<br>+ =
&nbsp;&nbsp;&nbsp;bool inited;<br>&nbsp;&nbsp;uint64_t =
log_size;<br>&nbsp;&nbsp;Error *migration_blocker;<br>&nbsp;&nbsp;const =
VhostOps *vhost_ops;<br><br>Thanks.<br><br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">On Aug 4, 2023, at 1:29 AM, =
Li Feng &lt;fengli@smartx.com&gt; wrote:<br><br>When the vhost-user is =
reconnecting to the backend, and if the vhost-user fails<br>at the =
get_features in vhost_dev_init(), then the reconnect will fail<br>and it =
will not be retriggered forever.<br><br>The reason is:<br>When the =
vhost-user fail at get_features, the vhost_dev_cleanup will be =
called<br>immediately.<br><br>vhost_dev_cleanup calls 'memset(hdev, 0, =
sizeof(struct vhost_dev))'.<br><br>The reconnect path =
is:<br>vhost_user_blk_event<br>vhost_user_async_close(.. =
vhost_user_blk_disconnect ..)<br>qemu_chr_fe_set_handlers &lt;----- =
clear the notifier callback<br>&nbsp;&nbsp;schedule =
vhost_user_async_close_bh<br><br>The vhost-&gt;vdev is null, so the =
vhost_user_blk_disconnect will not be<br>called, then the event fd =
callback will not be reinstalled.<br><br>With this patch, the =
vhost_user_blk_disconnect will call the<br>vhost_dev_cleanup() again, =
it's safe.<br><br>All vhost-user devices have this issue, including =
vhost-user-blk/scsi.<br><br>Fixes: 71e076a07d ("hw/virtio: generalise =
CHR_EVENT_CLOSED handling")<br><br>Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/virtio/vhost-user.c | 10 =
+---------<br>1 file changed, 1 insertion(+), 9 deletions(-)<br><br>diff =
--git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>index =
8dcf049d42..697b403fe2 100644<br>--- a/hw/virtio/vhost-user.c<br>+++ =
b/hw/virtio/vhost-user.c<br>@@ -2648,16 +2648,8 @@ typedef struct =
{<br>static void vhost_user_async_close_bh(void =
*opaque)<br>{<br>VhostAsyncCallback *data =3D opaque;<br>- =
&nbsp;&nbsp;&nbsp;struct vhost_dev *vhost =3D data-&gt;vhost;<br><br>- =
&nbsp;&nbsp;&nbsp;/*<br>- &nbsp;&nbsp;&nbsp;&nbsp;* If the vhost_dev has =
been cleared in the meantime there is<br>- &nbsp;&nbsp;&nbsp;&nbsp;* =
nothing left to do as some other path has completed the<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;* cleanup.<br>- &nbsp;&nbsp;&nbsp;&nbsp;*/<br>- =
&nbsp;&nbsp;&nbsp;if (vhost-&gt;vdev) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;data-&gt;cb(data-&gt;dev);<br>- =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;data-&gt;cb(data-&gt;dev);<br><br>g_free(data);<br>}<br>=
--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></bloc=
kquote></blockquote></blockquote></blockquote></div></blockquote></div><br=
></body></html>=

--Apple-Mail=_3B86AF78-50CF-41FF-A914-92ABB6BB5759--


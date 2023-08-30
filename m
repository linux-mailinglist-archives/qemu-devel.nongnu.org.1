Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 952D578D2DE
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 06:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbDDK-0006qq-Li; Wed, 30 Aug 2023 00:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDDI-0006qS-Ee
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:53:56 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDD8-00030H-7X
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:53:56 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5694ee2d0edso2160167a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693371101; x=1693975901;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=baWE9tl7df3F/zNSyaQaPOJMOot/BWCbFpgiP6BcqAw=;
 b=W2hg37vbBBoccL/pxOH4+RbdKjheBu//6OCiQxJADGQ5soz/ostWNDLOdJnIxUsaWS
 SvM5PIaQ3VFp2xeoSZK8QF738vFDHJqviOSxkduRSywtZqmhJjRotQ5RRrrRndu9asSw
 Oz3ErmWqMyuLGYc/TYneL6W6/CbqzP577B83POPC3+slu/vX8vUNz0Fjh8dTkZqAzAld
 dA5R8KQyl23wkxCXHX2oZdfZvZ+EOp6BdyqLCbovZzgQGyT2hg/1XlYdeFzgePzqrL8C
 Ztc4MC27AKhY6e5xk01LRCy5yUQu6XefjZKGH53C36n3JG6mrV58j5aMkOLHAG3X4aM7
 2K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693371101; x=1693975901;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=baWE9tl7df3F/zNSyaQaPOJMOot/BWCbFpgiP6BcqAw=;
 b=URWOsJKT66aEAQF39qpGcuEp3vyxfxFhi0MU70NBeID2g+/St2w3Z39PSq7gobqf0L
 mPbvXFk3SGLDs6lJGduw+eJvw3YxuJVbaoUVbr4AQorF2q7slLNO+A+CToAHysq+QNR+
 lh9Rlq9dPej6rmoR3+shlAbZZ00n4+ugaKVR5FdBA3bNRR+8EAFZEuTUDhXtrRYLcfUr
 UVZuX8x5V10/2fXQzFXycDQhey0TR/nk0kekOVX0beEsyUwxq+nmuo5cc33nA0HmbQfI
 RRDgwsnoEh0tl+iLacjC1NmYIJPYBkjdE2E3ZD0eZi0gGcK3FquFQUKXEHwbEGGuKQX9
 nGeg==
X-Gm-Message-State: AOJu0YxegDjCySGo5x93hlXG2I91s/v8yMUyE62ua7RSF9fgknVvBskm
 BTSDvps2rZbzIJgfs1qdlRSoMg==
X-Google-Smtp-Source: AGHT+IF6oysGRNXlSdKPp75ImXbjWtNfU6Iulz5wbuzpRKu0sTGa1tBU+vk/leUNVqREciM6K68SSg==
X-Received: by 2002:a05:6a20:2444:b0:14d:29f6:18c3 with SMTP id
 t4-20020a056a20244400b0014d29f618c3mr1398559pzc.20.1693371101020; 
 Tue, 29 Aug 2023 21:51:41 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a170902ee0500b001b03f208323sm242900plb.64.2023.08.29.21.51.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Aug 2023 21:51:40 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <93D7CACD-ABAB-40BB-8491-88324AC08729@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_E364CD9E-78A3-4CC3-9EA7-D9780F764BE9"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 1/2] vhost-user: Fix lost reconnect
Date: Wed, 30 Aug 2023 12:51:34 +0800
In-Reply-To: <C8126682-6FA5-4511-80B9-289EF83EB59F@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230824074115.93897-1-fengli@smartx.com>
 <20230824074115.93897-2-fengli@smartx.com>
 <C8126682-6FA5-4511-80B9-289EF83EB59F@nutanix.com>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_E364CD9E-78A3-4CC3-9EA7-D9780F764BE9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 30 Aug 2023, at 6:11 AM, Raphael Norwitz =
<raphael.norwitz@nutanix.com> wrote:
>=20
>=20
>=20
>> On Aug 24, 2023, at 3:41 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>> When the vhost-user is reconnecting to the backend, and if the =
vhost-user fails
>> at the get_features in vhost_dev_init(), then the reconnect will fail
>> and it will not be retriggered forever.
>>=20
>> The reason is:
>> When the vhost-user fails at get_features, the vhost_dev_cleanup will =
be called
>> immediately.
>>=20
>> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.
>>=20
>> The reconnect path is:
>> vhost_user_blk_event
>>  vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>>    qemu_chr_fe_set_handlers <----- clear the notifier callback
>>      schedule vhost_user_async_close_bh
>>=20
>> The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
>> called, then the event fd callback will not be reinstalled.
>>=20
>> All vhost-user devices have this issue, including =
vhost-user-blk/scsi.
>>=20
>> With this patch, if the vdev->vdev is null, the fd callback will =
still
>> be reinstalled.
>>=20
>> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>>=20
>=20
> A couple of NITs, otherwise LGTM
>=20
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com =
<mailto:raphael.norwitz@nutanix.com>>
>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/block/vhost-user-blk.c      |  2 +-
>> hw/scsi/vhost-user-scsi.c      |  3 ++-
>> hw/virtio/vhost-user-gpio.c    |  2 +-
>> hw/virtio/vhost-user.c         | 10 ++++++++--
>> include/hw/virtio/vhost-user.h |  4 +++-
>> 5 files changed, 15 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 3c69fa47d5..95c758200d 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -391,7 +391,7 @@ static void vhost_user_blk_event(void *opaque, =
QEMUChrEvent event)
>>    case CHR_EVENT_CLOSED:
>>        /* defer close until later to avoid circular close */
>>        vhost_user_async_close(dev, &s->chardev, &s->dev,
>> -                               vhost_user_blk_disconnect);
>> +                               vhost_user_blk_disconnect, =
vhost_user_blk_event);
>>        break;
>>    case CHR_EVENT_BREAK:
>>    case CHR_EVENT_MUX_IN:
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index a7fa8e8df2..e931df9f5b 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -236,7 +236,8 @@ static void vhost_user_scsi_event(void *opaque, =
QEMUChrEvent event)
>>    case CHR_EVENT_CLOSED:
>>        /* defer close until later to avoid circular close */
>>        vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
>> -                               vhost_user_scsi_disconnect);
>> +                               vhost_user_scsi_disconnect,
>> +                               vhost_user_scsi_event);
>>        break;
>>    case CHR_EVENT_BREAK:
>>    case CHR_EVENT_MUX_IN:
>> diff --git a/hw/virtio/vhost-user-gpio.c =
b/hw/virtio/vhost-user-gpio.c
>> index d9979aa5db..04c2cc79f4 100644
>> --- a/hw/virtio/vhost-user-gpio.c
>> +++ b/hw/virtio/vhost-user-gpio.c
>> @@ -283,7 +283,7 @@ static void vu_gpio_event(void *opaque, =
QEMUChrEvent event)
>>    case CHR_EVENT_CLOSED:
>>        /* defer close until later to avoid circular close */
>>        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
>> -                               vu_gpio_disconnect);
>> +                               vu_gpio_disconnect, vu_gpio_event);
>>        break;
>>    case CHR_EVENT_BREAK:
>>    case CHR_EVENT_MUX_IN:
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 8dcf049d42..9540766dd3 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2643,6 +2643,7 @@ typedef struct {
>>    DeviceState *dev;
>>    CharBackend *cd;
>>    struct vhost_dev *vhost;
>> +    IOEventHandler *event_cb;
>> } VhostAsyncCallback;
>>=20
>> static void vhost_user_async_close_bh(void *opaque)
>> @@ -2657,7 +2658,10 @@ static void vhost_user_async_close_bh(void =
*opaque)
>>     */
>>    if (vhost->vdev) {
>>        data->cb(data->dev);
>> -    }
>> +    } else if (data->event_cb) {
>> +        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, =
data->event_cb,
>> +                                 NULL, data->dev, NULL, true);
>> +   }
>>=20
>>    g_free(data);
>> }
>> @@ -2669,7 +2673,9 @@ static void vhost_user_async_close_bh(void =
*opaque)
>> */
>> void vhost_user_async_close(DeviceState *d,
>>                            CharBackend *chardev, struct vhost_dev =
*vhost,
>> -                            vu_async_close_fn cb)
>> +                            vu_async_close_fn cb,
>> +                            IOEventHandler *event_cb
>=20
> Nit: why the newline before the closing parenthesis?
Acked.

>=20
>> +                            )
>> {
>>    if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>>        /*
>> diff --git a/include/hw/virtio/vhost-user.h =
b/include/hw/virtio/vhost-user.h
>> index 191216a74f..5fdc711d4e 100644
>> --- a/include/hw/virtio/vhost-user.h
>> +++ b/include/hw/virtio/vhost-user.h
>> @@ -84,6 +84,8 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
>>=20
>> void vhost_user_async_close(DeviceState *d,
>>                            CharBackend *chardev, struct vhost_dev =
*vhost,
>> -                            vu_async_close_fn cb);
>> +                            vu_async_close_fn cb,
>> +                            IOEventHandler *event_cb
>=20
> Nit: ditto - don=E2=80=99t think we need this newline before );
Acked.
>=20
>> +                            );
>>=20
>> #endif
>> --=20
>> 2.41.0


--Apple-Mail=_E364CD9E-78A3-4CC3-9EA7-D9780F764BE9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote type=3D"cite"><div>On 30 =
Aug 2023, at 6:11 AM, Raphael Norwitz =
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
0px; -webkit-text-stroke-width: 0px; text-decoration: none;">On Aug 24, =
2023, at 3:41 AM, Li Feng &lt;fengli@smartx.com&gt; wrote:<br><br>When =
the vhost-user is reconnecting to the backend, and if the vhost-user =
fails<br>at the get_features in vhost_dev_init(), then the reconnect =
will fail<br>and it will not be retriggered forever.<br><br>The reason =
is:<br>When the vhost-user fails at get_features, the vhost_dev_cleanup =
will be called<br>immediately.<br><br>vhost_dev_cleanup calls =
'memset(hdev, 0, sizeof(struct vhost_dev))'.<br><br>The reconnect path =
is:<br>vhost_user_blk_event<br>&nbsp;vhost_user_async_close(.. =
vhost_user_blk_disconnect =
..)<br>&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers &lt;----- clear the =
notifier callback<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;schedule =
vhost_user_async_close_bh<br><br>The vhost-&gt;vdev is null, so the =
vhost_user_blk_disconnect will not be<br>called, then the event fd =
callback will not be reinstalled.<br><br>All vhost-user devices have =
this issue, including vhost-user-blk/scsi.<br><br>With this patch, if =
the vdev-&gt;vdev is null, the fd callback will still<br>be =
reinstalled.<br><br>Fixes: 71e076a07d ("hw/virtio: generalise =
CHR_EVENT_CLOSED handling")<br><br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">A =
couple of NITs, otherwise LGTM</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Monaco; font-size: 12px; font-style: normal; =
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
text-decoration: none; float: none; display: inline =
!important;">Reviewed-by: Raphael Norwitz &lt;</span><a =
href=3D"mailto:raphael.norwitz@nutanix.com" style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">raphael.norwitz@nutanix.com</a><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/block/vhost-user-blk.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;2 +-<br>hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;3 =
++-<br>hw/virtio/vhost-user-gpio.c &nbsp;&nbsp;&nbsp;| &nbsp;2 =
+-<br>hw/virtio/vhost-user.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 10 =
++++++++--<br>include/hw/virtio/vhost-user.h | &nbsp;4 +++-<br>5 files =
changed, 15 insertions(+), 6 deletions(-)<br><br>diff --git =
a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c<br>index =
3c69fa47d5..95c758200d 100644<br>--- a/hw/block/vhost-user-blk.c<br>+++ =
b/hw/block/vhost-user-blk.c<br>@@ -391,7 +391,7 @@ static void =
vhost_user_blk_event(void *opaque, QEMUChrEvent =
event)<br>&nbsp;&nbsp;&nbsp;case =
CHR_EVENT_CLOSED:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* defer =
close until later to avoid circular close =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_async_close(dev=
, &amp;s-&gt;chardev, &amp;s-&gt;dev,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_blk_disconnect);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_blk_disconnect, =
vhost_user_blk_event);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;=
<br>&nbsp;&nbsp;&nbsp;case CHR_EVENT_BREAK:<br>&nbsp;&nbsp;&nbsp;case =
CHR_EVENT_MUX_IN:<br>diff --git a/hw/scsi/vhost-user-scsi.c =
b/hw/scsi/vhost-user-scsi.c<br>index a7fa8e8df2..e931df9f5b =
100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -236,7 +236,8 @@ static void =
vhost_user_scsi_event(void *opaque, QEMUChrEvent =
event)<br>&nbsp;&nbsp;&nbsp;case =
CHR_EVENT_CLOSED:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* defer =
close until later to avoid circular close =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_async_close(dev=
, &amp;vs-&gt;conf.chardev, &amp;vsc-&gt;dev,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_disconnect);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_disconnect,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_event);<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>&nbsp;&nbsp;&nbsp;case =
CHR_EVENT_BREAK:<br>&nbsp;&nbsp;&nbsp;case CHR_EVENT_MUX_IN:<br>diff =
--git a/hw/virtio/vhost-user-gpio.c =
b/hw/virtio/vhost-user-gpio.c<br>index d9979aa5db..04c2cc79f4 =
100644<br>--- a/hw/virtio/vhost-user-gpio.c<br>+++ =
b/hw/virtio/vhost-user-gpio.c<br>@@ -283,7 +283,7 @@ static void =
vu_gpio_event(void *opaque, QEMUChrEvent =
event)<br>&nbsp;&nbsp;&nbsp;case =
CHR_EVENT_CLOSED:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* defer =
close until later to avoid circular close =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_async_close(dev=
, &amp;gpio-&gt;chardev, &amp;gpio-&gt;vhost_dev,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vu_gpio_disconnect);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vu_gpio_disconnect, =
vu_gpio_event);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>&nb=
sp;&nbsp;&nbsp;case CHR_EVENT_BREAK:<br>&nbsp;&nbsp;&nbsp;case =
CHR_EVENT_MUX_IN:<br>diff --git a/hw/virtio/vhost-user.c =
b/hw/virtio/vhost-user.c<br>index 8dcf049d42..9540766dd3 100644<br>--- =
a/hw/virtio/vhost-user.c<br>+++ b/hw/virtio/vhost-user.c<br>@@ -2643,6 =
+2643,7 @@ typedef struct {<br>&nbsp;&nbsp;&nbsp;DeviceState =
*dev;<br>&nbsp;&nbsp;&nbsp;CharBackend *cd;<br>&nbsp;&nbsp;&nbsp;struct =
vhost_dev *vhost;<br>+ &nbsp;&nbsp;&nbsp;IOEventHandler *event_cb;<br>} =
VhostAsyncCallback;<br><br>static void vhost_user_async_close_bh(void =
*opaque)<br>@@ -2657,7 +2658,10 @@ static void =
vhost_user_async_close_bh(void =
*opaque)<br>&nbsp;&nbsp;&nbsp;&nbsp;*/<br>&nbsp;&nbsp;&nbsp;if =
(vhost-&gt;vdev) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;data-&gt;cb(data-&gt;dev);<=
br>- &nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;} else if =
(data-&gt;event_cb) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(data-&g=
t;cd, NULL, NULL, data-&gt;event_cb,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NULL, data-&gt;dev, NULL, =
true);<br>+ =
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;g_free(data);<br>}<br>@@ -2669,7 =
+2673,9 @@ static void vhost_user_async_close_bh(void =
*opaque)<br>*/<br>void vhost_user_async_close(DeviceState =
*d,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;CharBackend *chardev, struct vhost_dev *vhost,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;vu_async_close_fn cb)<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;vu_async_close_fn cb,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;IOEventHandler *event_cb<br></blockquote><br =
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
display: inline !important;">Nit: why the newline before the closing =
parenthesis?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>Acked.</div><div><br><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;)<br>{<br>&nbsp;&nbsp;&nbsp;if =
(!runstate_check(RUN_STATE_SHUTDOWN)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>diff --git =
a/include/hw/virtio/vhost-user.h =
b/include/hw/virtio/vhost-user.h<br>index 191216a74f..5fdc711d4e =
100644<br>--- a/include/hw/virtio/vhost-user.h<br>+++ =
b/include/hw/virtio/vhost-user.h<br>@@ -84,6 +84,8 @@ typedef void =
(*vu_async_close_fn)(DeviceState *cb);<br><br>void =
vhost_user_async_close(DeviceState =
*d,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;CharBackend *chardev, struct vhost_dev *vhost,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;vu_async_close_fn cb);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;vu_async_close_fn cb,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;IOEventHandler *event_cb<br></blockquote><br =
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
display: inline !important;">Nit: ditto - don=E2=80=99t think we need =
this newline before );</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote>Acked.<br><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;);<br><br>#endif<br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></div>=
</blockquote></div><br></body></html>=

--Apple-Mail=_E364CD9E-78A3-4CC3-9EA7-D9780F764BE9--


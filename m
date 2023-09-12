Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3279C8C2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfyEk-0002iq-NM; Tue, 12 Sep 2023 03:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfyEh-0002iZ-98
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:55:03 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfyEc-0008Na-PU
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:55:02 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-26f57f02442so3729522a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694505174; x=1695109974;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=apyVjfda1HbLm+xMWAmTY/C9TvKlW5L5forlTKvmJUk=;
 b=NYeDAeLYCNLXzoZbtC8gUiAvo15JrQ85Yb9aGb4piY0Ccsh0Rrrni42szyqyDx3cuw
 BaEVBg9qRLTw5BkxSO/gCEn0ryc/OdYbXxp8424hoXDwe1mKFbjN/t/knPbOkugYeXsA
 M8PfhfKu/eZpvzhMcPxpL0y0yDeYz+OaNUklrolQxDFLsWxO80S8Ee1Da1mrKy7MKZex
 r/ZjpEH4VEeERV9cW+h6G8aIkfBNCxuDnY4AwMq8W7DGNohES33Em17PJeeBQnCLC7Dx
 5OzxbbLWpHBx9IiEpQKrW4G5lpf/JQyUC3BYp3J/fUjlYMX9GOlZjsaUP7bMi6M8Ckiw
 qwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694505174; x=1695109974;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=apyVjfda1HbLm+xMWAmTY/C9TvKlW5L5forlTKvmJUk=;
 b=uX1rp4bGWcFEyxXtRgcFryo6K7E76o928b5WX18dVSNPqZszzfqsVzck/ogo6uqWQq
 FbvNpGeg5SHMAz9xELfhND252s/8gGMLoFPvnPZWuNpNF86oVlGwAnpBxlFxoS5WX3NN
 CGMz6ZBzJmVDPHiVvoXU/glct+oEKMm2fmvAYeTIAH+DG3txl1RwYPWHWV/HfMrbp05G
 44X1jo+iXK31EDGpeEXc0pN17Lpqewprg81GC7AGJxC2cY9I0LKrOfMt0eLAVQcUlmsO
 dNAOxZygAcPP3ZaGXPPfbOq/6kqZseHasg2MwfngY8xBKiz3KSva547WFXYuzwJjXNdE
 A1/Q==
X-Gm-Message-State: AOJu0Yy9cZzclI4fzqZRajQKOg70/w8nuGPUX5Cu3PuZhZfq8mytu3H1
 9m1GiRgKEKfcnrg9mzbiMYcHyA==
X-Google-Smtp-Source: AGHT+IHJq2HRW3aUY0bGELfYqEpAN1QRTubSYp6Aa5GumRZZIyIN+wJF7RDu0N3reuGW6Y3QzCB/NQ==
X-Received: by 2002:a17:90a:c246:b0:263:ebab:a152 with SMTP id
 d6-20020a17090ac24600b00263ebaba152mr9399685pjx.19.1694505173446; 
 Tue, 12 Sep 2023 00:52:53 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 k92-20020a17090a4ce500b00267d9f4d340sm9281045pjh.44.2023.09.12.00.52.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Sep 2023 00:52:52 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <B76BE374-5FFC-4805-B985-CA61AAEE3C62@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_95C061BD-D7ED-49F0-8258-280653F57B60"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 5/5] vhost-user-scsi: start vhost when guest kicks
Date: Tue, 12 Sep 2023 15:53:00 +0800
In-Reply-To: <87zg2686ex.fsf@pond.sub.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Markus Armbruster <armbru@redhat.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
 <20230731121018.2856310-6-fengli@smartx.com> <87zg2686ex.fsf@pond.sub.org>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1031.google.com
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


--Apple-Mail=_95C061BD-D7ED-49F0-8258-280653F57B60
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 1 Sep 2023, at 7:44 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Li Feng <fengli@smartx.com <mailto:fengli@smartx.com>> writes:
>=20
>> Let's keep the same behavior as vhost-user-blk.
>>=20
>> Some old guests kick virtqueue before setting =
VIRTIO_CONFIG_S_DRIVER_OK.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/scsi/vhost-user-scsi.c | 48 =
+++++++++++++++++++++++++++++++++++----
>> 1 file changed, 44 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index 5bf012461b..a7fa8e8df2 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -113,8 +113,48 @@ static void vhost_user_scsi_reset(VirtIODevice =
*vdev)
>>     }
>> }
>>=20
>> -static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)
>> +static void vhost_user_scsi_handle_output(VirtIODevice *vdev, =
VirtQueue *vq)
>> {
>> +    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +
>> +    Error *local_err =3D NULL;
>> +    int i, ret;
>> +
>> +    if (!vdev->start_on_kick) {
>> +        return;
>> +    }
>> +
>> +    if (!s->connected) {
>> +        return;
>> +    }
>> +
>> +    if (vhost_dev_is_started(&vsc->dev)) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so =
start
>> +     * vhost here instead of waiting for .set_status().
>> +     */
>> +    ret =3D vhost_user_scsi_start(s);
>> +    if (ret < 0) {
>> +        error_reportf_err(local_err, "vhost-user-scsi: vhost start =
failed: ");
>=20
> Crashes, since @local_err is null.  Please test your error paths.
>=20
> Obvious fix: drop this call.
Emmm, actually I have tested the error path, so I find some issues that =
I have fixed
in the following patches.
I will merge the later series into this series.


>=20
>> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
>> +        return;
>> +    }
>> +
>> +    /* Kick right away to begin processing requests already in vring =
*/
>> +    for (i =3D 0; i < vsc->dev.nvqs; i++) {
>> +        VirtQueue *kick_vq =3D virtio_get_queue(vdev, i);
>> +
>> +        if (!virtio_queue_get_desc_addr(vdev, i)) {
>> +            continue;
>> +        }
>> +        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
>> +    }
>> }
>>=20
>> static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
>> @@ -243,9 +283,9 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>         return;
>>     }
>>=20
>> -    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
>> -                               vhost_dummy_handle_output,
>> -                               vhost_dummy_handle_output, &err);
>> +    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
>> +                               vhost_user_scsi_handle_output,
>> +                               vhost_user_scsi_handle_output, &err);
>>     if (err !=3D NULL) {
>>         error_propagate(errp, err);
>>         return;


--Apple-Mail=_95C061BD-D7ED-49F0-8258-280653F57B60
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote type=3D"cite"><div>On 1 Sep =
2023, at 7:44 PM, Markus Armbruster &lt;armbru@redhat.com&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Li Feng &lt;</span><a =
href=3D"mailto:fengli@smartx.com" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">fengli@smartx.com</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">&gt; =
writes:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Let's keep the same behavior as =
vhost-user-blk.<br><br>Some old guests kick virtqueue before setting =
VIRTIO_CONFIG_S_DRIVER_OK.<br><br>Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-user-scsi.c | 48 =
+++++++++++++++++++++++++++++++++++----<br>1 file changed, 44 =
insertions(+), 4 deletions(-)<br><br>diff --git =
a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>index =
5bf012461b..a7fa8e8df2 100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -113,8 +113,48 @@ static void =
vhost_user_scsi_reset(VirtIODevice =
*vdev)<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>}<br><br>-static void =
vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)<br>+static =
void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)<br>{<br>+ &nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D (VHostUserSCSI =
*)vdev;<br>+ &nbsp;&nbsp;&nbsp;DeviceState *dev =3D =
&amp;s-&gt;parent_obj.parent_obj.parent_obj.parent_obj;<br>+ =
&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>+<br>+ &nbsp;&nbsp;&nbsp;Error *local_err =3D =
NULL;<br>+ &nbsp;&nbsp;&nbsp;int i, ret;<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!vdev-&gt;start_on_kick) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if (!s-&gt;connected) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(vhost_dev_is_started(&amp;vsc-&gt;dev)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Some guests kick before setting =
VIRTIO_CONFIG_S_DRIVER_OK so start<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* vhost =
here instead of waiting for .set_status().<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ &nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s);<br>+ &nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"vhost-user-scsi: vhost start failed: ");<br></blockquote><br =
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
display: inline !important;">Crashes, since @local_err is null. =
&nbsp;Please test your error paths.</span><br style=3D"caret-color: =
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
text-decoration: none; float: none; display: inline !important;">Obvious =
fix: drop this call.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote>Emmm, actually I have tested =
the error path, so I find some issues that I have fixed</div><div>in the =
following patches.</div><div>I will merge the later series into this =
series.</div><div><br></div><div><br></div><div><blockquote =
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_disconnect(&amp;vs-&=
gt;conf.chardev);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;/* Kick right away to =
begin processing requests already in vring */<br>+ &nbsp;&nbsp;&nbsp;for =
(i =3D 0; i &lt; vsc-&gt;dev.nvqs; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VirtQueue *kick_vq =3D =
virtio_get_queue(vdev, i);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!virtio_queue_get_desc_addr(vdev, i)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;continue=
;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;event_notifier_set(virtio_queue_=
get_host_notifier(kick_vq));<br>+ &nbsp;&nbsp;&nbsp;}<br>}<br><br>static =
int vhost_user_scsi_connect(DeviceState *dev, Error **errp)<br>@@ -243,9 =
+283,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>&nbs=
p;&nbsp;&nbsp;&nbsp;}<br><br>- =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_realize(dev, =
vhost_dummy_handle_output,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_dummy_handle_output,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_dummy_handle_output, =
&amp;err);<br>+ &nbsp;&nbsp;&nbsp;virtio_scsi_common_realize(dev, =
vhost_user_scsi_handle_output,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_handle_output,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_handle_output, =
&amp;err);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (err !=3D NULL) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_propagate(errp,=
 =
err);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;</blockquo=
te></div></blockquote></div><br></body></html>=

--Apple-Mail=_95C061BD-D7ED-49F0-8258-280653F57B60--


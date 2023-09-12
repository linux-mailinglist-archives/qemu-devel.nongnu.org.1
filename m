Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1879CA1F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfyra-0004Wq-5U; Tue, 12 Sep 2023 04:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfyrK-0004Ul-TU
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:34:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfyrH-0003Sq-BW
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:34:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c09673b006so35873805ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694507572; x=1695112372;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8zS0caD6m0diSPihQ/X5NzFZfFseKqgLvRX0ZyR+CiM=;
 b=a5LC+C5VyHN7UWcoWwoWfEIH4MZRDRGw7T0F5bvC4s5p0X4rvzI7sV0AQ/csbQEaUJ
 kF9AS2kmzKTkwlEYobZCisRCAkWPH3LPYZy7FFqD3leDtft+KMRxwzLo4/D6XEe6s6+C
 dOkWSLO4EjouJ2ScKrAJTS0Kw3H85ZgTKzIChIrgEDgTfx/LWBOk+mR+5ftvkkg4YA1R
 AHoQUcNwu/7ISDFl6v//9MA35HTRhbNV3GJYdAFo3A19kvwjmD2Usd1Dk7NaQqUWNl6Q
 pUoJM5lv4RlI+x8OjHBRZaMhTSlHRRKio1rYDqTlyPo9T9KssnWDcGZdev8wyPySoayJ
 Tybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694507572; x=1695112372;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zS0caD6m0diSPihQ/X5NzFZfFseKqgLvRX0ZyR+CiM=;
 b=e14QqvMQIkSWpudns1aNccfstRfTuxkhF1j8+LjQ5ndq4H3+/fJf6OkL1PTcsRpjZ0
 yB3TW9P1AcdX+7hHmv4rOVDAbjfiItXQ1wIvnl7OaNVjLxlWxsuMl4kCxTsjMXR3BE1V
 RvwKWQB5WnbzKpYhIi32EcL0wvJibcrm3l7sxL17Hk6xNDyfD49BsptVxzSLpc+7O4Ev
 MUYohTg9bXPBidm5VPsfDgxpU8bJSoKfe5s7tp2gyloZLW/I+9otIPYVwUpohXGUGoA7
 /C1W3W/m8l7rFXsi1e7gXN4mvpoLM7UBWOy68aOpJHQxYlqPjbMKgRxaeqBPGLEgbBLv
 YfHA==
X-Gm-Message-State: AOJu0YyLM9FsLK9Gq9/N3jGNfWjw3OcdfjCUCyBTkVbOWJLELCOKa515
 LV2yOmsiQb6rune/8J9opDxsxQ==
X-Google-Smtp-Source: AGHT+IEBiknfUVg0g0WMCjRF1cbOQXaBpbRw1DdTr2Wzlnb08+iN2dFQkYodvtSdX9f4C5vyny0neQ==
X-Received: by 2002:a17:903:41c8:b0:1c0:c86a:5425 with SMTP id
 u8-20020a17090341c800b001c0c86a5425mr13218957ple.19.1694507572267; 
 Tue, 12 Sep 2023 01:32:52 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902860800b001bbf7fd354csm7805476plo.213.2023.09.12.01.32.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Sep 2023 01:32:51 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <5A2A7F1B-9C9E-4633-AF52-564538DEE61C@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2645301F-93CC-4F0E-B0A4-568F03AF8EF7"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Date: Tue, 12 Sep 2023 16:32:59 +0800
In-Reply-To: <877cpa85n1.fsf@pond.sub.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Markus Armbruster <armbru@redhat.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
 <20230830045722.611224-3-fengli@smartx.com> <877cpa85n1.fsf@pond.sub.org>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x629.google.com
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


--Apple-Mail=_2645301F-93CC-4F0E-B0A4-568F03AF8EF7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 1 Sep 2023, at 8:00 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Li Feng <fengli@smartx.com <mailto:fengli@smartx.com>> writes:
>=20
>> Add a Error parameter to report the real error, like vhost-user-blk.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/scsi/vhost-scsi-common.c           | 16 +++++++++-------
>> hw/scsi/vhost-scsi.c                  |  5 +++--
>> hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
>> include/hw/virtio/vhost-scsi-common.h |  2 +-
>> 4 files changed, 21 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>> index a61cd0e907..4c8637045d 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -16,6 +16,7 @@
>>  */
>>=20
>> #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> #include "qemu/error-report.h"
>> #include "qemu/module.h"
>> #include "hw/virtio/vhost.h"
>> @@ -25,7 +26,7 @@
>> #include "hw/virtio/virtio-access.h"
>> #include "hw/fw-path-provider.h"
>>=20
>> -int vhost_scsi_common_start(VHostSCSICommon *vsc)
>> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
>> {
>>     int ret, i;
>>     VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>> @@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>     VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;
>>=20
>>     if (!k->set_guest_notifiers) {
>> -        error_report("binding does not support guest notifiers");
>> +        error_setg(errp, "binding does not support guest =
notifiers");
>>         return -ENOSYS;
>>     }
>>=20
>>     ret =3D vhost_dev_enable_notifiers(&vsc->dev, vdev);
>>     if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Error enabling host =
notifiers");
>=20
> Looks like the error is silent before your patch.  Correct?
Yes, before this patch, it=E2=80=99s a silent error.

>=20
>>         return ret;
>>     }
>>=20
>>     ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, =
true);
>>     if (ret < 0) {
>> -        error_report("Error binding guest notifier");
>> +        error_setg_errno(errp, -ret, "Error binding guest =
notifier");
>=20
> Error message now provides more detail.
Yes.

>=20
>>         goto err_host_notifiers;
>>     }
>>=20
>> @@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>=20
>>     ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>>     if (ret < 0) {
>> -        error_report("Error setting inflight format: %d", -ret);
>> +        error_setg_errno(errp, -ret, "Error setting inflight =
format");
>=20
> Error message now shows errno in human-readable form.
Yes.

>=20
>>         goto err_guest_notifiers;
>>     }
>>=20
>> @@ -64,21 +66,21 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>                                         vs->conf.virtqueue_size,
>>                                         vsc->inflight);
>>             if (ret < 0) {
>> -                error_report("Error getting inflight: %d", -ret);
>> +                error_setg_errno(errp, -ret, "Error getting =
inflight");
>=20
> Likewise.
Yes.

>=20
>>                 goto err_guest_notifiers;
>>             }
>>         }
>>=20
>>         ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>>         if (ret < 0) {
>> -            error_report("Error setting inflight: %d", -ret);
>> +            error_setg_errno(errp, -ret, "Error setting inflight");
>=20
> Likewise.
Yes.

>=20
>>             goto err_guest_notifiers;
>>         }
>>     }
>>=20
>>     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
>>     if (ret < 0) {
>> -        error_report("Error start vhost dev");
>> +        error_setg_errno(errp, -ret, "Error starting vhost dev");
>=20
> Likewise.
Yes.

>=20
>>         goto err_guest_notifiers;
>>     }
>>=20
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 443f67daa4..01a3ab4277 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
>>     int ret, abi_version;
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>     const VhostOps *vhost_ops =3D vsc->dev.vhost_ops;
>> +    Error *local_err =3D NULL;
>>=20
>>     ret =3D vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, =
&abi_version);
>>     if (ret < 0) {
>> @@ -88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI *s)
>>         return -ENOSYS;
>>     }
>>=20
>> -    ret =3D vhost_scsi_common_start(vsc);
>> +    ret =3D vhost_scsi_common_start(vsc, &local_err);
>>     if (ret < 0) {
>>         return ret;
>>     }
>>=20
>>     ret =3D vhost_scsi_set_endpoint(s);
>>     if (ret < 0) {
>> -        error_report("Error setting vhost-scsi endpoint");
>> +        error_reportf_err(local_err, "Error setting vhost-scsi =
endpoint");
>>         vhost_scsi_common_stop(vsc);
>>     }
>>=20
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index e931df9f5b..62fc98bb1c 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -43,12 +43,12 @@ enum VhostUserProtocolFeature {
>>     VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
>> };
>>=20
>> -static int vhost_user_scsi_start(VHostUserSCSI *s)
>> +static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>> {
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>     int ret;
>>=20
>> -    ret =3D vhost_scsi_common_start(vsc);
>> +    ret =3D vhost_scsi_common_start(vsc, errp);
>>     s->started_vu =3D (ret < 0 ? false : true);
>>=20
>>     return ret;
>> @@ -73,6 +73,7 @@ static void vhost_user_scsi_set_status(VirtIODevice =
*vdev, uint8_t status)
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>     bool should_start =3D virtio_device_should_start(vdev, status);
>> +    Error *local_err =3D NULL;
>>     int ret;
>>=20
>>     if (!s->connected) {
>> @@ -84,9 +85,10 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>     }
>>=20
>>     if (should_start) {
>> -        ret =3D vhost_user_scsi_start(s);
>> +        ret =3D vhost_user_scsi_start(s, &local_err);
>>         if (ret < 0) {
>> -            error_report("unable to start vhost-user-scsi: %s", =
strerror(-ret));
>> +            error_reportf_err(local_err, "unable to start =
vhost-user-scsi: %s",
>> +                              strerror(-ret));
>>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>>         }
>>     } else {
>> @@ -139,7 +141,7 @@ static void =
vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>      * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so =
start
>>      * vhost here instead of waiting for .set_status().
>>      */
>> -    ret =3D vhost_user_scsi_start(s);
>> +    ret =3D vhost_user_scsi_start(s, &local_err);
>>     if (ret < 0) {
>>         error_reportf_err(local_err, "vhost-user-scsi: vhost start =
failed: ");
>=20
> The error_reportf_err() is wrong before the patch, as I just pointed =
out
> in my review of "[PATCH v3 5/5] vhost-user-scsi: start vhost when =
guest
> kicks".  It is correct afterwards.
Yes.

>=20
>>         qemu_chr_fe_disconnect(&vs->conf.chardev);
>> @@ -184,7 +186,7 @@ static int vhost_user_scsi_connect(DeviceState =
*dev, Error **errp)
>>=20
>>     /* restore vhost state */
>>     if (virtio_device_started(vdev, vdev->status)) {
>> -        ret =3D vhost_user_scsi_start(s);
>> +        ret =3D vhost_user_scsi_start(s, errp);
>>         if (ret < 0) {
>>             return ret;
>>         }
>=20
> Wrong before the patch, as I just pointed out in my review of "[PATCH =
v3
> 4/5] vhost-user-scsi: support reconnect to backend".  Correct =
afterwards.
Yes.

>=20
>> diff --git a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h
>> index 18f115527c..c5d2c09455 100644
>> --- a/include/hw/virtio/vhost-scsi-common.h
>> +++ b/include/hw/virtio/vhost-scsi-common.h
>> @@ -39,7 +39,7 @@ struct VHostSCSICommon {
>>     struct vhost_inflight *inflight;
>> };
>>=20
>> -int vhost_scsi_common_start(VHostSCSICommon *vsc);
>> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
>> void vhost_scsi_common_stop(VHostSCSICommon *vsc);
>> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState =
*bus,
>>                                         DeviceState *dev);
>=20
> Please mention in the commit message that error messages improve, and
> silent errors are now reported.
Ack.



--Apple-Mail=_2645301F-93CC-4F0E-B0A4-568F03AF8EF7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote type=3D"cite"><div>On 1 Sep =
2023, at 8:00 PM, Markus Armbruster &lt;armbru@redhat.com&gt; =
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
text-decoration: none;">Add a Error parameter to report the real error, =
like vhost-user-blk.<br><br>Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-scsi-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 16 =
+++++++++-------<br>hw/scsi/vhost-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;5 +++--<br>hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
14 ++++++++------<br>include/hw/virtio/vhost-scsi-common.h | &nbsp;2 =
+-<br>4 files changed, 21 insertions(+), 16 deletions(-)<br><br>diff =
--git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c<br>index a61cd0e907..4c8637045d =
100644<br>--- a/hw/scsi/vhost-scsi-common.c<br>+++ =
b/hw/scsi/vhost-scsi-common.c<br>@@ -16,6 +16,7 =
@@<br>&nbsp;*/<br><br>#include "qemu/osdep.h"<br>+#include =
"qapi/error.h"<br>#include "qemu/error-report.h"<br>#include =
"qemu/module.h"<br>#include "hw/virtio/vhost.h"<br>@@ -25,7 +26,7 =
@@<br>#include "hw/virtio/virtio-access.h"<br>#include =
"hw/fw-path-provider.h"<br><br>-int =
vhost_scsi_common_start(VHostSCSICommon *vsc)<br>+int =
vhost_scsi_common_start(VHostSCSICommon *vsc, Error =
**errp)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int ret, =
i;<br>&nbsp;&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D =
VIRTIO_DEVICE(vsc);<br>@@ -35,18 +36,19 @@ int =
vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
(VirtIOSCSICommon *)vsc;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(!k-&gt;set_guest_notifiers) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("binding does not =
support guest notifiers");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "binding does =
not support guest =
notifiers");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
-ENOSYS;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =
=3D vhost_dev_enable_notifiers(&amp;vsc-&gt;dev, =
vdev);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error enabling host notifiers");<br></blockquote><br =
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
display: inline !important;">Looks like the error is silent before your =
patch. &nbsp;Correct?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote>Yes, before this patch, =
it=E2=80=99s a silent error.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
k-&gt;set_guest_notifiers(qbus-&gt;parent, vsc-&gt;dev.nvqs, =
true);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error binding =
guest notifier");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error binding guest notifier");<br></blockquote><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Error =
message now provides more detail.</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: =
none;"></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_host_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>@@ -54,7 +56,7 =
@@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_prepare_inflight(&amp;vsc-&gt;dev, =
vdev);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
inflight format: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error setting inflight format");<br></blockquote><br =
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
display: inline !important;">Error message now shows errno in =
human-readable form.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: =
none;"></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>@@ -64,21 =
+66,21 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;vs-&gt;conf.virtqueue_size,<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;vsc-&gt;inflight);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;error_report("Error getting inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, "Error getting =
inflight");<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
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
!important;">Likewise.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: =
none;"></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_set_inflight(&amp;vsc-&gt;dev, =
vsc-&gt;inflight);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("Error setting inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_se=
tg_errno(errp, -ret, "Error setting inflight");<br></blockquote><br =
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
display: inline !important;">Likewise.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: =
none;"></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<=
br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_start(&amp;vsc-&gt;dev, vdev, =
true);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error start =
vhost dev");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error starting vhost dev");<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">Likewise.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: =
none;"></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>diff --git =
a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c<br>index =
443f67daa4..01a3ab4277 100644<br>--- a/hw/scsi/vhost-scsi.c<br>+++ =
b/hw/scsi/vhost-scsi.c<br>@@ -75,6 +75,7 @@ static int =
vhost_scsi_start(VHostSCSI *s)<br>&nbsp;&nbsp;&nbsp;&nbsp;int ret, =
abi_version;<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>&nbsp;&nbsp;&nbsp;&nbsp;const VhostOps =
*vhost_ops =3D vsc-&gt;dev.vhost_ops;<br>+ &nbsp;&nbsp;&nbsp;Error =
*local_err =3D NULL;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_ops-&gt;vhost_scsi_get_abi_version(&amp;vsc-&gt;dev, =
&amp;abi_version);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>@@ =
-88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI =
*s)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
-ENOSYS;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>- &nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc);<br>+ &nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc, =
&amp;local_err);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_set_endpoint(s);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error =
setting vhost-scsi endpoint");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"Error setting vhost-scsi =
endpoint");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_scsi_=
common_stop(vsc);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>diff --git =
a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>index =
e931df9f5b..62fc98bb1c 100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -43,12 +43,12 @@ enum =
VhostUserProtocolFeature =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D =
13,<br>};<br><br>-static int vhost_user_scsi_start(VHostUserSCSI =
*s)<br>+static int vhost_user_scsi_start(VHostUserSCSI *s, Error =
**errp)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>&nbsp;&nbsp;&nbsp;&nbsp;int ret;<br><br>- =
&nbsp;&nbsp;&nbsp;ret =3D vhost_scsi_common_start(vsc);<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_scsi_common_start(vsc, =
errp);<br>&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;started_vu =3D (ret &lt; 0 ? =
false : true);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;return ret;<br>@@ -73,6 =
+73,7 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, =
uint8_t status)<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>&nbsp;&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>&nbsp;&nbsp;&nbsp;&nbsp;bool should_start =3D =
virtio_device_should_start(vdev, status);<br>+ &nbsp;&nbsp;&nbsp;Error =
*local_err =3D NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;int =
ret;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) {<br>@@ -84,9 =
+85,10 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, =
uint8_t =
status)<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(should_start) {<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s, =
&amp;local_err);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("unable to start vhost-user-scsi: %s", strerror(-ret));<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
portf_err(local_err, "unable to start vhost-user-scsi: %s",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;strerror(-ret));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_disconnect(&amp;vs=
-&gt;conf.chardev);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>@@ -139,7 +141,7 @@ static void =
vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Some guests kick before setting =
VIRTIO_CONFIG_S_DRIVER_OK so start<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* =
vhost here instead of waiting for =
.set_status().<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>- =
&nbsp;&nbsp;&nbsp;ret =3D vhost_user_scsi_start(s);<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_user_scsi_start(s, =
&amp;local_err);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(loc=
al_err, "vhost-user-scsi: vhost start failed: ");<br></blockquote><br =
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
display: inline !important;">The error_reportf_err() is wrong before the =
patch, as I just pointed out</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">in my =
review of "[PATCH v3 5/5] vhost-user-scsi: start vhost when =
guest</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">kicks". &nbsp;It is =
correct =
afterwards.</span></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: =
none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_disconn=
ect(&amp;vs-&gt;conf.chardev);<br>@@ -184,7 +186,7 @@ static int =
vhost_user_scsi_connect(DeviceState *dev, Error =
**errp)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;/* restore vhost state =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;if (virtio_device_started(vdev, =
vdev-&gt;status)) {<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D=
 vhost_user_scsi_start(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s, =
errp);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; =
0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;return =
ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br></blockquote>=
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Wrong before the patch, as I just pointed =
out in my review of "[PATCH v3</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">4/5] =
vhost-user-scsi: support reconnect to backend". &nbsp;Correct =
afterwards.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>Yes.</div><div><br><blockquote =
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
text-decoration: none;">diff --git =
a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h<br>index 18f115527c..c5d2c09455 =
100644<br>--- a/include/hw/virtio/vhost-scsi-common.h<br>+++ =
b/include/hw/virtio/vhost-scsi-common.h<br>@@ -39,7 +39,7 @@ struct =
VHostSCSICommon {<br>&nbsp;&nbsp;&nbsp;&nbsp;struct vhost_inflight =
*inflight;<br>};<br><br>-int vhost_scsi_common_start(VHostSCSICommon =
*vsc);<br>+int vhost_scsi_common_start(VHostSCSICommon *vsc, Error =
**errp);<br>void vhost_scsi_common_stop(VHostSCSICommon *vsc);<br>char =
*vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState =
*bus,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;DeviceState *dev);<br></blockquote><br =
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
display: inline !important;">Please mention in the commit message that =
error messages improve, and</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">silent =
errors are now =
reported.</span></div></blockquote>Ack.</div><div><br></div><br></body></h=
tml>=

--Apple-Mail=_2645301F-93CC-4F0E-B0A4-568F03AF8EF7--


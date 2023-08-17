Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE76077F0C0
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:52:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWWr0-0003YI-V0; Thu, 17 Aug 2023 02:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qWWqm-0003XM-Eq
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:51:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qWWqi-0006Cx-HF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:51:20 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-565f86ff4d1so979780a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692254953; x=1692859753;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QEaBRpG9ExQcJjk8+Ws4+W0+H0lGPVWabUZszpYiN5w=;
 b=k0zW7k1pRv8I2qvJeLOmFGjce5Zf/TFNoU+Wxf/1nKqG2ArPUlhT5f8aOtlVAsBV3K
 JKrzUrO/FTEiTP1FPtv5P9kxRGlA9Bk8D/ZMmdTCDqvd37U90m9GokiSql7IEnJgUb1f
 FUVGL5yp9dqeOqL/W7WHZtE6Mb2LV2uxHqj/wnE/D3PhJ/c7CChsGpcRgwHbBdC7fDvK
 Es9txVqAGDqkLkbFkUkPsrLnFS/FRyuP5fR+xijoBM3oqd7JHoeZtFaeUjaZWRuwMMyU
 ZBlh3Biy+1z7lSGShQaFYSKZQHC2V5IoO7A/jJEsYGZY79/vTPCHQsC3F+QYBVvinvly
 mqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692254953; x=1692859753;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QEaBRpG9ExQcJjk8+Ws4+W0+H0lGPVWabUZszpYiN5w=;
 b=SM1tAS/hRxgA8bXf6MkzLA2AKtJk38WZfpcDvGG3jgV8Z+HNhbnuBym13fXF3cGZ9C
 OruHq9QWgsC5Hw/2LECRGCfVqi7hxN7DIn3MoH42T/o0WLPGZHGuXiHjghrbDd+oGNrb
 vVvtd8OR5v7rFv/PgoVA4COjo14pO9jxFrMETeGYPXI6H13+S6g9QTS8jc5OfKTuWhxM
 oPRqW5RIsqgpIgX0PafAS8YcXiIp4BuEeFTeprOUyDzf82GTrzS227NEu1rppaIifD4v
 uCt/9lYxkIo4Kt3i4a+HCurpGK1L2UqztNupFAPLZGCfeAg4l77+DC30CgZZgUmdGki7
 mTaA==
X-Gm-Message-State: AOJu0Yy8QcJ+jxCmVhtNazPPhSWDPIeWz+rY2KcNyctcOFNryxC94FGm
 ilz0Yd6HshEeQywJ6fuYtnXoiw==
X-Google-Smtp-Source: AGHT+IFvCusORkIUmnsyBI0COsOOfT3ZiQ0A0azgjTqOPJwKAP/NukXD7iQPFiWoUp85+6p4z/VHdQ==
X-Received: by 2002:a05:6a20:1591:b0:145:6857:457a with SMTP id
 h17-20020a056a20159100b001456857457amr5025763pzj.4.1692254952445; 
 Wed, 16 Aug 2023 23:49:12 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a170902e84f00b001bdeedd8579sm6064940plg.252.2023.08.16.23.49.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Aug 2023 23:49:12 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <844CBDD0-E0A9-4097-904E-5CD74C2884AD@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_04756BCB-5978-48C9-9C59-D965673F44F9"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Date: Thu, 17 Aug 2023 14:49:53 +0800
In-Reply-To: <C026BA6F-63E7-4BE8-8FC0-69372A14FFAB@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-3-fengli@smartx.com>
 <C026BA6F-63E7-4BE8-8FC0-69372A14FFAB@nutanix.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_04756BCB-5978-48C9-9C59-D965673F44F9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphae=
l Norwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Thanks for the cleanup! A few comments.
>=20
>> On Aug 4, 2023, at 1:29 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>> Add a Error parameter to report the real error, like vhost-user-blk.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/scsi/vhost-scsi-common.c           | 17 ++++++++++-------
>> hw/scsi/vhost-scsi.c                  |  5 +++--
>> hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
>> include/hw/virtio/vhost-scsi-common.h |  2 +-
>> 4 files changed, 22 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>> index a61cd0e907..392587dfb5 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -16,6 +16,7 @@
>> */
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
>>    int ret, i;
>>    VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>> @@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>    VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;
>>=20
>>    if (!k->set_guest_notifiers) {
>> -        error_report("binding does not support guest notifiers");
>> +        error_setg(errp, "binding does not support guest =
notifiers");
>>        return -ENOSYS;
>>    }
>>=20
>>    ret =3D vhost_dev_enable_notifiers(&vsc->dev, vdev);
>>    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Error enabling host =
notifiers");
>>        return ret;
>>    }
>>=20
>>    ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
>>    if (ret < 0) {
>> -        error_report("Error binding guest notifier");
>> +        error_setg_errno(errp, -ret, "Error binding guest =
notifier");
>>        goto err_host_notifiers;
>>    }
>>=20
>> @@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>=20
>>    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>>    if (ret < 0) {
>> -        error_report("Error setting inflight format: %d", -ret);
>=20
> Curious why you=E2=80=99re adding the error value to the string. =
Isn=E2=80=99t it redundant since we pass it in as the second param?
>=20
>> +        error_setg_errno(errp, -ret, "Error setting inflight format: =
%d", -ret);

I don=E2=80=99t understand. Here I put the error message in errp, where =
is redundant?

>>        goto err_guest_notifiers;
>>    }
>>=20
>> @@ -64,21 +66,22 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>                                        vs->conf.virtqueue_size,
>>                                        vsc->inflight);
>>            if (ret < 0) {
>> -                error_report("Error getting inflight: %d", -ret);
>=20
> Ditto
>=20
>> +                error_setg_errno(errp, -ret, "Error getting =
inflight: %d",
>> +                                 -ret);
>>                goto err_guest_notifiers;
>>            }
>>        }
>>=20
>>        ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>>        if (ret < 0) {
>> -            error_report("Error setting inflight: %d", -ret);
>> +            error_setg_errno(errp, -ret, "Error setting inflight: =
%d", -ret);
>>            goto err_guest_notifiers;
>>        }
>>    }
>>=20
>>    ret =3D vhost_dev_start(&vsc->dev, vdev, true);
>>    if (ret < 0) {
>> -        error_report("Error start vhost dev");
>=20
> =E2=80=9CError starting vhost dev=E2=80=9D?
ACK.

>=20
>> +        error_setg_errno(errp, -ret, "Error start vhost dev");
>>        goto err_guest_notifiers;
>>    }
>>=20
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 443f67daa4..01a3ab4277 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
>>    int ret, abi_version;
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>    const VhostOps *vhost_ops =3D vsc->dev.vhost_ops;
>> +    Error *local_err =3D NULL;
>>=20
>>    ret =3D vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, =
&abi_version);
>>    if (ret < 0) {
>> @@ -88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI *s)
>>        return -ENOSYS;
>>    }
>>=20
>> -    ret =3D vhost_scsi_common_start(vsc);
>> +    ret =3D vhost_scsi_common_start(vsc, &local_err);
>>    if (ret < 0) {
>>        return ret;
>>    }
>>=20
>>    ret =3D vhost_scsi_set_endpoint(s);
>>    if (ret < 0) {
>> -        error_report("Error setting vhost-scsi endpoint");
>> +        error_reportf_err(local_err, "Error setting vhost-scsi =
endpoint");
>>        vhost_scsi_common_stop(vsc);
>>    }
>>=20
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index a7fa8e8df2..d368171e28 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -43,12 +43,12 @@ enum VhostUserProtocolFeature {
>>    VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
>> };
>>=20
>> -static int vhost_user_scsi_start(VHostUserSCSI *s)
>> +static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>> {
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>    int ret;
>>=20
>> -    ret =3D vhost_scsi_common_start(vsc);
>> +    ret =3D vhost_scsi_common_start(vsc, errp);
>>    s->started_vu =3D (ret < 0 ? false : true);
>>=20
>>    return ret;
>> @@ -73,6 +73,7 @@ static void vhost_user_scsi_set_status(VirtIODevice =
*vdev, uint8_t status)
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>    bool should_start =3D virtio_device_should_start(vdev, status);
>> +    Error *local_err =3D NULL;
>>    int ret;
>>=20
>>    if (!s->connected) {
>> @@ -84,9 +85,10 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>    }
>>=20
>>    if (should_start) {
>> -        ret =3D vhost_user_scsi_start(s);
>> +        ret =3D vhost_user_scsi_start(s, &local_err);
>>        if (ret < 0) {
>> -            error_report("unable to start vhost-user-scsi: %s", =
strerror(-ret));
>> +            error_reportf_err(local_err, "unable to start =
vhost-user-scsi: %s",
>> +                              strerror(-ret));
>>            qemu_chr_fe_disconnect(&vs->conf.chardev);
>>        }
>>    } else {
>> @@ -139,7 +141,7 @@ static void =
vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so =
start
>>     * vhost here instead of waiting for .set_status().
>>     */
>> -    ret =3D vhost_user_scsi_start(s);
>> +    ret =3D vhost_user_scsi_start(s, &local_err);
>>    if (ret < 0) {
>>        error_reportf_err(local_err, "vhost-user-scsi: vhost start =
failed: ");
>>        qemu_chr_fe_disconnect(&vs->conf.chardev);
>> @@ -184,7 +186,7 @@ static int vhost_user_scsi_connect(DeviceState =
*dev, Error **errp)
>>=20
>>    /* restore vhost state */
>>    if (virtio_device_started(vdev, vdev->status)) {
>> -        ret =3D vhost_user_scsi_start(s);
>> +        ret =3D vhost_user_scsi_start(s, errp);
>>        if (ret < 0) {
>>            return ret;
>>        }
>> diff --git a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h
>> index 18f115527c..c5d2c09455 100644
>> --- a/include/hw/virtio/vhost-scsi-common.h
>> +++ b/include/hw/virtio/vhost-scsi-common.h
>> @@ -39,7 +39,7 @@ struct VHostSCSICommon {
>>    struct vhost_inflight *inflight;
>> };
>>=20
>> -int vhost_scsi_common_start(VHostSCSICommon *vsc);
>> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
>> void vhost_scsi_common_stop(VHostSCSICommon *vsc);
>> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState =
*bus,
>>                                        DeviceState *dev);
>> --=20
>> 2.41.0


--Apple-Mail=_04756BCB-5978-48C9-9C59-D965673F44F9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote =
type=3D"cite"><div>2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =
=E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphael Norwitz =
&lt;raphael.norwitz@nutanix.com&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Thanks for the cleanup! A few =
comments.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">On Aug 4, 2023, =
at 1:29 AM, Li Feng &lt;fengli@smartx.com&gt; wrote:<br><br>Add a Error =
parameter to report the real error, like =
vhost-user-blk.<br><br>Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-scsi-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 17 =
++++++++++-------<br>hw/scsi/vhost-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;5 +++--<br>hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
14 ++++++++------<br>include/hw/virtio/vhost-scsi-common.h | &nbsp;2 =
+-<br>4 files changed, 22 insertions(+), 16 deletions(-)<br><br>diff =
--git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c<br>index a61cd0e907..392587dfb5 =
100644<br>--- a/hw/scsi/vhost-scsi-common.c<br>+++ =
b/hw/scsi/vhost-scsi-common.c<br>@@ -16,6 +16,7 @@<br>*/<br><br>#include =
"qemu/osdep.h"<br>+#include "qapi/error.h"<br>#include =
"qemu/error-report.h"<br>#include "qemu/module.h"<br>#include =
"hw/virtio/vhost.h"<br>@@ -25,7 +26,7 @@<br>#include =
"hw/virtio/virtio-access.h"<br>#include =
"hw/fw-path-provider.h"<br><br>-int =
vhost_scsi_common_start(VHostSCSICommon *vsc)<br>+int =
vhost_scsi_common_start(VHostSCSICommon *vsc, Error =
**errp)<br>{<br>&nbsp;&nbsp;&nbsp;int ret, =
i;<br>&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);<br>@@ =
-35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D (VirtIOSCSICommon =
*)vsc;<br><br>&nbsp;&nbsp;&nbsp;if (!k-&gt;set_guest_notifiers) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("binding does not =
support guest notifiers");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "binding does =
not support guest =
notifiers");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
-ENOSYS;<br>&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_enable_notifiers(&amp;vsc-&gt;dev, =
vdev);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error enabling host =
notifiers");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;ret =3D =
k-&gt;set_guest_notifiers(qbus-&gt;parent, vsc-&gt;dev.nvqs, =
true);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error binding =
guest notifier");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error binding guest =
notifier");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_host_notifiers;<br>&nbsp;&nbsp;&nbsp;}<br><br>@@ -54,7 +56,7 @@ int =
vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br><br>&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_prepare_inflight(&amp;vsc-&gt;dev, =
vdev);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
inflight format: %d", -ret);<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Curious =
why you=E2=80=99re adding the error value to the string. Isn=E2=80=99t =
it redundant since we pass it in as the second param?</span><br =
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
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error setting inflight format: %d", =
-ret);<br></blockquote></div></blockquote><div><br></div>I don=E2=80=99t =
understand. Here I put the error message in errp, where is =
redundant?</div><div><br><blockquote type=3D"cite"><div><blockquote =
type=3D"cite" style=3D"font-family: Monaco; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;}<br><br>@@ -64,21 +66,22 @@ =
int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;vs-&gt;conf.virtqueue_size,<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;in=
flight);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;error_report("Error getting inflight: %d", =
-ret);<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
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
!important;">Ditto</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, "Error getting inflight: =
%d",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-ret);<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto=
 =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_set_inflight(&amp;vsc-&gt;dev, =
vsc-&gt;inflight);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret =
&lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("Error setting inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_se=
tg_errno(errp, -ret, "Error setting inflight: %d", =
-ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nb=
sp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_start(&amp;vsc-&gt;dev, vdev, true);<br>&nbsp;&nbsp;&nbsp;if =
(ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error start =
vhost dev");<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
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
!important;">=E2=80=9CError starting vhost dev=E2=80=9D?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>ACK.</div><div><br><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errno(errp, -ret, =
"Error start vhost =
dev");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;}<br><br>diff --git =
a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c<br>index =
443f67daa4..01a3ab4277 100644<br>--- a/hw/scsi/vhost-scsi.c<br>+++ =
b/hw/scsi/vhost-scsi.c<br>@@ -75,6 +75,7 @@ static int =
vhost_scsi_start(VHostSCSI *s)<br>&nbsp;&nbsp;&nbsp;int ret, =
abi_version;<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>&nbsp;&nbsp;&nbsp;const VhostOps *vhost_ops =3D =
vsc-&gt;dev.vhost_ops;<br>+ &nbsp;&nbsp;&nbsp;Error *local_err =3D =
NULL;<br><br>&nbsp;&nbsp;&nbsp;ret =3D =
vhost_ops-&gt;vhost_scsi_get_abi_version(&amp;vsc-&gt;dev, =
&amp;abi_version);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>@@ -88,14 =
+89,14 @@ static int vhost_scsi_start(VHostSCSI =
*s)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
-ENOSYS;<br>&nbsp;&nbsp;&nbsp;}<br><br>- &nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc);<br>+ &nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc, &amp;local_err);<br>&nbsp;&nbsp;&nbsp;if =
(ret &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_set_endpoint(s);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
vhost-scsi endpoint");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"Error setting vhost-scsi =
endpoint");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_scsi_common=
_stop(vsc);<br>&nbsp;&nbsp;&nbsp;}<br><br>diff --git =
a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>index =
a7fa8e8df2..d368171e28 100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -43,12 +43,12 @@ enum =
VhostUserProtocolFeature =
{<br>&nbsp;&nbsp;&nbsp;VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D =
13,<br>};<br><br>-static int vhost_user_scsi_start(VHostUserSCSI =
*s)<br>+static int vhost_user_scsi_start(VHostUserSCSI *s, Error =
**errp)<br>{<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>&nbsp;&nbsp;&nbsp;int ret;<br><br>- =
&nbsp;&nbsp;&nbsp;ret =3D vhost_scsi_common_start(vsc);<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_scsi_common_start(vsc, =
errp);<br>&nbsp;&nbsp;&nbsp;s-&gt;started_vu =3D (ret &lt; 0 ? false : =
true);<br><br>&nbsp;&nbsp;&nbsp;return ret;<br>@@ -73,6 +73,7 @@ static =
void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>&nbsp;&nbsp;&nbsp;bool should_start =3D =
virtio_device_should_start(vdev, status);<br>+ &nbsp;&nbsp;&nbsp;Error =
*local_err =3D NULL;<br>&nbsp;&nbsp;&nbsp;int =
ret;<br><br>&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) {<br>@@ -84,9 +85,10 =
@@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)<br>&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;if =
(should_start) {<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s, =
&amp;local_err);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret =
&lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("unable to start vhost-user-scsi: %s", strerror(-ret));<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
portf_err(local_err, "unable to start vhost-user-scsi: %s",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;strerror(-ret));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_disconnect(&amp;vs-&gt;c=
onf.chardev);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbs=
p;&nbsp;} else {<br>@@ -139,7 +141,7 @@ static void =
vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)<br>&nbsp;&nbsp;&nbsp;&nbsp;* Some guests kick before setting =
VIRTIO_CONFIG_S_DRIVER_OK so start<br>&nbsp;&nbsp;&nbsp;&nbsp;* vhost =
here instead of waiting for =
.set_status().<br>&nbsp;&nbsp;&nbsp;&nbsp;*/<br>- &nbsp;&nbsp;&nbsp;ret =
=3D vhost_user_scsi_start(s);<br>+ &nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s, &amp;local_err);<br>&nbsp;&nbsp;&nbsp;if (ret =
&lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err=
, "vhost-user-scsi: vhost start failed: =
");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_disconnect(&a=
mp;vs-&gt;conf.chardev);<br>@@ -184,7 +186,7 @@ static int =
vhost_user_scsi_connect(DeviceState *dev, Error =
**errp)<br><br>&nbsp;&nbsp;&nbsp;/* restore vhost state =
*/<br>&nbsp;&nbsp;&nbsp;if (virtio_device_started(vdev, =
vdev-&gt;status)) {<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D=
 vhost_user_scsi_start(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s, =
errp);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret=
urn ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>diff --git =
a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h<br>index 18f115527c..c5d2c09455 =
100644<br>--- a/include/hw/virtio/vhost-scsi-common.h<br>+++ =
b/include/hw/virtio/vhost-scsi-common.h<br>@@ -39,7 +39,7 @@ struct =
VHostSCSICommon {<br>&nbsp;&nbsp;&nbsp;struct vhost_inflight =
*inflight;<br>};<br><br>-int vhost_scsi_common_start(VHostSCSICommon =
*vsc);<br>+int vhost_scsi_common_start(VHostSCSICommon *vsc, Error =
**errp);<br>void vhost_scsi_common_stop(VHostSCSICommon *vsc);<br>char =
*vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState =
*bus,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;DeviceState *dev);<br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></div>=
</blockquote></div><br></body></html>=

--Apple-Mail=_04756BCB-5978-48C9-9C59-D965673F44F9--


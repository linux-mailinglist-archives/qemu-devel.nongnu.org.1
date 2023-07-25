Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7F76108F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFAa-0007MP-3n; Tue, 25 Jul 2023 06:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFAR-0007Kd-Ua
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:21:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFAO-00065J-FL
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:21:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-66f5faba829so3369146b3a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690280356; x=1690885156;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKP3MXuhBB5Ozr+hT5xtEdMjvlIsWI1hlaCQ53BeRuQ=;
 b=p9GkJkxrd2OmLGpRomb8FXimyWtlLHGoPxq7zcGTz/0LHYNm1QadPxsaCeIcmYAmQS
 baNDHDrbi9PTT9v9tR1QZk2SDgftBMmmJSmUONuIwWUXYOFinR+QdFPV5dw/kox1WiHX
 sTyxSlMe9a2TfdsUAMxig480oaR+v26qzitArlywB6EpyJa4pGZJPD5vQzolPOeoEhbx
 PFemjfRNfCV5xs3+rUS6MT/LP2qpOmbrbcjolZ8a8rm0seJwWdNuR46aNShTJbZ0Mg8j
 ygy2r2gMb3W6VDDjkvt8Ghg3qlDx4oQDxHhdGahOXig6tv33RicBGIGQnXE50TN+nQKt
 7EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280357; x=1690885157;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKP3MXuhBB5Ozr+hT5xtEdMjvlIsWI1hlaCQ53BeRuQ=;
 b=SdHKFF68qy+vr4SWN/d4b8cRbrpnleWRozF2pFcsnnpy7GMhftN6KpFMfliYSyikAm
 VwzylmI4dno2/6Dx08Zx/mYULwvZlyhDhCPpmy7mHSAQ/NoqJsSPRQd6IhIYYRkeB3wG
 T6FqIRJ+QuYbDt1X6RuWt8AOdgUm9CYJEgSSQSXiTQPQyws105RGBLXxtgPkzcYudm2q
 MmjTtqZEuhil40G1jPgnBhyVVwWlc/BCmg/yXvKDQt6mc4veKbL2Mv7mLQYRyOa+jvzP
 Ud25zlWsacnhkIOxwGl+V19SCZNqchD4KGgiNU1UdIqvXZJfrG/RNqplcuNov+IaAMJr
 vZlw==
X-Gm-Message-State: ABy/qLaGxhEcQSy7RffX+ksPTGMXZjqiQDsvUTIy90IjWnQE1w3OvN80
 CUBYeXgic3ecX8BonmIN8Rshwg==
X-Google-Smtp-Source: APBJJlHx+kN0v+8xLQLlBnW7ubQgE5YUow8LRLNHC/ox9+Spjzx08bEBJVo5RUh3MQMXVmwJf5tltA==
X-Received: by 2002:a05:6a20:4927:b0:136:ea0e:1aab with SMTP id
 ft39-20020a056a20492700b00136ea0e1aabmr9276620pzb.36.1690280356281; 
 Tue, 25 Jul 2023 03:19:16 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a62e505000000b0065da94fe921sm9266902pff.50.2023.07.25.03.19.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jul 2023 03:19:15 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <15166F8E-9F1C-4AEB-9941-E83E5776B3A7@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_6B70346F-2806-4308-836E-FAEE91C1684D"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] vhost-user-scsi: support reconnect to backend
Date: Tue, 25 Jul 2023 18:19:31 +0800
In-Reply-To: <DDDB71EA-E549-4325-9CDC-E9C746AE2E9B@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <DDDB71EA-E549-4325-9CDC-E9C746AE2E9B@nutanix.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, TRACKER_ID=0.1,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--Apple-Mail=_6B70346F-2806-4308-836E-FAEE91C1684D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks for your comments.

> 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 =E4=B8=8A=E5=8D=881:21=EF=BC=8CRaphae=
l Norwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Very excited to see this. High level looks good modulo a few small =
things.
>=20
> My major concern is around existing vhost-user-scsi backends which =
don=E2=80=99t support VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD. IMO we =
should hide the reconnect behavior behind a =
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD check. We may want to do the same =
for vhost-user-blk.
>=20
> The question is then what happens if the check is false. IIUC without =
an inflight FD, if a device processes requests out of order, it=E2=80=99s =
not safe to continue execution on reconnect, as there=E2=80=99s no way =
for the backend to know how to replay IO. Should we permanently wedge =
the device or have QEMU fail out? May be nice to have a toggle for this.

Based on what MST said, is there anything else I need to do?
>=20
>> On Jul 21, 2023, at 6:51 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>> If the backend crashes and restarts, the device is broken.
>> This patch adds reconnect for vhost-user-scsi.
>>=20
>> Tested with spdk backend.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/block/vhost-user-blk.c           |   2 -
>> hw/scsi/vhost-scsi-common.c         |  27 ++---
>> hw/scsi/vhost-user-scsi.c           | 163 =
+++++++++++++++++++++++++---
>> include/hw/virtio/vhost-user-scsi.h |   3 +
>> include/hw/virtio/vhost.h           |   2 +
>> 5 files changed, 165 insertions(+), 32 deletions(-)
>>=20
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index eecf3f7a81..f250c740b5 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -32,8 +32,6 @@
>> #include "sysemu/sysemu.h"
>> #include "sysemu/runstate.h"
>>=20
>> -#define REALIZE_CONNECTION_RETRIES 3
>> -
>> static const int user_feature_bits[] =3D {
>>    VIRTIO_BLK_F_SIZE_MAX,
>>    VIRTIO_BLK_F_SEG_MAX,
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>=20
> Why can=E2=80=99t all the vhost-scsi-common stuff be moved to a =
separate change?

I will move this code to separate patch.
>=20
> Especially the stuff introduced for vhost-user-blk in =
1b0063b3048af65dfaae6422a572c87db8575a92 should be moved out.
OK.

>=20
>> index a06f01af26..08801886b8 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -52,16 +52,22 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>=20
>>    vsc->dev.acked_features =3D vdev->guest_features;
>>=20
>> -    assert(vsc->inflight =3D=3D NULL);
>> -    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
>> -    ret =3D vhost_dev_get_inflight(&vsc->dev,
>> -                                 vs->conf.virtqueue_size,
>> -                                 vsc->inflight);
>> +    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>>    if (ret < 0) {
>> -        error_report("Error get inflight: %d", -ret);
>> +        error_report("Error setting inflight format: %d", -ret);
>>        goto err_guest_notifiers;
>>    }
>>=20
>> +    if (!vsc->inflight->addr) {
>> +        ret =3D vhost_dev_get_inflight(&vsc->dev,
>> +                                    vs->conf.virtqueue_size,
>> +                                    vsc->inflight);
>> +        if (ret < 0) {
>> +            error_report("Error get inflight: %d", -ret);
>> +            goto err_guest_notifiers;
>> +        }
>> +    }
>> +
>>    ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>>    if (ret < 0) {
>>        error_report("Error set inflight: %d", -ret);
>> @@ -85,9 +91,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>    return ret;
>>=20
>> err_guest_notifiers:
>> -    g_free(vsc->inflight);
>> -    vsc->inflight =3D NULL;
>> -
>>    k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>> err_host_notifiers:
>>    vhost_dev_disable_notifiers(&vsc->dev, vdev);
>> @@ -111,12 +114,6 @@ void vhost_scsi_common_stop(VHostSCSICommon =
*vsc)
>>    }
>>    assert(ret >=3D 0);
>>=20
>=20
> In the vhost-scsi (kernel backend) path, what will cleanup =
vsc->inflight now?
OK, we should check the vsc->inflight if it is null, the vhost-scsi =
doesn=E2=80=99t allocate the
inflight object memory.

>=20
>> -    if (vsc->inflight) {
>> -        vhost_dev_free_inflight(vsc->inflight);
>> -        g_free(vsc->inflight);
>> -        vsc->inflight =3D NULL;
>> -    }
>> -
>>    vhost_dev_disable_notifiers(&vsc->dev, vdev);
>> }
>>=20
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index ee99b19e7a..e0e88b0c42 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -89,14 +89,126 @@ static void =
vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>> {
>> }
>>=20
>> +static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +    int ret =3D 0;
>> +
>> +    if (s->connected) {
>> +        return 0;
>> +    }
>> +    s->connected =3D true;
>> +
>> +    vsc->dev.num_queues =3D vs->conf.num_queues;
>> +    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + =
vs->conf.num_queues;
>> +    vsc->dev.vqs =3D s->vhost_vqs;
>> +    vsc->dev.vq_index =3D 0;
>> +    vsc->dev.backend_features =3D 0;
>> +
>> +    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, =
VHOST_BACKEND_TYPE_USER, 0,
>> +                         errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    /* restore vhost state */
>=20
> Should this use virtio_device_should_start like vhost_user_blk?
I will change this.
>=20
>> +    if (virtio_device_started(vdev, vdev->status)) {
>> +        ret =3D vhost_scsi_common_start(vsc);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event);
>> +
>> +static void vhost_user_scsi_disconnect(DeviceState *dev)
>> +{
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +
>=20
> I don=E2=80=99t think we want to execute vhost_scsi_common_stop() if =
the device hasn=E2=80=99t been started. I remember that caused a number =
of races with the vhost_user_blk connecting/disconnecting on startup.
>=20
> Let=E2=80=99s add a similar started_vu check?
I will add it.
>=20
>> +    if (!s->connected) {
>> +        return;
>> +    }
>> +    s->connected =3D false;
>> +
>> +    vhost_scsi_common_stop(vsc);
>> +
>> +    vhost_dev_cleanup(&vsc->dev);
>> +
>> +    /* Re-instate the event handler for new connections */
>> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
>> +                             vhost_user_scsi_event, NULL, dev, NULL, =
true);
>> +}
>> +
>> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
>> +{
>> +    DeviceState *dev =3D opaque;
>> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +    Error *local_err =3D NULL;
>> +
>> +    switch (event) {
>> +    case CHR_EVENT_OPENED:
>> +        if (vhost_user_scsi_connect(dev, &local_err) < 0) {
>> +            error_report_err(local_err);
>> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
>> +            return;
>> +        }
>> +        break;
>> +    case CHR_EVENT_CLOSED:
>> +        /* defer close until later to avoid circular close */
>> +        vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
>> +                               vhost_user_scsi_disconnect);
>> +        break;
>> +    case CHR_EVENT_BREAK:
>> +    case CHR_EVENT_MUX_IN:
>> +    case CHR_EVENT_MUX_OUT:
>> +        /* Ignore */
>> +        break;
>> +    }
>> +}
>> +
>> +static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error =
**errp)
>> +{
>> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +    int ret;
>> +
>> +    s->connected =3D false;
>> +
>> +    ret =3D qemu_chr_fe_wait_connected(&vs->conf.chardev, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    ret =3D vhost_user_scsi_connect(dev, errp);
>> +    if (ret < 0) {
>> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
>> +        return ret;
>> +    }
>> +    assert(s->connected);
>> +
>> +    return 0;
>> +}
>> +
>> static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>> {
>>    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>    VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    struct vhost_virtqueue *vqs =3D NULL;
>>    Error *err =3D NULL;
>>    int ret;
>> +    int retries =3D REALIZE_CONNECTION_RETRIES;
>>=20
>>    if (!vs->conf.chardev.chr) {
>>        error_setg(errp, "vhost-user-scsi: missing chardev");
>> @@ -112,21 +224,31 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>    }
>>=20
>>    if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
>=20
> Why execute vhost_user_cleanup() if vhost_user_init() fails?
OK, move this line up in v2.

>=20
>> -        goto free_virtio;
>> +        goto free_vhost;
>>    }
>>=20
>> -    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + =
vs->conf.num_queues;
>> -    vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
>> -    vsc->dev.vq_index =3D 0;
>> -    vsc->dev.backend_features =3D 0;
>> -    vqs =3D vsc->dev.vqs;
>> +    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
>> +    s->vhost_vqs =3D g_new0(struct vhost_virtqueue,
>> +                          VIRTIO_SCSI_VQ_NUM_FIXED + =
vs->conf.num_queues);
>> +
>> +    assert(!*errp);
>> +    do {
>> +        if (*errp) {
>> +            error_prepend(errp, "Reconnecting after error: ");
>> +            error_report_err(*errp);
>> +            *errp =3D NULL;
>> +        }
>> +        ret =3D vhost_user_scsi_realize_connect(s, errp);
>> +    } while (ret < 0 && retries--);
>>=20
>> -    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user,
>> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
>>    if (ret < 0) {
>> -        goto free_vhost;
>> +        goto free_vqs;
>>    }
>>=20
>> +    /* we're fully initialized, now we can operate, so add the =
handler */
>> +    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
>> +                             vhost_user_scsi_event, NULL, (void =
*)dev,
>> +                             NULL, true);
>>    /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
>>    vsc->channel =3D 0;
>>    vsc->lun =3D 0;
>> @@ -134,10 +256,15 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>=20
>>    return;
>>=20
>> +free_vqs:
>> +    g_free(s->vhost_vqs);
>> +    s->vhost_vqs =3D NULL;
>> +    g_free(vsc->inflight);
>> +    vsc->inflight =3D NULL;
>> +
>> free_vhost:
>>    vhost_user_cleanup(&s->vhost_user);
>> -    g_free(vqs);
>> -free_virtio:
>> +
>>    virtio_scsi_common_unrealize(dev);
>> }
>>=20
>> @@ -146,16 +273,22 @@ static void =
vhost_user_scsi_unrealize(DeviceState *dev)
>>    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>>    VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    struct vhost_virtqueue *vqs =3D vsc->dev.vqs;
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>=20
>>    /* This will stop the vhost backend. */
>>    vhost_user_scsi_set_status(vdev, 0);
>> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, =
NULL, NULL,
>> +                             NULL, false);
>>=20
>>    vhost_dev_cleanup(&vsc->dev);
>> -    g_free(vqs);
>=20
> Nit: Why not put vhost_dev_free_inflight next to the remaining =
inflight cleanup?
OK.
>=20
>> +    vhost_dev_free_inflight(vsc->inflight);
>> +    g_free(s->vhost_vqs);
>> +    s->vhost_vqs =3D NULL;
>> +    g_free(vsc->inflight);
>> +    vsc->inflight =3D NULL;
>>=20
>=20
> Curiosity - why reorder here? Is something in vhost_user_cleanup() =
dependent on state freed in virtio_scsi_common_unrealize()?
>=20
> If so, should that go as a standalone fix?

Because in vhost_user_scsi_realize, we initialize in order:
virtio_scsi_common_realize
vhost_user_init

And in the error handler of vhost_user_scsi_realize, the uninitialize in =
order:
vhost_user_cleanup
virtio_scsi_common_unrealize

I think in vhost_user_scsi_unrealize we should keep it the same order, =
right?

>=20
>> -    virtio_scsi_common_unrealize(dev);
>>    vhost_user_cleanup(&s->vhost_user);
>> +    virtio_scsi_common_unrealize(dev);
>> }
>>=20
>> static Property vhost_user_scsi_properties[] =3D {
>> diff --git a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h
>> index 521b08e559..c66acc68b7 100644
>> --- a/include/hw/virtio/vhost-user-scsi.h
>> +++ b/include/hw/virtio/vhost-user-scsi.h
>> @@ -29,6 +29,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, =
VHOST_USER_SCSI)
>> struct VHostUserSCSI {
>>    VHostSCSICommon parent_obj;
>>    VhostUserState vhost_user;
>=20
> See above - we should probably have started_vu here/
I will add it.
>=20
> Maybe we should have some shared struct with vhost_user_blk for =
connectivity params?

In the future vhost-user-blk/scsi can be refactored to share the same =
code.
>=20
>> +    bool connected;
>> +
>> +    struct vhost_virtqueue *vhost_vqs;
>> };
>>=20
>> #endif /* VHOST_USER_SCSI_H */
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 6a173cb9fa..b904346fe1 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -8,6 +8,8 @@
>> #define VHOST_F_DEVICE_IOTLB 63
>> #define VHOST_USER_F_PROTOCOL_FEATURES 30
>>=20
>=20
> Should the macro name indicate that this is for vhost-user?
>=20
> VU_REALIZE_CONN_RETRIES?=20
I will rename it in v2.

>=20
>> +#define REALIZE_CONNECTION_RETRIES 3
>> +
>> /* Generic structures common for any vhost based device. */
>>=20
>> struct vhost_inflight {
>> --=20
>> 2.41.0


--Apple-Mail=_6B70346F-2806-4308-836E-FAEE91C1684D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Thanks for =
your comments.<br><span><br><blockquote type=3D"cite">2023=E5=B9=B47=E6=9C=
=8825=E6=97=A5 =E4=B8=8A=E5=8D=881:21=EF=BC=8CRaphael Norwitz =
&lt;raphael.norwitz@nutanix.com&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><br =
class=3D"Apple-interchange-newline">Very excited to see this. High level =
looks good modulo a few small things.<br><br>My major concern is around =
existing vhost-user-scsi backends which don=E2=80=99t support =
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD. IMO we should hide the reconnect =
behavior behind a VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD check. We may =
want to do the same for vhost-user-blk.<br><br>The question is then what =
happens if the check is false. IIUC without an inflight FD, if a device =
processes requests out of order, it=E2=80=99s not safe to continue =
execution on reconnect, as there=E2=80=99s no way for the backend to =
know how to replay IO. Should we permanently wedge the device or have =
QEMU fail out? May be nice to have a toggle for =
this.<br></blockquote><br>Based on what MST said,&nbsp;</span>is there =
anything else I need to do?<span><br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">On Jul 21, 2023, at 6:51 AM, =
Li Feng &lt;fengli@smartx.com&gt; wrote:<br><br>If the backend crashes =
and restarts, the device is broken.<br>This patch adds reconnect for =
vhost-user-scsi.<br><br>Tested with spdk backend.<br><br>Signed-off-by: =
Li Feng &lt;fengli@smartx.com&gt;<br>---<br>hw/block/vhost-user-blk.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;2 -<br>hw/scsi/vhost-scsi-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;27 =
++---<br>hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 163 =
+++++++++++++++++++++++++---<br>include/hw/virtio/vhost-user-scsi.h | =
&nbsp;&nbsp;3 +<br>include/hw/virtio/vhost.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;2 +<br>5 files changed, 165 insertions(+), 32 =
deletions(-)<br><br>diff --git a/hw/block/vhost-user-blk.c =
b/hw/block/vhost-user-blk.c<br>index eecf3f7a81..f250c740b5 =
100644<br>--- a/hw/block/vhost-user-blk.c<br>+++ =
b/hw/block/vhost-user-blk.c<br>@@ -32,8 +32,6 @@<br>#include =
"sysemu/sysemu.h"<br>#include "sysemu/runstate.h"<br><br>-#define =
REALIZE_CONNECTION_RETRIES 3<br>-<br>static const int =
user_feature_bits[] =3D =
{<br>&nbsp;&nbsp;&nbsp;VIRTIO_BLK_F_SIZE_MAX,<br>&nbsp;&nbsp;&nbsp;VIRTIO_=
BLK_F_SEG_MAX,<br>diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c<br></blockquote><br>Why can=E2=80=99t all =
the vhost-scsi-common stuff be moved to a separate =
change?<br></blockquote><br>I will move this code to separate =
patch.<br><blockquote type=3D"cite"><br>Especially the stuff introduced =
for vhost-user-blk in 1b0063b3048af65dfaae6422a572c87db8575a92 should be =
moved out.<br></blockquote>OK.</span><div><br><blockquote =
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
-webkit-text-stroke-width: 0px; text-decoration: none;">index =
a06f01af26..08801886b8 100644<br>--- =
a/hw/scsi/vhost-scsi-common.c<br>+++ b/hw/scsi/vhost-scsi-common.c<br>@@ =
-52,16 +52,22 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br><br>&nbsp;&nbsp;&nbsp;vsc-&gt;dev.acked_features =3D =
vdev-&gt;guest_features;<br><br>- =
&nbsp;&nbsp;&nbsp;assert(vsc-&gt;inflight =3D=3D NULL);<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D g_new0(struct vhost_inflight, =
1);<br>- &nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_get_inflight(&amp;vsc-&gt;dev,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vs-&gt;conf.virtqueue_size,<br=
>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_prepare_inflight(&amp;vsc-&gt;dev, =
vdev);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error get =
inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
inflight format: %d", =
-ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;}<br><br>+ =
&nbsp;&nbsp;&nbsp;if (!vsc-&gt;inflight-&gt;addr) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_get_inflight(&amp;vsc-&gt;dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vs-&gt;conf.=
virtqueue_size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;infl=
ight);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("Error get inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_set_inflight(&amp;vsc-&gt;dev, =
vsc-&gt;inflight);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error set =
inflight: %d", -ret);<br>@@ -85,9 +91,6 @@ int =
vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;return ret;<br><br>err_guest_notifiers:<br>- =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>-<br>&nbsp;&nbsp;&nbsp;k-&gt;set_guest_notifiers(qbus-&gt;parent,=
 vsc-&gt;dev.nvqs, =
false);<br>err_host_notifiers:<br>&nbsp;&nbsp;&nbsp;vhost_dev_disable_noti=
fiers(&amp;vsc-&gt;dev, vdev);<br>@@ -111,12 +114,6 @@ void =
vhost_scsi_common_stop(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;assert(ret &gt;=3D =
0);<br><br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">In the =
vhost-scsi (kernel backend) path, what will cleanup vsc-&gt;inflight =
now?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>OK, we should check the vsc-&gt;inflight if it =
is null, the vhost-scsi doesn=E2=80=99t allocate the</div><div>inflight =
object memory.</div><div><br><blockquote type=3D"cite"><div><br =
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
text-decoration: none;">- &nbsp;&nbsp;&nbsp;if (vsc-&gt;inflight) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_dev_free_inflight(vsc-&gt;=
inflight);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>- =
&nbsp;&nbsp;&nbsp;}<br>-<br>&nbsp;&nbsp;&nbsp;vhost_dev_disable_notifiers(=
&amp;vsc-&gt;dev, vdev);<br>}<br><br>diff --git =
a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>index =
ee99b19e7a..e0e88b0c42 100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -89,14 +89,126 @@ static void =
vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)<br>{<br>}<br><br>+static int vhost_user_scsi_connect(DeviceState =
*dev, Error **errp)<br>+{<br>+ &nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D =
VIRTIO_DEVICE(dev);<br>+ &nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(vdev);<br>+ &nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>+ &nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>+ &nbsp;&nbsp;&nbsp;int ret =3D 0;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (s-&gt;connected) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;s-&gt;connected =3D =
true;<br>+<br>+ &nbsp;&nbsp;&nbsp;vsc-&gt;dev.num_queues =3D =
vs-&gt;conf.num_queues;<br>+ &nbsp;&nbsp;&nbsp;vsc-&gt;dev.nvqs =3D =
VIRTIO_SCSI_VQ_NUM_FIXED + vs-&gt;conf.num_queues;<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;dev.vqs =3D s-&gt;vhost_vqs;<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;dev.vq_index =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;dev.backend_features =3D 0;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_init(&amp;vsc-&gt;dev, =
&amp;s-&gt;vhost_user, VHOST_BACKEND_TYPE_USER, 0,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;errp=
);<br>+ &nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return ret;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;/* restore vhost state =
*/<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Should this use =
virtio_device_should_start like vhost_user_blk?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>I will change this.<br><blockquote =
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
&nbsp;&nbsp;&nbsp;if (virtio_device_started(vdev, vdev-&gt;status)) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
0;<br>+}<br>+<br>+static void vhost_user_scsi_event(void *opaque, =
QEMUChrEvent event);<br>+<br>+static void =
vhost_user_scsi_disconnect(DeviceState *dev)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>+ =
&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);<br>+ =
&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>+<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I =
don=E2=80=99t think we want to execute vhost_scsi_common_stop() if the =
device hasn=E2=80=99t been started. I remember that caused a number of =
races with the vhost_user_blk connecting/disconnecting on =
startup.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Let=E2=80=99s add a =
similar started_vu check?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote>I will add it.<br><blockquote =
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
&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;s-&gt;connected =3D =
false;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;vhost_scsi_common_stop(vsc);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;vhost_dev_cleanup(&amp;vsc-&gt;dev);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;/* Re-instate the event handler for new connections =
*/<br>+ =
&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vs-&gt;conf.chardev, =
NULL, NULL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;vhost_user_scsi_event, NULL, dev, NULL, =
true);<br>+}<br>+<br>+static void vhost_user_scsi_event(void *opaque, =
QEMUChrEvent event)<br>+{<br>+ &nbsp;&nbsp;&nbsp;DeviceState *dev =3D =
opaque;<br>+ &nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D =
VIRTIO_DEVICE(dev);<br>+ &nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(vdev);<br>+ &nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>+ &nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>+ &nbsp;&nbsp;&nbsp;Error *local_err =3D =
NULL;<br>+<br>+ &nbsp;&nbsp;&nbsp;switch (event) {<br>+ =
&nbsp;&nbsp;&nbsp;case CHR_EVENT_OPENED:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(vhost_user_scsi_connect(dev, &amp;local_err) &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port_err(local_err);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr=
_fe_disconnect(&amp;vs-&gt;conf.chardev);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<=
br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case CHR_EVENT_CLOSED:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* defer close until later to =
avoid circular close */<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_async_close(dev, =
&amp;vs-&gt;conf.chardev, &amp;vsc-&gt;dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_disconnect);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case CHR_EVENT_BREAK:<br>+ &nbsp;&nbsp;&nbsp;case =
CHR_EVENT_MUX_IN:<br>+ &nbsp;&nbsp;&nbsp;case CHR_EVENT_MUX_OUT:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Ignore */<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static int =
vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error =
**errp)<br>+{<br>+ &nbsp;&nbsp;&nbsp;DeviceState *dev =3D =
&amp;s-&gt;parent_obj.parent_obj.parent_obj.parent_obj;<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);<br>+ =
&nbsp;&nbsp;&nbsp;int ret;<br>+<br>+ &nbsp;&nbsp;&nbsp;s-&gt;connected =3D=
 false;<br>+<br>+ &nbsp;&nbsp;&nbsp;ret =3D =
qemu_chr_fe_wait_connected(&amp;vs-&gt;conf.chardev, errp);<br>+ =
&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return ret;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_connect(dev, errp);<br>+ &nbsp;&nbsp;&nbsp;if (ret &lt; =
0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr_fe_disconnect(&amp;vs-&=
gt;conf.chardev);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>+ &nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;assert(s-&gt;connected);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;return 0;<br>+}<br>+<br>static void =
vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>{<br>&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(dev);<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>- &nbsp;&nbsp;&nbsp;struct vhost_virtqueue *vqs =
=3D NULL;<br>&nbsp;&nbsp;&nbsp;Error *err =3D =
NULL;<br>&nbsp;&nbsp;&nbsp;int ret;<br>+ &nbsp;&nbsp;&nbsp;int retries =3D=
 REALIZE_CONNECTION_RETRIES;<br><br>&nbsp;&nbsp;&nbsp;if =
(!vs-&gt;conf.chardev.chr) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, =
"vhost-user-scsi: missing chardev");<br>@@ -112,21 +224,31 @@ static =
void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;if =
(!vhost_user_init(&amp;s-&gt;vhost_user, &amp;vs-&gt;conf.chardev, =
errp)) {<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Why =
execute vhost_user_cleanup() if vhost_user_init() fails?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>OK, move this line up in =
v2.</div><div><br><blockquote type=3D"cite"><div><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto free_virtio;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
free_vhost;<br>&nbsp;&nbsp;&nbsp;}<br><br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + =
vs-&gt;conf.num_queues;<br>- &nbsp;&nbsp;&nbsp;vsc-&gt;dev.vqs =3D =
g_new0(struct vhost_virtqueue, vsc-&gt;dev.nvqs);<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;dev.vq_index =3D 0;<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;dev.backend_features =3D 0;<br>- =
&nbsp;&nbsp;&nbsp;vqs =3D vsc-&gt;dev.vqs;<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D g_new0(struct vhost_inflight, =
1);<br>+ &nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D g_new0(struct =
vhost_virtqueue,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;VIRTIO_SCSI_VQ_NUM_FIXED + vs-&gt;conf.num_queues);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert(!*errp);<br>+ &nbsp;&nbsp;&nbsp;do {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (*errp) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_pr=
epend(errp, "Reconnecting after error: ");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port_err(*errp);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*errp =
=3D NULL;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_realize_connect(s, errp);<br>+ &nbsp;&nbsp;&nbsp;} while =
(ret &lt; 0 &amp;&amp; retries--);<br><br>- &nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_init(&amp;vsc-&gt;dev, &amp;s-&gt;vhost_user,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VHOS=
T_BACKEND_TYPE_USER, 0, errp);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto free_vhost;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
free_vqs;<br>&nbsp;&nbsp;&nbsp;}<br><br>+ &nbsp;&nbsp;&nbsp;/* we're =
fully initialized, now we can operate, so add the handler */<br>+ =
&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vs-&gt;conf.chardev, =
&nbsp;NULL, NULL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;vhost_user_scsi_event, NULL, (void *)dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;NULL, true);<br>&nbsp;&nbsp;&nbsp;/* Channel and lun =
both are 0 for bootable vhost-user-scsi disk =
*/<br>&nbsp;&nbsp;&nbsp;vsc-&gt;channel =3D =
0;<br>&nbsp;&nbsp;&nbsp;vsc-&gt;lun =3D 0;<br>@@ -134,10 +256,15 @@ =
static void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br><br>&nbsp;&nbsp;&nbsp;return;<br><br>+free_vqs:<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;vhost_vqs);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D NULL;<br>+ =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>+<br>free_vhost:<br>&nbsp;&nbsp;&nbsp;vhost_user_cleanup(&amp;s-&=
gt;vhost_user);<br>- =
&nbsp;&nbsp;&nbsp;g_free(vqs);<br>-free_virtio:<br>+<br>&nbsp;&nbsp;&nbsp;=
virtio_scsi_common_unrealize(dev);<br>}<br><br>@@ -146,16 +273,22 @@ =
static void vhost_user_scsi_unrealize(DeviceState =
*dev)<br>&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D =
VIRTIO_DEVICE(dev);<br>&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(dev);<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>- &nbsp;&nbsp;&nbsp;struct vhost_virtqueue *vqs =
=3D vsc-&gt;dev.vqs;<br>+ &nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br><br>&nbsp;&nbsp;&nbsp;/* This will stop the =
vhost backend. */<br>&nbsp;&nbsp;&nbsp;vhost_user_scsi_set_status(vdev, =
0);<br>+ =
&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vs-&gt;conf.chardev, =
NULL, NULL, NULL, NULL, NULL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;NULL, =
false);<br><br>&nbsp;&nbsp;&nbsp;vhost_dev_cleanup(&amp;vsc-&gt;dev);<br>-=
 &nbsp;&nbsp;&nbsp;g_free(vqs);<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Nit: =
Why not put vhost_dev_free_inflight next to the remaining inflight =
cleanup?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>OK.<br><blockquote type=3D"cite"><div><br =
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
&nbsp;&nbsp;&nbsp;vhost_dev_free_inflight(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;vhost_vqs);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D NULL;<br>+ =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D NULL;<br><br></blockquote><br =
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
display: inline !important;">Curiosity - why reorder here? Is something =
in vhost_user_cleanup() dependent on state freed in =
virtio_scsi_common_unrealize()?</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
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
text-decoration: none; float: none; display: inline !important;">If so, =
should that go as a standalone fix?</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote><div><br></div>Because =
in&nbsp;vhost_user_scsi_realize, we initialize in =
order:</div><div>virtio_scsi_common_realize</div><div>vhost_user_init</div=
><div><br></div><div>And in the error handler =
of&nbsp;vhost_user_scsi_realize, the uninitialize in =
order:</div><div>vhost_user_cleanup</div><div>virtio_scsi_common_unrealize=
</div><div><br></div><div>I think in&nbsp;vhost_user_scsi_unrealize we =
should keep it the same order, right?</div><div><br><blockquote =
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
-webkit-text-stroke-width: 0px; text-decoration: none;">- =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_unrealize(dev);<br>&nbsp;&nbsp;&nbsp;=
vhost_user_cleanup(&amp;s-&gt;vhost_user);<br>+ =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_unrealize(dev);<br>}<br><br>static =
Property vhost_user_scsi_properties[] =3D {<br>diff --git =
a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h<br>index 521b08e559..c66acc68b7 =
100644<br>--- a/include/hw/virtio/vhost-user-scsi.h<br>+++ =
b/include/hw/virtio/vhost-user-scsi.h<br>@@ -29,6 +29,9 @@ =
OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)<br>struct =
VHostUserSCSI {<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon =
parent_obj;<br>&nbsp;&nbsp;&nbsp;VhostUserState =
vhost_user;<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">See =
above - we should probably have started_vu here/</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>I will add it.<br><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Maybe we should have =
some shared struct with vhost_user_blk for connectivity =
params?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><br><div>In the future vhost-user-blk/scsi can =
be refactored to share the same code.</div><blockquote =
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
&nbsp;&nbsp;&nbsp;bool connected;<br>+<br>+ &nbsp;&nbsp;&nbsp;struct =
vhost_virtqueue *vhost_vqs;<br>};<br><br>#endif /* VHOST_USER_SCSI_H =
*/<br>diff --git a/include/hw/virtio/vhost.h =
b/include/hw/virtio/vhost.h<br>index 6a173cb9fa..b904346fe1 =
100644<br>--- a/include/hw/virtio/vhost.h<br>+++ =
b/include/hw/virtio/vhost.h<br>@@ -8,6 +8,8 @@<br>#define =
VHOST_F_DEVICE_IOTLB 63<br>#define VHOST_USER_F_PROTOCOL_FEATURES =
30<br><br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Should =
the macro name indicate that this is for vhost-user?</span><br =
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
display: inline !important;">VU_REALIZE_CONN_RETRIES?<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>I will rename it in =
v2.</div><div><br><blockquote type=3D"cite"><div><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">+#define =
REALIZE_CONNECTION_RETRIES 3<br>+<br>/* Generic structures common for =
any vhost based device. */<br><br>struct vhost_inflight {<br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></div>=
</blockquote></div><br><div></div></body></html>=

--Apple-Mail=_6B70346F-2806-4308-836E-FAEE91C1684D--


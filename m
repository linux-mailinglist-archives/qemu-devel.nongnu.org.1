Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B1761243
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFlm-0005X3-AZ; Tue, 25 Jul 2023 06:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFlh-0005Vs-Tu
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:59:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFlf-0006Rn-0R
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:59:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so16500755ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690282668; x=1690887468;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gUUnfyZgulE9CT2gI5JvKFbOTPKRJ24PVeuS35+EN7s=;
 b=ROmnozTtOR9teUEcPtzQww/nZdRKt+xDMuGGJJwA40cZEEQb6/1OXH4ozoQSzJydcz
 P3B8ycg1TLtniIVBpoHd9SK/9BcyC2cjuK8ox3CD3SoItRZJKE+sq37+AyYWVfQD9T0a
 CmhTELD2NdrzGGnyx0fE4fhzd54+TXctYYYKvLRy8hHnOmbfilDVkQ4WuwVEW1k1w3qs
 9OLWi0nOb+qAkzGov59FYx4y4hKUrCLc+Y2yMJ+bCH4OxUAmiv/wxyTgaNaNw4QkE/CF
 wLIx9dOjlhE8VM1eOiYXpU2Jg03oAZOcTwGvsH42AD3FFc6clRstzX68WVTbzP5qoPK5
 3p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690282668; x=1690887468;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUUnfyZgulE9CT2gI5JvKFbOTPKRJ24PVeuS35+EN7s=;
 b=FCZcKc1VAthbM3VXuBkK4N3SiuTHRzPwdcx1soeK1pH6TDZuSHEmKr+dluiSj5ZALT
 +KNg1Qb0DvPc7HbUcNhfO4HchnEi3qWw9n+Do2Mj6mJ75zUYl+4sgUmXYV/mJ1lVBySi
 7WaPc+oDaUGF2mk7hECBMDJ+l9T5M5PdZBdGKTOF0vKaUI7tYjuFrsjAt9SpfGFJHGde
 s1nEdBwt9NI1cLkH98mGI13oA4my5vsPsEXvHjKxXhCfYwxYGdaWf8RhPbh4vvG5lgFY
 fuCkLf5/GVlQTqgMPivm9Ferqu8xy8NdpfZKSLi0S3kkMC7uW9WkCQILd9a02h2V/jE5
 h0Vg==
X-Gm-Message-State: ABy/qLajHge97ZgAW/Pva0GA+v4H/Z2j21xU+86Jj13erCQ1+aWJ4VLo
 uIpwPI+aMTVWoSz3HwkiYewomA==
X-Google-Smtp-Source: APBJJlFnOzMZBTHTlCvxGWnCe4RQsZCCPBZD5HmJwAH6XQlO+MMKDboY+nJrQtGMo18W9dUQF8sEgQ==
X-Received: by 2002:a17:903:60e:b0:1b8:b288:626e with SMTP id
 kg14-20020a170903060e00b001b8b288626emr11422024plb.35.1690282667563; 
 Tue, 25 Jul 2023 03:57:47 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a170902ce8d00b001b8a8154f3fsm10716833plg.270.2023.07.25.03.57.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jul 2023 03:57:47 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2 4/4] vhost-user-scsi: support reconnect to backend
Date: Tue, 25 Jul 2023 18:58:02 +0800
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-5-fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
In-Reply-To: <20230725104256.4861-5-fengli@smartx.com>
Message-Id: <C7D39EE3-ED41-48E4-BCA4-E975D5D99245@smartx.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



> 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 =E4=B8=8B=E5=8D=886:42=EF=BC=8CLi =
Feng <fengli@smartx.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> If the backend crashes and restarts, the device is broken.
> This patch adds reconnect for vhost-user-scsi.
>=20
> Tested with spdk backend.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> hw/scsi/vhost-scsi-common.c           |   6 +
> hw/scsi/vhost-user-scsi.c             | 220 +++++++++++++++++++++++---
> include/hw/virtio/vhost-scsi-common.h |   3 +
> include/hw/virtio/vhost-user-scsi.h   |   3 +
> 4 files changed, 211 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index 664adb15b4..3fde477eee 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -81,6 +81,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>         error_report("Error start vhost dev");
>         goto err_guest_notifiers;
>     }
> +    vsc->started_vu =3D true;
>=20
>     /* guest_notifier_mask/pending not used yet, so just unmask
>      * everything here.  virtio-pci will do the right thing by
> @@ -106,6 +107,11 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>     int ret =3D 0;
>=20
> +    if (!vsc->started_vu) {
> +        return;
> +    }
> +    vsc->started_vu =3D false;
> +
>     vhost_dev_stop(&vsc->dev, vdev, true);
>=20
>     if (k->set_guest_notifiers) {
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index ee99b19e7a..bd32dcf999 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -46,20 +46,25 @@ enum VhostUserProtocolFeature {
> static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
> {
>     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> -    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && =
vdev->vm_running;
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    bool should_start =3D virtio_device_should_start(vdev, status);
> +    int ret;
>=20
> -    if (vhost_dev_is_started(&vsc->dev) =3D=3D start) {
> +    if (!s->connected) {
>         return;
>     }
>=20
> -    if (start) {
> -        int ret;
> +    if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
> +        return;
> +    }
>=20
> +    if (should_start) {
>         ret =3D vhost_scsi_common_start(vsc);
>         if (ret < 0) {
>             error_report("unable to start vhost-user-scsi: %s", =
strerror(-ret));
> -            exit(1);
> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
>     } else {
>         vhost_scsi_common_stop(vsc);
> @@ -85,8 +90,160 @@ static void vhost_user_scsi_reset(VirtIODevice =
*vdev)
>     }
> }
>=20
> -static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue =
*vq)
> +static void vhost_user_scsi_handle_output(VirtIODevice *vdev, =
VirtQueue *vq)
> {
> +    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +
> +    Error *local_err =3D NULL;
> +    int i, ret;
> +
> +    if (!vdev->start_on_kick) {
> +        return;
> +    }
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +
> +    if (vhost_dev_is_started(&vsc->dev)) {
> +        return;
> +    }
> +
> +    /*
> +     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so =
start
> +     * vhost here instead of waiting for .set_status().
> +     */
> +    ret =3D vhost_scsi_common_start(vsc);
> +    if (ret < 0) {
> +        error_reportf_err(local_err, "vhost-user-blk: vhost start =
failed: =E2=80=9C);

Need fix typo in v3. s/vhost-user-blk/vhost-user-scsi/g

> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> +        return;
> +    }
> +
> +    /* Kick right away to begin processing requests already in vring =
*/
> +    for (i =3D 0; i < vsc->dev.nvqs; i++) {
> +        VirtQueue *kick_vq =3D virtio_get_queue(vdev, i);
> +
> +        if (!virtio_queue_get_desc_addr(vdev, i)) {
> +            continue;
> +        }
> +        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
> +    }
> +}
> +
> +static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    int ret =3D 0;
> +
> +    if (s->connected) {
> +        return 0;
> +    }
> +    s->connected =3D true;
> +
> +    vsc->dev.num_queues =3D vs->conf.num_queues;
> +    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> +    vsc->dev.vqs =3D s->vhost_vqs;
> +    vsc->dev.vq_index =3D 0;
> +    vsc->dev.backend_features =3D 0;
> +
> +    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, =
VHOST_BACKEND_TYPE_USER, 0,
> +                         errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* restore vhost state */
> +    if (virtio_device_started(vdev, vdev->status)) {
> +        ret =3D vhost_scsi_common_start(vsc);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_scsi_disconnect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +    s->connected =3D false;
> +
> +    vhost_scsi_common_stop(vsc);
> +
> +    vhost_dev_cleanup(&vsc->dev);
> +
> +    /* Re-instate the event handler for new connections */
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
> +                             vhost_user_scsi_event, NULL, dev, NULL, =
true);
> +}
> +
> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
> +{
> +    DeviceState *dev =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    Error *local_err =3D NULL;
> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (vhost_user_scsi_connect(dev, &local_err) < 0) {
> +            error_report_err(local_err);
> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
> +            return;
> +        }
> +        break;
> +    case CHR_EVENT_CLOSED:
> +        /* defer close until later to avoid circular close */
> +        vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> +                               vhost_user_scsi_disconnect);
> +        break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
> +    }
> +}
> +
> +static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error =
**errp)
> +{
> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    int ret;
> +
> +    s->connected =3D false;
> +
> +    ret =3D qemu_chr_fe_wait_connected(&vs->conf.chardev, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D vhost_user_scsi_connect(dev, errp);
> +    if (ret < 0) {
> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> +        return ret;
> +    }
> +    assert(s->connected);
> +
> +    return 0;
> }
>=20
> static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
> @@ -94,18 +251,18 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> -    struct vhost_virtqueue *vqs =3D NULL;
>     Error *err =3D NULL;
>     int ret;
> +    int retries =3D VU_REALIZE_CONN_RETRIES;
>=20
>     if (!vs->conf.chardev.chr) {
>         error_setg(errp, "vhost-user-scsi: missing chardev");
>         return;
>     }
>=20
> -    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
> -                               vhost_dummy_handle_output,
> -                               vhost_dummy_handle_output, &err);
> +    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
> +                               vhost_user_scsi_handle_output,
> +                               vhost_user_scsi_handle_output, &err);
>     if (err !=3D NULL) {
>         error_propagate(errp, err);
>         return;
> @@ -115,18 +272,28 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>         goto free_virtio;
>     }
>=20
> -    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> -    vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
> -    vsc->dev.vq_index =3D 0;
> -    vsc->dev.backend_features =3D 0;
> -    vqs =3D vsc->dev.vqs;
> +    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
> +    s->vhost_vqs =3D g_new0(struct vhost_virtqueue,
> +                          VIRTIO_SCSI_VQ_NUM_FIXED + =
vs->conf.num_queues);
> +
> +    assert(!*errp);
> +    do {
> +        if (*errp) {
> +            error_prepend(errp, "Reconnecting after error: ");
> +            error_report_err(*errp);
> +            *errp =3D NULL;
> +        }
> +        ret =3D vhost_user_scsi_realize_connect(s, errp);
> +    } while (ret < 0 && retries--);
>=20
> -    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
>     if (ret < 0) {
>         goto free_vhost;
>     }
>=20
> +    /* we're fully initialized, now we can operate, so add the =
handler */
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
> +                             vhost_user_scsi_event, NULL, (void =
*)dev,
> +                             NULL, true);
>     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
>     vsc->channel =3D 0;
>     vsc->lun =3D 0;
> @@ -135,8 +302,12 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>     return;
>=20
> free_vhost:
> +    g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
> +    g_free(vsc->inflight);
> +    vsc->inflight =3D NULL;
>     vhost_user_cleanup(&s->vhost_user);
> -    g_free(vqs);
> +
> free_virtio:
>     virtio_scsi_common_unrealize(dev);
> }
> @@ -146,16 +317,23 @@ static void =
vhost_user_scsi_unrealize(DeviceState *dev)
>     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> -    struct vhost_virtqueue *vqs =3D vsc->dev.vqs;
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>=20
>     /* This will stop the vhost backend. */
>     vhost_user_scsi_set_status(vdev, 0);
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, =
NULL, NULL,
> +                             NULL, false);
>=20
>     vhost_dev_cleanup(&vsc->dev);
> -    g_free(vqs);
> +    g_free(s->vhost_vqs);
> +    s->vhost_vqs =3D NULL;
> +
> +    vhost_dev_free_inflight(vsc->inflight);
> +    g_free(vsc->inflight);
> +    vsc->inflight =3D NULL;
>=20
> -    virtio_scsi_common_unrealize(dev);
>     vhost_user_cleanup(&s->vhost_user);
> +    virtio_scsi_common_unrealize(dev);
> }
>=20
> static Property vhost_user_scsi_properties[] =3D {
> diff --git a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h
> index 18f115527c..daa183018c 100644
> --- a/include/hw/virtio/vhost-scsi-common.h
> +++ b/include/hw/virtio/vhost-scsi-common.h
> @@ -37,6 +37,9 @@ struct VHostSCSICommon {
>     bool migratable;
>=20
>     struct vhost_inflight *inflight;
> +
> +    /* vhost_scsi_common_start/vhost_scsi_common_stop */
> +    bool started_vu;
> };
>=20
> int vhost_scsi_common_start(VHostSCSICommon *vsc);
> diff --git a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h
> index 521b08e559..c66acc68b7 100644
> --- a/include/hw/virtio/vhost-user-scsi.h
> +++ b/include/hw/virtio/vhost-user-scsi.h
> @@ -29,6 +29,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, =
VHOST_USER_SCSI)
> struct VHostUserSCSI {
>     VHostSCSICommon parent_obj;
>     VhostUserState vhost_user;
> +    bool connected;
> +
> +    struct vhost_virtqueue *vhost_vqs;
> };
>=20
> #endif /* VHOST_USER_SCSI_H */
> --=20
> 2.41.0
>=20



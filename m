Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26457BCD40
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:49:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPS3-0007qD-U0; Sun, 08 Oct 2023 04:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPRy-0007pZ-OU
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:47:46 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPRt-0003Fy-QZ
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:47:46 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ae7383b7ecso1025263566b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696754737; x=1697359537;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vuxt+6VLABmJE/ANWnynG0fYxxqrbKIFHdc5XdVTBvw=;
 b=OSAO4AOAZSGpvDICo0H9PNit+BCr9dCZ20aYaWcJwptGUbKFXo6MlCGgw5hjoHzmiv
 wy0w8bw3ZEndsQboiPwkzq41jfb3ntWMLOsuX4S1JK3N3ZecSBS3cHPTL6cbhxqq1S9R
 w5trsk3cr40NfGdGD0L+XLXsYO4g8oag06a3bJlE8eyxXldveu+SdgHjoN9kTGNFssTx
 7U57TvKJJ+hzqMyk77V2OHlW5zWcxL/73lycphYsCeRfn+zDhOl+ha6uDO3wYXQPWzb0
 YsR7XuAPlaEumOLFfG8mxfvqIvZ1ZRe1tfPLp8cG+mBMqM+nI84vtz91Ra+WmsGebxFP
 qblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696754737; x=1697359537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vuxt+6VLABmJE/ANWnynG0fYxxqrbKIFHdc5XdVTBvw=;
 b=TzyIWn3sjVBBFArRIQZpo5mYrit88XRKswwZLzAdpKBwn/ghCRQspbJP/Lc0VFs9G7
 3WSIASj5K/Z5/KBjoQdW+1YgbcvqEOMVpavlvOa6UHI37krh9GXyIOimCRhP0xvm4eL7
 G8b4ljCUt+uyJWSme8CMRcdcI8oOKH+bTMQDNH7rMzFDmbCjyQTW4UWRueSO7q+CL+dE
 uO9rGH68qCxlcqz6qPcyiPJiQks1CFsw5BV3Gvb6o0nOvxgf3E8ffB3Xj6a9sO7JSpm9
 fgTX39jjxPAyI+4iqifK1/ZWPjXNWXS9JWVIy61VmVxApkXItqUjD9B/md6uqMdzHn9y
 47+Q==
X-Gm-Message-State: AOJu0YwVn/513UUCHaCjKGScoUMBkFnYDN3NLpNjeEUjW0Fb77VMfLxV
 Dg3+dQaDO3tQP73rkNEJyCkFka5wgcHBCaZ8chJvUg==
X-Google-Smtp-Source: AGHT+IF9oVdxYOlwHK1fsfkVJADOLsk0Svpd27b1/M0kcKbI8p4kH8ndT3rz05SG6uV0hweNGBuL5wnyK3FIR4HnRM4=
X-Received: by 2002:a17:906:af10:b0:9ad:8a9e:23ee with SMTP id
 lx16-20020a170906af1000b009ad8a9e23eemr8185069ejb.13.1696754736857; Sun, 08
 Oct 2023 01:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-4-fengli@smartx.com>
 <5FAE8470-7001-4AEC-A138-05E28FFF21F4@nutanix.com>
In-Reply-To: <5FAE8470-7001-4AEC-A138-05E28FFF21F4@nutanix.com>
From: Li Feng <fengli@smartx.com>
Date: Sun, 8 Oct 2023 16:45:38 +0800
Message-ID: <CAHckoCztbiEbmCK2dG6=79FB8ErsrP775tncPL7_H_daggtiiA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] vhost-user-scsi: support reconnect to backend
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::630;
 envelope-from=fengli@smartx.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Sorry, the reply is late due to being on vacation for half a month.

On Fri, Sep 29, 2023 at 8:55=E2=80=AFAM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> One comment on the logging stuff in vhost-scsi. As far as I can tell the =
logging in vhost-user-scsi looks good.
>
> Markus - does this look better to you? Otherwise do you think we should a=
lso fix up the vhost-user-blk realize function?
>
> > On Sep 22, 2023, at 7:46 AM, Li Feng <fengli@smartx.com> wrote:
> >
> > If the backend crashes and restarts, the device is broken.
> > This patch adds reconnect for vhost-user-scsi.
> >
> > This patch also improves the error messages, and reports some silent er=
rors.
> >
> > Tested with spdk backend.
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> > hw/scsi/vhost-scsi-common.c           |  16 +-
> > hw/scsi/vhost-scsi.c                  |   5 +-
> > hw/scsi/vhost-user-scsi.c             | 204 +++++++++++++++++++++++---
> > include/hw/virtio/vhost-scsi-common.h |   2 +-
> > include/hw/virtio/vhost-user-scsi.h   |   4 +
> > 5 files changed, 201 insertions(+), 30 deletions(-)
> >
> > diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> > index a61cd0e907..4c8637045d 100644
> > --- a/hw/scsi/vhost-scsi-common.c
> > +++ b/hw/scsi/vhost-scsi-common.c
> > @@ -16,6 +16,7 @@
> >  */
> >
> > #include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > #include "qemu/error-report.h"
> > #include "qemu/module.h"
> > #include "hw/virtio/vhost.h"
> > @@ -25,7 +26,7 @@
> > #include "hw/virtio/virtio-access.h"
> > #include "hw/fw-path-provider.h"
> >
> > -int vhost_scsi_common_start(VHostSCSICommon *vsc)
> > +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
> > {
> >     int ret, i;
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
> > @@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> >     VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;
> >
> >     if (!k->set_guest_notifiers) {
> > -        error_report("binding does not support guest notifiers");
> > +        error_setg(errp, "binding does not support guest notifiers");
> >         return -ENOSYS;
> >     }
> >
> >     ret =3D vhost_dev_enable_notifiers(&vsc->dev, vdev);
> >     if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Error enabling host notifiers");
> >         return ret;
> >     }
> >
> >     ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
> >     if (ret < 0) {
> > -        error_report("Error binding guest notifier");
> > +        error_setg_errno(errp, -ret, "Error binding guest notifier");
> >         goto err_host_notifiers;
> >     }
> >
> > @@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> >
> >     ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
> >     if (ret < 0) {
> > -        error_report("Error setting inflight format: %d", -ret);
> > +        error_setg_errno(errp, -ret, "Error setting inflight format");
> >         goto err_guest_notifiers;
> >     }
> >
> > @@ -64,21 +66,21 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> >                                         vs->conf.virtqueue_size,
> >                                         vsc->inflight);
> >             if (ret < 0) {
> > -                error_report("Error getting inflight: %d", -ret);
> > +                error_setg_errno(errp, -ret, "Error getting inflight")=
;
> >                 goto err_guest_notifiers;
> >             }
> >         }
> >
> >         ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> >         if (ret < 0) {
> > -            error_report("Error setting inflight: %d", -ret);
> > +            error_setg_errno(errp, -ret, "Error setting inflight");
> >             goto err_guest_notifiers;
> >         }
> >     }
> >
> >     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
> >     if (ret < 0) {
> > -        error_report("Error start vhost dev");
> > +        error_setg_errno(errp, -ret, "Error starting vhost dev");
> >         goto err_guest_notifiers;
> >     }
> >
> > diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> > index 443f67daa4..01a3ab4277 100644
> > --- a/hw/scsi/vhost-scsi.c
> > +++ b/hw/scsi/vhost-scsi.c
> > @@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
> >     int ret, abi_version;
> >     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> >     const VhostOps *vhost_ops =3D vsc->dev.vhost_ops;
> > +    Error *local_err =3D NULL;
> >
> >     ret =3D vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, &abi_versi=
on);
> >     if (ret < 0) {
> > @@ -88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI *s)
> >         return -ENOSYS;
> >     }
> >
> > -    ret =3D vhost_scsi_common_start(vsc);
> > +    ret =3D vhost_scsi_common_start(vsc, &local_err);
> >     if (ret < 0) {
>
> Why aren=E2=80=99t you reporting the error here?
I will add reporting the error in the next version.

>
> >         return ret;
> >     }
> >
> >     ret =3D vhost_scsi_set_endpoint(s);
> >     if (ret < 0) {
> > -        error_report("Error setting vhost-scsi endpoint");
> > +        error_reportf_err(local_err, "Error setting vhost-scsi endpoin=
t");
> >         vhost_scsi_common_stop(vsc);
> >     }
> >
> > diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> > index ee99b19e7a..dc109154ad 100644
> > --- a/hw/scsi/vhost-user-scsi.c
> > +++ b/hw/scsi/vhost-user-scsi.c
> > @@ -43,26 +43,56 @@ enum VhostUserProtocolFeature {
> >     VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> > };
> >
> > +static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
> > +{
> > +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > +    int ret;
> > +
> > +    ret =3D vhost_scsi_common_start(vsc, errp);
> > +    s->started_vu =3D (ret < 0 ? false : true);
> > +
> > +    return ret;
> > +}
> > +
> > +static void vhost_user_scsi_stop(VHostUserSCSI *s)
> > +{
> > +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > +
> > +    if (!s->started_vu) {
> > +        return;
> > +    }
> > +    s->started_vu =3D false;
> > +
> > +    vhost_scsi_common_stop(vsc);
> > +}
> > +
> > static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t stat=
us)
> > {
> >     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
> > +    DeviceState *dev =3D &s->parent_obj.parent_obj.parent_obj.parent_o=
bj;
> >     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > -    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_ru=
nning;
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> > +    bool should_start =3D virtio_device_should_start(vdev, status);
> > +    Error *local_err =3D NULL;
> > +    int ret;
> >
> > -    if (vhost_dev_is_started(&vsc->dev) =3D=3D start) {
> > +    if (!s->connected) {
> >         return;
> >     }
> >
> > -    if (start) {
> > -        int ret;
> > +    if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
> > +        return;
> > +    }
> >
> > -        ret =3D vhost_scsi_common_start(vsc);
> > +    if (should_start) {
> > +        ret =3D vhost_user_scsi_start(s, &local_err);
> >         if (ret < 0) {
> > -            error_report("unable to start vhost-user-scsi: %s", strerr=
or(-ret));
> > -            exit(1);
> > +            error_reportf_err(local_err, "unable to start vhost-user-s=
csi: %s",
> > +                              strerror(-ret));
> > +            qemu_chr_fe_disconnect(&vs->conf.chardev);
> >         }
> >     } else {
> > -        vhost_scsi_common_stop(vsc);
> > +        vhost_user_scsi_stop(s);
> >     }
> > }
> >
> > @@ -89,14 +119,127 @@ static void vhost_dummy_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
> > {
> > }
> >
> > +static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> > +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> > +    int ret =3D 0;
> > +
> > +    if (s->connected) {
> > +        return 0;
> > +    }
> > +    s->connected =3D true;
> > +
> > +    vsc->dev.num_queues =3D vs->conf.num_queues;
> > +    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> > +    vsc->dev.vqs =3D s->vhost_vqs;
> > +    vsc->dev.vq_index =3D 0;
> > +    vsc->dev.backend_features =3D 0;
> > +
> > +    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TY=
PE_USER, 0,
> > +                         errp);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    /* restore vhost state */
> > +    if (virtio_device_started(vdev, vdev->status)) {
> > +        ret =3D vhost_user_scsi_start(s, errp);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event);
> > +
> > +static void vhost_user_scsi_disconnect(DeviceState *dev)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> > +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> > +
> > +    if (!s->connected) {
> > +        return;
> > +    }
> > +    s->connected =3D false;
> > +
> > +    vhost_user_scsi_stop(s);
> > +
> > +    vhost_dev_cleanup(&vsc->dev);
> > +
> > +    /* Re-instate the event handler for new connections */
> > +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
> > +                             vhost_user_scsi_event, NULL, dev, NULL, t=
rue);
> > +}
> > +
> > +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
> > +{
> > +    DeviceState *dev =3D opaque;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> > +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> > +    Error *local_err =3D NULL;
> > +
> > +    switch (event) {
> > +    case CHR_EVENT_OPENED:
> > +        if (vhost_user_scsi_connect(dev, &local_err) < 0) {
> > +            error_report_err(local_err);
> > +            qemu_chr_fe_disconnect(&vs->conf.chardev);
> > +            return;
> > +        }
> > +        break;
> > +    case CHR_EVENT_CLOSED:
> > +        /* defer close until later to avoid circular close */
> > +        vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
> > +                               vhost_user_scsi_disconnect);
> > +        break;
> > +    case CHR_EVENT_BREAK:
> > +    case CHR_EVENT_MUX_IN:
> > +    case CHR_EVENT_MUX_OUT:
> > +        /* Ignore */
> > +        break;
> > +    }
> > +}
> > +
> > +static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error **e=
rrp)
> > +{
> > +    DeviceState *dev =3D &s->parent_obj.parent_obj.parent_obj.parent_o=
bj;
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> > +    int ret;
> > +
> > +    s->connected =3D false;
> > +
> > +    ret =3D qemu_chr_fe_wait_connected(&vs->conf.chardev, errp);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    ret =3D vhost_user_scsi_connect(dev, errp);
> > +    if (ret < 0) {
> > +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> > +        return ret;
> > +    }
> > +    assert(s->connected);
> > +
> > +    return 0;
> > +}
> > +
> > static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
> > {
> > +    ERRP_GUARD();
> >     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> >     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
> >     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > -    struct vhost_virtqueue *vqs =3D NULL;
> >     Error *err =3D NULL;
> >     int ret;
> > +    int retries =3D VU_REALIZE_CONN_RETRIES;
> >
> >     if (!vs->conf.chardev.chr) {
> >         error_setg(errp, "vhost-user-scsi: missing chardev");
> > @@ -115,18 +258,28 @@ static void vhost_user_scsi_realize(DeviceState *=
dev, Error **errp)
> >         goto free_virtio;
> >     }
> >
> > -    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> > -    vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
> > -    vsc->dev.vq_index =3D 0;
> > -    vsc->dev.backend_features =3D 0;
> > -    vqs =3D vsc->dev.vqs;
> > +    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
> > +    s->vhost_vqs =3D g_new0(struct vhost_virtqueue,
> > +                          VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queu=
es);
> > +
> > +    assert(!*errp);
> > +    do {
> > +        if (*errp) {
> > +            error_prepend(errp, "Reconnecting after error: ");
> > +            error_report_err(*errp);
> > +            *errp =3D NULL;
> > +        }
> > +        ret =3D vhost_user_scsi_realize_connect(s, errp);
> > +    } while (ret < 0 && retries--);
> >
> > -    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user,
> > -                         VHOST_BACKEND_TYPE_USER, 0, errp);
> >     if (ret < 0) {
> >         goto free_vhost;
> >     }
> >
> > +    /* we're fully initialized, now we can operate, so add the handler=
 */
> > +    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
> > +                             vhost_user_scsi_event, NULL, (void *)dev,
> > +                             NULL, true);
> >     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
> >     vsc->channel =3D 0;
> >     vsc->lun =3D 0;
> > @@ -135,8 +288,12 @@ static void vhost_user_scsi_realize(DeviceState *d=
ev, Error **errp)
> >     return;
> >
> > free_vhost:
> > +    g_free(s->vhost_vqs);
> > +    s->vhost_vqs =3D NULL;
> > +    g_free(vsc->inflight);
> > +    vsc->inflight =3D NULL;
> >     vhost_user_cleanup(&s->vhost_user);
> > -    g_free(vqs);
> > +
> > free_virtio:
> >     virtio_scsi_common_unrealize(dev);
> > }
> > @@ -146,16 +303,23 @@ static void vhost_user_scsi_unrealize(DeviceState=
 *dev)
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
> >     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> > -    struct vhost_virtqueue *vqs =3D vsc->dev.vqs;
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> >
> >     /* This will stop the vhost backend. */
> >     vhost_user_scsi_set_status(vdev, 0);
> > +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, NULL=
, NULL,
> > +                             NULL, false);
> >
> >     vhost_dev_cleanup(&vsc->dev);
> > -    g_free(vqs);
> > +    g_free(s->vhost_vqs);
> > +    s->vhost_vqs =3D NULL;
> > +
> > +    vhost_dev_free_inflight(vsc->inflight);
> > +    g_free(vsc->inflight);
> > +    vsc->inflight =3D NULL;
> >
> > -    virtio_scsi_common_unrealize(dev);
> >     vhost_user_cleanup(&s->vhost_user);
> > +    virtio_scsi_common_unrealize(dev);
> > }
> >
> > static Property vhost_user_scsi_properties[] =3D {
> > diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/=
vhost-scsi-common.h
> > index 18f115527c..c5d2c09455 100644
> > --- a/include/hw/virtio/vhost-scsi-common.h
> > +++ b/include/hw/virtio/vhost-scsi-common.h
> > @@ -39,7 +39,7 @@ struct VHostSCSICommon {
> >     struct vhost_inflight *inflight;
> > };
> >
> > -int vhost_scsi_common_start(VHostSCSICommon *vsc);
> > +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
> > void vhost_scsi_common_stop(VHostSCSICommon *vsc);
> > char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bu=
s,
> >                                         DeviceState *dev);
> > diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vh=
ost-user-scsi.h
> > index 521b08e559..b405ec952a 100644
> > --- a/include/hw/virtio/vhost-user-scsi.h
> > +++ b/include/hw/virtio/vhost-user-scsi.h
> > @@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER=
_SCSI)
> > struct VHostUserSCSI {
> >     VHostSCSICommon parent_obj;
> >     VhostUserState vhost_user;
> > +    bool connected;
> > +    bool started_vu;
> > +
> > +    struct vhost_virtqueue *vhost_vqs;
> > };
> >
> > #endif /* VHOST_USER_SCSI_H */
> > --
> > 2.41.0
> >
>


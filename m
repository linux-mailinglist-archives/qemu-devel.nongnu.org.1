Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144C769314
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ7J-0000os-15; Mon, 31 Jul 2023 06:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQQ7F-0000oV-RN
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:27:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQQ7C-0006SD-Ft
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:27:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so26218105ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690799098; x=1691403898;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HHVOO507WMCWVIaHVhE22HQJutb+/PXxYQam39z3MOM=;
 b=vXhUJu/5FNVX0h4wx+/exy0QbIlFFGu4TjXk6Elemrfq9fZMJffVRuoRKB4yYoVRYy
 6gPDNMIquSaVJdoHnyM5R/GcVro5Yc8xqrWEMCjWAz0Dwy0Yuroe+3ukM9h8eFwA54kp
 JDdOjWfxnSW2g9r8tVH76cguPgkZWRcJ4xI89wQrme1twXjMf3p+KjiK+7q0+O2Cu/sz
 PtsNk2U9nyy45qO9RN5TSDCSBQnUGzfZ6dXQvodSEEIhqA/7V2tWp6p4HVIlkEb99Z6n
 Tb46BxahSYHAurX1XphxQ/L72AppwmWht9ZzQWh5q5b5i++8TMFOdcns5BbVHxyLTrjB
 okyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690799098; x=1691403898;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHVOO507WMCWVIaHVhE22HQJutb+/PXxYQam39z3MOM=;
 b=Ukvo7e5f6zAt+F6YfnJfyXrnhuC8l/kuucFk3fujtyyi63kuY0a42lkkKzSRQZN26u
 bRjqNSNG/a/BZ7biM/6ivUYL4zsAhXIJlgmPWb1TR/wzFlYkweW0aGYq3Vvh3ZcYasds
 fhtmT77bW8ArB/d3VkeX1z6joFRv6UbiJkMeLpMoj3fnsRU2YXl+NuzVbNUgaPGjkKPb
 +H2Sf3plltpbT/5+IkRpNNRwLqEgrEIEVPxApIv0R95ZVacHGWiMd3ZhM7/YYDGsRDBH
 97J4geP02rID8YP6VE+Cw6HaaoO+bN91eyeFjICEUdxoejYueOnfgRAfdu3u+/wpHMn/
 Y9eA==
X-Gm-Message-State: ABy/qLbIM9X2ZsmIcSTv1qfLSn2OXd2oVkli0NnzWzZcORIP9hzsNGD1
 X0XNUWr2V68y6PP8jeJYJXVqXA==
X-Google-Smtp-Source: APBJJlFx/CvnalGSnBqporkVqGvU5Ooe5odCslX+dRDmHibMOYFabiqgAH3Z1o2CZ2gaSaRVKX+T/g==
X-Received: by 2002:a17:903:22c6:b0:1b8:41d4:89f with SMTP id
 y6-20020a17090322c600b001b841d4089fmr10458009plg.4.1690799097681; 
 Mon, 31 Jul 2023 03:24:57 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001b895336435sm8191122plh.21.2023.07.31.03.24.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Jul 2023 03:24:57 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <42A93C4C-744A-422D-8625-3EF690213D25@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_82DA13C4-9DD1-4253-BEB6-3F4DAE7AD2D4"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2 4/4] vhost-user-scsi: support reconnect to backend
Date: Mon, 31 Jul 2023 18:24:42 +0800
In-Reply-To: <14A00D6C-521C-4007-8962-10870AD87142@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-5-fengli@smartx.com>
 <14A00D6C-521C-4007-8962-10870AD87142@nutanix.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


--Apple-Mail=_82DA13C4-9DD1-4253-BEB6-3F4DAE7AD2D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2023=E5=B9=B47=E6=9C=8831=E6=97=A5 06:14=EF=BC=8CRaphael Norwitz =
<raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> I don=E2=80=99t think we should be changing any vhost-scsi-common code =
here. I=E2=80=99d rather implement wrappers around =
vhost_user_scsi_start/stop() around vhost_user_scsi_common_start/stop() =
and check started_vu there.
>=20
> Otherwise I think this is looking good.=20
>=20
> Glad to see you caught the vhost_user_scsi_handle_ouptut and =
implemented it like vhost-user-blk. Can it go in a separate change?

I will fix it in v3.

>=20
>> On Jul 25, 2023, at 6:42 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>> If the backend crashes and restarts, the device is broken.
>> This patch adds reconnect for vhost-user-scsi.
>>=20
>> Tested with spdk backend.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/scsi/vhost-scsi-common.c           |   6 +
>> hw/scsi/vhost-user-scsi.c             | 220 =
+++++++++++++++++++++++---
>> include/hw/virtio/vhost-scsi-common.h |   3 +
>> include/hw/virtio/vhost-user-scsi.h   |   3 +
>> 4 files changed, 211 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>> index 664adb15b4..3fde477eee 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -81,6 +81,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>        error_report("Error start vhost dev");
>>        goto err_guest_notifiers;
>>    }
>> +    vsc->started_vu =3D true;
>>=20
>>    /* guest_notifier_mask/pending not used yet, so just unmask
>>     * everything here.  virtio-pci will do the right thing by
>> @@ -106,6 +107,11 @@ void vhost_scsi_common_stop(VHostSCSICommon =
*vsc)
>>    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>>    int ret =3D 0;
>>=20
>> +    if (!vsc->started_vu) {
>> +        return;
>> +    }
>> +    vsc->started_vu =3D false;
>> +
>>    vhost_dev_stop(&vsc->dev, vdev, true);
>>=20
>>    if (k->set_guest_notifiers) {
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index ee99b19e7a..bd32dcf999 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -46,20 +46,25 @@ enum VhostUserProtocolFeature {
>> static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
>> {
>>    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && =
vdev->vm_running;
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +    bool should_start =3D virtio_device_should_start(vdev, status);
>> +    int ret;
>>=20
>> -    if (vhost_dev_is_started(&vsc->dev) =3D=3D start) {
>> +    if (!s->connected) {
>>        return;
>>    }
>>=20
>> -    if (start) {
>> -        int ret;
>> +    if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
>> +        return;
>> +    }
>>=20
>> +    if (should_start) {
>>        ret =3D vhost_scsi_common_start(vsc);
>>        if (ret < 0) {
>>            error_report("unable to start vhost-user-scsi: %s", =
strerror(-ret));
>> -            exit(1);
>> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
>>        }
>>    } else {
>>        vhost_scsi_common_stop(vsc);
>> @@ -85,8 +90,160 @@ static void vhost_user_scsi_reset(VirtIODevice =
*vdev)
>>    }
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
>> +    ret =3D vhost_scsi_common_start(vsc);
>> +    if (ret < 0) {
>> +        error_reportf_err(local_err, "vhost-user-blk: vhost start =
failed: ");
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
>> +}
>> +
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
>> }
>>=20
>> static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>> @@ -94,18 +251,18 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>    VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    struct vhost_virtqueue *vqs =3D NULL;
>>    Error *err =3D NULL;
>>    int ret;
>> +    int retries =3D VU_REALIZE_CONN_RETRIES;
>>=20
>>    if (!vs->conf.chardev.chr) {
>>        error_setg(errp, "vhost-user-scsi: missing chardev");
>>        return;
>>    }
>>=20
>> -    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
>> -                               vhost_dummy_handle_output,
>> -                               vhost_dummy_handle_output, &err);
>> +    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
>> +                               vhost_user_scsi_handle_output,
>> +                               vhost_user_scsi_handle_output, &err);
>>    if (err !=3D NULL) {
>>        error_propagate(errp, err);
>>        return;
>> @@ -115,18 +272,28 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>        goto free_virtio;
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
>>        goto free_vhost;
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
>> @@ -135,8 +302,12 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>    return;
>>=20
>> free_vhost:
>> +    g_free(s->vhost_vqs);
>> +    s->vhost_vqs =3D NULL;
>> +    g_free(vsc->inflight);
>> +    vsc->inflight =3D NULL;
>>    vhost_user_cleanup(&s->vhost_user);
>> -    g_free(vqs);
>> +
>> free_virtio:
>>    virtio_scsi_common_unrealize(dev);
>> }
>> @@ -146,16 +317,23 @@ static void =
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
>> +    g_free(s->vhost_vqs);
>> +    s->vhost_vqs =3D NULL;
>> +
>> +    vhost_dev_free_inflight(vsc->inflight);
>> +    g_free(vsc->inflight);
>> +    vsc->inflight =3D NULL;
>>=20
>> -    virtio_scsi_common_unrealize(dev);
>>    vhost_user_cleanup(&s->vhost_user);
>> +    virtio_scsi_common_unrealize(dev);
>> }
>>=20
>> static Property vhost_user_scsi_properties[] =3D {
>> diff --git a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h
>> index 18f115527c..daa183018c 100644
>> --- a/include/hw/virtio/vhost-scsi-common.h
>> +++ b/include/hw/virtio/vhost-scsi-common.h
>> @@ -37,6 +37,9 @@ struct VHostSCSICommon {
>>    bool migratable;
>>=20
>>    struct vhost_inflight *inflight;
>> +
>> +    /* vhost_scsi_common_start/vhost_scsi_common_stop */
>> +    bool started_vu;
>=20
> Move to include/hw/virtio/vhost-user-scsi.h

I will fix it in v3.

>=20
>> };
>>=20
>> int vhost_scsi_common_start(VHostSCSICommon *vsc);
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
>> +    bool connected;
>> +
>> +    struct vhost_virtqueue *vhost_vqs;
>> };
>>=20
>> #endif /* VHOST_USER_SCSI_H */
>> --=20
>> 2.41.0


--Apple-Mail=_82DA13C4-9DD1-4253-BEB6-3F4DAE7AD2D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote =
type=3D"cite"><div>2023=E5=B9=B47=E6=9C=8831=E6=97=A5 06:14=EF=BC=8CRaphae=
l Norwitz &lt;raphael.norwitz@nutanix.com&gt; =E5=86=99=E9=81=93=EF=BC=9A<=
/div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">I don=E2=80=99t think we =
should be changing any vhost-scsi-common code here. I=E2=80=99d rather =
implement wrappers around vhost_user_scsi_start/stop() around =
vhost_user_scsi_common_start/stop() and check started_vu =
there.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Otherwise I think this =
is looking good.<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Glad to see you caught the =
vhost_user_scsi_handle_ouptut and implemented it like vhost-user-blk. =
Can it go in a separate change?</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote><div><br></div><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">I will fix it =
in v3.</span></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);"><br></span></font><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">On Jul 25, 2023, =
at 6:42 AM, Li Feng &lt;fengli@smartx.com&gt; wrote:<br><br>If the =
backend crashes and restarts, the device is broken.<br>This patch adds =
reconnect for vhost-user-scsi.<br><br>Tested with spdk =
backend.<br><br>Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-scsi-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;6 +<br>hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
220 +++++++++++++++++++++++---<br>include/hw/virtio/vhost-scsi-common.h =
| &nbsp;&nbsp;3 +<br>include/hw/virtio/vhost-user-scsi.h &nbsp;&nbsp;| =
&nbsp;&nbsp;3 +<br>4 files changed, 211 insertions(+), 21 =
deletions(-)<br><br>diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c<br>index 664adb15b4..3fde477eee =
100644<br>--- a/hw/scsi/vhost-scsi-common.c<br>+++ =
b/hw/scsi/vhost-scsi-common.c<br>@@ -81,6 +81,7 @@ int =
vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error =
start vhost dev");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;started_vu =3D =
true;<br><br>&nbsp;&nbsp;&nbsp;/* guest_notifier_mask/pending not used =
yet, so just unmask<br>&nbsp;&nbsp;&nbsp;&nbsp;* everything here. =
&nbsp;virtio-pci will do the right thing by<br>@@ -106,6 +107,11 @@ void =
vhost_scsi_common_stop(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;VirtioBusClass *k =3D =
VIRTIO_BUS_GET_CLASS(qbus);<br>&nbsp;&nbsp;&nbsp;int ret =3D 0;<br><br>+ =
&nbsp;&nbsp;&nbsp;if (!vsc-&gt;started_vu) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;vsc-&gt;started_vu =3D =
false;<br>+<br>&nbsp;&nbsp;&nbsp;vhost_dev_stop(&amp;vsc-&gt;dev, vdev, =
true);<br><br>&nbsp;&nbsp;&nbsp;if (k-&gt;set_guest_notifiers) {<br>diff =
--git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>index =
ee99b19e7a..bd32dcf999 100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -46,20 +46,25 @@ enum =
VhostUserProtocolFeature {<br>static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)<br>{<br>&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D (VHostUserSCSI =
*)vdev;<br>+ &nbsp;&nbsp;&nbsp;DeviceState *dev =3D =
&amp;s-&gt;parent_obj.parent_obj.parent_obj.parent_obj;<br>&nbsp;&nbsp;&nb=
sp;VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);<br>- =
&nbsp;&nbsp;&nbsp;bool start =3D (status &amp; =
VIRTIO_CONFIG_S_DRIVER_OK) &amp;&amp; vdev-&gt;vm_running;<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);<br>+ =
&nbsp;&nbsp;&nbsp;bool should_start =3D virtio_device_should_start(vdev, =
status);<br>+ &nbsp;&nbsp;&nbsp;int ret;<br><br>- &nbsp;&nbsp;&nbsp;if =
(vhost_dev_is_started(&amp;vsc-&gt;dev) =3D=3D start) {<br>+ =
&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>&nbsp;&nbsp;&nbs=
p;}<br><br>- &nbsp;&nbsp;&nbsp;if (start) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int ret;<br>+ =
&nbsp;&nbsp;&nbsp;if (vhost_dev_is_started(&amp;vsc-&gt;dev) =3D=3D =
should_start) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br><br>+ &nbsp;&nbsp;&nbsp;if (should_start) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;if (ret &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;err=
or_report("unable to start vhost-user-scsi: %s", strerror(-ret));<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);=
<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr=
_fe_disconnect(&amp;vs-&gt;conf.chardev);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;} else =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_scsi_common_stop(vsc)=
;<br>@@ -85,8 +90,160 @@ static void vhost_user_scsi_reset(VirtIODevice =
*vdev)<br>&nbsp;&nbsp;&nbsp;}<br>}<br><br>-static void =
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
vhost_scsi_common_start(vsc);<br>+ &nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"vhost-user-blk: vhost start failed: ");<br>+ =
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
get_host_notifier(kick_vq));<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static int =
vhost_user_scsi_connect(DeviceState *dev, Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>+ =
&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);<br>+ =
&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);<br>+ =
&nbsp;&nbsp;&nbsp;int ret =3D 0;<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(s-&gt;connected) {<br>+ =
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
*/<br>+ &nbsp;&nbsp;&nbsp;if (virtio_device_started(vdev, =
vdev-&gt;status)) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D=
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
VIRTIO_SCSI_COMMON(dev);<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!s-&gt;connected) {<br>+ =
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
&nbsp;&nbsp;&nbsp;return 0;<br>}<br><br>static void =
vhost_user_scsi_realize(DeviceState *dev, Error **errp)<br>@@ -94,18 =
+251,18 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(dev);<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>- &nbsp;&nbsp;&nbsp;struct vhost_virtqueue *vqs =
=3D NULL;<br>&nbsp;&nbsp;&nbsp;Error *err =3D =
NULL;<br>&nbsp;&nbsp;&nbsp;int ret;<br>+ &nbsp;&nbsp;&nbsp;int retries =3D=
 VU_REALIZE_CONN_RETRIES;<br><br>&nbsp;&nbsp;&nbsp;if =
(!vs-&gt;conf.chardev.chr) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, =
"vhost-user-scsi: missing =
chardev");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>&nbsp;&=
nbsp;&nbsp;}<br><br>- &nbsp;&nbsp;&nbsp;virtio_scsi_common_realize(dev, =
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
&amp;err);<br>&nbsp;&nbsp;&nbsp;if (err !=3D NULL) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_propagate(errp, =
err);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>@@ -115,18 =
+272,28 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
free_virtio;<br>&nbsp;&nbsp;&nbsp;}<br><br>- =
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
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
free_vhost;<br>&nbsp;&nbsp;&nbsp;}<br><br>+ &nbsp;&nbsp;&nbsp;/* we're =
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
0;<br>&nbsp;&nbsp;&nbsp;vsc-&gt;lun =3D 0;<br>@@ -135,8 +302,12 @@ =
static void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;return;<br><br>free_vhost:<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;vhost_vqs);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D NULL;<br>+ =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>&nbsp;&nbsp;&nbsp;vhost_user_cleanup(&amp;s-&gt;vhost_user);<br>-=
 =
&nbsp;&nbsp;&nbsp;g_free(vqs);<br>+<br>free_virtio:<br>&nbsp;&nbsp;&nbsp;v=
irtio_scsi_common_unrealize(dev);<br>}<br>@@ -146,16 +317,23 @@ static =
void vhost_user_scsi_unrealize(DeviceState =
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
 &nbsp;&nbsp;&nbsp;g_free(vqs);<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;vhost_vqs);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D NULL;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;vhost_dev_free_inflight(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D NULL;<br><br>- =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_unrealize(dev);<br>&nbsp;&nbsp;&nbsp;=
vhost_user_cleanup(&amp;s-&gt;vhost_user);<br>+ =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_unrealize(dev);<br>}<br><br>static =
Property vhost_user_scsi_properties[] =3D {<br>diff --git =
a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h<br>index 18f115527c..daa183018c =
100644<br>--- a/include/hw/virtio/vhost-scsi-common.h<br>+++ =
b/include/hw/virtio/vhost-scsi-common.h<br>@@ -37,6 +37,9 @@ struct =
VHostSCSICommon {<br>&nbsp;&nbsp;&nbsp;bool =
migratable;<br><br>&nbsp;&nbsp;&nbsp;struct vhost_inflight =
*inflight;<br>+<br>+ &nbsp;&nbsp;&nbsp;/* =
vhost_scsi_common_start/vhost_scsi_common_stop */<br>+ =
&nbsp;&nbsp;&nbsp;bool started_vu;<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Move to =
include/hw/virtio/vhost-user-scsi.h</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote><div><br></div><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">I will fix it =
in v3.</span></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);"><br></span></font><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">};<br><br>int =
vhost_scsi_common_start(VHostSCSICommon *vsc);<br>diff --git =
a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h<br>index 521b08e559..c66acc68b7 =
100644<br>--- a/include/hw/virtio/vhost-user-scsi.h<br>+++ =
b/include/hw/virtio/vhost-user-scsi.h<br>@@ -29,6 +29,9 @@ =
OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)<br>struct =
VHostUserSCSI {<br>&nbsp;&nbsp;&nbsp;VHostSCSICommon =
parent_obj;<br>&nbsp;&nbsp;&nbsp;VhostUserState vhost_user;<br>+ =
&nbsp;&nbsp;&nbsp;bool connected;<br>+<br>+ &nbsp;&nbsp;&nbsp;struct =
vhost_virtqueue *vhost_vqs;<br>};<br><br>#endif /* VHOST_USER_SCSI_H =
*/<br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></div>=
</blockquote></div><br></body></html>=

--Apple-Mail=_82DA13C4-9DD1-4253-BEB6-3F4DAE7AD2D4--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB9879C9FF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfyo5-0002bO-9R; Tue, 12 Sep 2023 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfynt-0002YC-1C
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:31:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfynm-0007vd-Jk
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:31:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c1f7f7151fso38032855ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694507353; x=1695112153;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sWi+uuvZm659OlJ8pAEqhenCk1met6FIGA/bZK55QeM=;
 b=t333aTSS9KYRtjahFHi+oxpWNNNXS8U203Gh6paxPKxJ/eW490jOSMzDyAFJviZb8X
 O4NJWhDh/ssPTaKGoCnNEiRqflilcOZCLBlFLrljSku+L1XMkErp33Tc27x5hH8wWzDT
 aJvnZyjOC92OyGYEHhN/W+VJxLRXizMrCZJ9zvECtviJCdUbN+RNl/MzFnZU3RzpZelD
 sE++6QmeNqPX/De9l1ZSfmIhVOxYkh3VTraBeVEjMCfCUc9loVmzLikjPYvsUTZlQcxm
 zhP4TiQXFx+kiEV4OEcgQjA/pWtrchahrK2escNxGQlqXgFvX+6OJlSkabeaOmtic1S9
 ZSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694507353; x=1695112153;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sWi+uuvZm659OlJ8pAEqhenCk1met6FIGA/bZK55QeM=;
 b=ZP6EhLDrbH1eLFWiebRId/LXHRIbk33ZY30VcuFYFvnipbiiJDG8lJJhQnPeFl3GKM
 QaxWzpzXj5NoNHu5621/8MwLeCXVHuuEvSdrk/KvF5+YgE/mvirdwziHpGf3BkOoGlSH
 aej29XarVdLq9N/eBxCqsItl5HXgPZEGESthaW1iJgAuXnvRCq1a/KTusEh2mNs9JyrF
 iKllH28a8NDVWdyNeKRtDAkYz2cb2Au7x/PvDrV4ZaUPnJep/6YN7FQHcDGIpuQ86BV2
 wMRsdcdUu5GOHM3CshuJip10rMHowRqn1BRl7bgvFkJuUYZ/rbvikld+AgjbtH32Rvk0
 IqYg==
X-Gm-Message-State: AOJu0YxqJEyeZ0GCVwQ9dvYyR3S1zQ8X+Egf6RSt1WyPqCj3w5WZGLSo
 GSHOIPg9sv0krp0Z+SKrCdhJJQ==
X-Google-Smtp-Source: AGHT+IH2DrNlrgnfOSOkBTEOYOhLfozfXsEU4sbkFlbjkpZhxD0EOtBvava2nGXQckuIu2L0d4Wqjg==
X-Received: by 2002:a17:902:c10d:b0:1c3:6e38:3940 with SMTP id
 13-20020a170902c10d00b001c36e383940mr10851625pli.7.1694507352540; 
 Tue, 12 Sep 2023 01:29:12 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001aadd0d7364sm7850737plg.83.2023.09.12.01.29.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Sep 2023 01:29:12 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <632E77E6-0EA3-419C-A610-D107CA37A479@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_5CEA8019-B28F-485A-8098-41C988D0820E"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 4/5] vhost-user-scsi: support reconnect to backend
Date: Tue, 12 Sep 2023 16:29:20 +0800
In-Reply-To: <878r9q85nd.fsf@pond.sub.org>
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
 <20230731121018.2856310-5-fengli@smartx.com> <878r9q85nd.fsf@pond.sub.org>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62f.google.com
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


--Apple-Mail=_5CEA8019-B28F-485A-8098-41C988D0820E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 1 Sep 2023, at 8:00 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Li Feng <fengli@smartx.com <mailto:fengli@smartx.com>> writes:
>=20
>> If the backend crashes and restarts, the device is broken.
>> This patch adds reconnect for vhost-user-scsi.
>>=20
>> Tested with spdk backend.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/scsi/vhost-user-scsi.c           | 199 =
+++++++++++++++++++++++++---
>> include/hw/virtio/vhost-user-scsi.h |   4 +
>> 2 files changed, 184 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index ee99b19e7a..5bf012461b 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -43,26 +43,54 @@ enum VhostUserProtocolFeature {
>>     VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
>> };
>>=20
>> +static int vhost_user_scsi_start(VHostUserSCSI *s)
>> +{
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +    int ret;
>> +
>> +    ret =3D vhost_scsi_common_start(vsc);
>> +    s->started_vu =3D (ret < 0 ? false : true);
>> +
>> +    return ret;
>> +}
>> +
>> +static void vhost_user_scsi_stop(VHostUserSCSI *s)
>> +{
>> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> +
>> +    if (!s->started_vu) {
>> +        return;
>> +    }
>> +    s->started_vu =3D false;
>> +
>> +    vhost_scsi_common_stop(vsc);
>> +}
>> +
>> static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
>> {
>>     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>> +    DeviceState *dev =3D =
&s->parent_obj.parent_obj.parent_obj.parent_obj;
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && =
vdev->vm_running;
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>> +    bool should_start =3D virtio_device_should_start(vdev, status);
>> +    int ret;
>>=20
>> -    if (vhost_dev_is_started(&vsc->dev) =3D=3D start) {
>> +    if (!s->connected) {
>>         return;
>>     }
>>=20
>> -    if (start) {
>> -        int ret;
>> +    if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
>> +        return;
>> +    }
>>=20
>> -        ret =3D vhost_scsi_common_start(vsc);
>> +    if (should_start) {
>> +        ret =3D vhost_user_scsi_start(s);
>>         if (ret < 0) {
>>             error_report("unable to start vhost-user-scsi: %s", =
strerror(-ret));
>> -            exit(1);
>> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
>>         }
>>     } else {
>> -        vhost_scsi_common_stop(vsc);
>> +        vhost_user_scsi_stop(s);
>>     }
>> }
>>=20
>> @@ -89,14 +117,126 @@ static void =
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
>> +    if (virtio_device_started(vdev, vdev->status)) {
>> +        ret =3D vhost_user_scsi_start(s);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>=20
> Fails without setting an error, violating the function's (tacit)
> postcondition.  Callers:
>=20
> * vhost_user_scsi_event()
>=20
>  Dereferences the null error and crashes.
>=20
> * vhost_user_scsi_realize_connect()
>=20
>  Also fails without setting an error.  Caller:
>=20
>  - vhost_user_scsi_realize()
>=20
>    1. Doesn't emit the "Reconnecting after error: " message.  See
>       also below.
>=20
>    2. Succeeds instead of failing!
Ack.

>=20
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
>> +    vhost_user_scsi_stop(s);
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
>>     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    struct vhost_virtqueue *vqs =3D NULL;
>>     Error *err =3D NULL;
>>     int ret;
>> +    int retries =3D VU_REALIZE_CONN_RETRIES;
>>=20
>>     if (!vs->conf.chardev.chr) {
>>         error_setg(errp, "vhost-user-scsi: missing chardev");
>> @@ -115,18 +255,28 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>         goto free_virtio;
>>     }
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
>=20
> Dereferencing *errp is wrong.  Quoting qapi/error.h's big comment:
>=20
> * =3D Why, when and how to use ERRP_GUARD() =3D
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> * - It should not be passed to error_prepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
>=20
> See there for how to use ERRP_GUARD().

Thanks, good catch. I have understood this knowledge.
>=20
>> +    do {
>> +        if (*errp) {
>> +            error_prepend(errp, "Reconnecting after error: ");
>> +            error_report_err(*errp);
>> +            *errp =3D NULL;
>> +        }
>> +        ret =3D vhost_user_scsi_realize_connect(s, errp);
>> +    } while (ret < 0 && retries--);
>=20
> Reports "Reconnecting ..." to the HMP monitor when in HMP context, =
else
> to stderr.  I.e. reports to stderr when we're in QMP context.  Is this
> really what we want?
The vhost-user-blk has the same code, so just keep it the same here is a
good idea?

>=20
>>=20
>> -    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user,
>> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
>>     if (ret < 0) {
>>         goto free_vhost;
>>     }
>>=20
>> +    /* we're fully initialized, now we can operate, so add the =
handler */
>> +    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
>> +                             vhost_user_scsi_event, NULL, (void =
*)dev,
>> +                             NULL, true);
>>     /* Channel and lun both are 0 for bootable vhost-user-scsi disk =
*/
>>     vsc->channel =3D 0;
>>     vsc->lun =3D 0;
>> @@ -135,8 +285,12 @@ static void vhost_user_scsi_realize(DeviceState =
*dev, Error **errp)
>>     return;
>>=20
>> free_vhost:
>> +    g_free(s->vhost_vqs);
>> +    s->vhost_vqs =3D NULL;
>> +    g_free(vsc->inflight);
>> +    vsc->inflight =3D NULL;
>>     vhost_user_cleanup(&s->vhost_user);
>> -    g_free(vqs);
>> +
>> free_virtio:
>>     virtio_scsi_common_unrealize(dev);
>> }
>> @@ -146,16 +300,23 @@ static void =
vhost_user_scsi_unrealize(DeviceState *dev)
>>     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>>     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>> -    struct vhost_virtqueue *vqs =3D vsc->dev.vqs;
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>=20
>>     /* This will stop the vhost backend. */
>>     vhost_user_scsi_set_status(vdev, 0);
>> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, =
NULL, NULL,
>> +                             NULL, false);
>>=20
>>     vhost_dev_cleanup(&vsc->dev);
>> -    g_free(vqs);
>> +    g_free(s->vhost_vqs);
>> +    s->vhost_vqs =3D NULL;
>> +
>> +    vhost_dev_free_inflight(vsc->inflight);
>> +    g_free(vsc->inflight);
>> +    vsc->inflight =3D NULL;
>>=20
>> -    virtio_scsi_common_unrealize(dev);
>>     vhost_user_cleanup(&s->vhost_user);
>> +    virtio_scsi_common_unrealize(dev);
>> }
>>=20
>> static Property vhost_user_scsi_properties[] =3D {
>> diff --git a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h
>> index 521b08e559..b405ec952a 100644
>> --- a/include/hw/virtio/vhost-user-scsi.h
>> +++ b/include/hw/virtio/vhost-user-scsi.h
>> @@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, =
VHOST_USER_SCSI)
>> struct VHostUserSCSI {
>>     VHostSCSICommon parent_obj;
>>     VhostUserState vhost_user;
>> +    bool connected;
>> +    bool started_vu;
>> +
>> +    struct vhost_virtqueue *vhost_vqs;
>> };
>>=20
>> #endif /* VHOST_USER_SCSI_H */


--Apple-Mail=_5CEA8019-B28F-485A-8098-41C988D0820E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
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
text-decoration: none;">If the backend crashes and restarts, the device =
is broken.<br>This patch adds reconnect for =
vhost-user-scsi.<br><br>Tested with spdk backend.<br><br>Signed-off-by: =
Li Feng &lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-user-scsi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 199 =
+++++++++++++++++++++++++---<br>include/hw/virtio/vhost-user-scsi.h | =
&nbsp;&nbsp;4 +<br>2 files changed, 184 insertions(+), 19 =
deletions(-)<br><br>diff --git a/hw/scsi/vhost-user-scsi.c =
b/hw/scsi/vhost-user-scsi.c<br>index ee99b19e7a..5bf012461b =
100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -43,26 +43,54 @@ enum =
VhostUserProtocolFeature =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D =
13,<br>};<br><br>+static int vhost_user_scsi_start(VHostUserSCSI =
*s)<br>+{<br>+ &nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>+ &nbsp;&nbsp;&nbsp;int ret;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_scsi_common_start(vsc);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;started_vu =3D (ret &lt; 0 ? false : =
true);<br>+<br>+ &nbsp;&nbsp;&nbsp;return ret;<br>+}<br>+<br>+static =
void vhost_user_scsi_stop(VHostUserSCSI *s)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (!s-&gt;started_vu) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;s-&gt;started_vu =3D =
false;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;vhost_scsi_common_stop(vsc);<br>+}<br>+<br>static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
(VHostUserSCSI *)vdev;<br>+ &nbsp;&nbsp;&nbsp;DeviceState *dev =3D =
&amp;s-&gt;parent_obj.parent_obj.parent_obj.parent_obj;<br>&nbsp;&nbsp;&nb=
sp;&nbsp;VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);<br>- =
&nbsp;&nbsp;&nbsp;bool start =3D (status &amp; =
VIRTIO_CONFIG_S_DRIVER_OK) &amp;&amp; vdev-&gt;vm_running;<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);<br>+ =
&nbsp;&nbsp;&nbsp;bool should_start =3D virtio_device_should_start(vdev, =
status);<br>+ &nbsp;&nbsp;&nbsp;int ret;<br><br>- &nbsp;&nbsp;&nbsp;if =
(vhost_dev_is_started(&amp;vsc-&gt;dev) =3D=3D start) {<br>+ =
&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>&nbsp;&nbs=
p;&nbsp;&nbsp;}<br><br>- &nbsp;&nbsp;&nbsp;if (start) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int ret;<br>+ =
&nbsp;&nbsp;&nbsp;if (vhost_dev_is_started(&amp;vsc-&gt;dev) =3D=3D =
should_start) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br><br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_common_start(vsc);<br>+ &nbsp;&nbsp;&nbsp;if (should_start) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;if (ret &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;error_report("unable to start vhost-user-scsi: %s", =
strerror(-ret));<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);=
<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_chr=
_fe_disconnect(&amp;vs-&gt;conf.chardev);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_scsi_common_stop(vsc);<br>=
+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_stop(s);<br>&nbs=
p;&nbsp;&nbsp;&nbsp;}<br>}<br><br>@@ -89,14 +117,126 @@ static void =
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
*/<br>+ &nbsp;&nbsp;&nbsp;if (virtio_device_started(vdev, =
vdev-&gt;status)) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D=
 vhost_user_scsi_start(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br></blockquote><br =
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
display: inline !important;">Fails without setting an error, violating =
the function's (tacit)</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
!important;">postcondition. &nbsp;Callers:</span><br style=3D"caret-color:=
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
text-decoration: none; float: none; display: inline !important;">* =
vhost_user_scsi_event()</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
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
!important;">&nbsp;Dereferences the null error and crashes.</span><br =
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
display: inline !important;">* =
vhost_user_scsi_realize_connect()</span><br style=3D"caret-color: rgb(0, =
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
text-decoration: none; float: none; display: inline =
!important;">&nbsp;Also fails without setting an error. =
&nbsp;Caller:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
none; float: none; display: inline !important;">&nbsp;- =
vhost_user_scsi_realize()</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
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
!important;">&nbsp;&nbsp;&nbsp;1. Doesn't emit the "Reconnecting after =
error: " message. &nbsp;See</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;also below.</span><br =
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
display: inline !important;">&nbsp;&nbsp;&nbsp;2. Succeeds instead of =
failing!</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>Ack.</div><div><br><blockquote =
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
text-decoration: none;">+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;return 0;<br>+}<br>+<br>+static void =
vhost_user_scsi_event(void *opaque, QEMUChrEvent event);<br>+<br>+static =
void vhost_user_scsi_disconnect(DeviceState *dev)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>+ =
&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);<br>+ =
&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);<br>+ =
&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!s-&gt;connected) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;s-&gt;connected =3D =
false;<br>+<br>+ &nbsp;&nbsp;&nbsp;vhost_user_scsi_stop(s);<br>+<br>+ =
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
**errp)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(dev);<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>- &nbsp;&nbsp;&nbsp;struct vhost_virtqueue *vqs =
=3D NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;Error *err =3D =
NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;int ret;<br>+ &nbsp;&nbsp;&nbsp;int =
retries =3D VU_REALIZE_CONN_RETRIES;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(!vs-&gt;conf.chardev.chr) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, =
"vhost-user-scsi: missing chardev");<br>@@ -115,18 +255,28 @@ static =
void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
free_virtio;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>- =
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
&nbsp;&nbsp;&nbsp;assert(!*errp);<br></blockquote><br =
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
display: inline !important;">Dereferencing *errp is wrong. &nbsp;Quoting =
qapi/error.h's big comment:</span><br style=3D"caret-color: rgb(0, 0, =
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
text-decoration: none; float: none; display: inline !important;">* =3D =
Why, when and how to use ERRP_GUARD() =3D</span><br style=3D"caret-color: =
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
!important;">*</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">* =
Without ERRP_GUARD(), use of the @errp parameter is =
restricted:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">* - It must not be =
dereferenced, because it may be null.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">* - It =
should not be passed to error_prepend() or</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">* =
&nbsp;&nbsp;error_append_hint(), because that doesn't work with =
&amp;error_fatal.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">* =
ERRP_GUARD() lifts these restrictions.</span><br style=3D"caret-color: =
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
text-decoration: none; float: none; display: inline !important;">See =
there for how to use ERRP_GUARD().</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote><div><br></div>Thanks, good =
catch. I have understood this knowledge.<br><blockquote =
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
text-decoration: none;">+ &nbsp;&nbsp;&nbsp;do {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (*errp) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_pr=
epend(errp, "Reconnecting after error: ");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port_err(*errp);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*errp =
=3D NULL;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_realize_connect(s, errp);<br>+ &nbsp;&nbsp;&nbsp;} while =
(ret &lt; 0 &amp;&amp; retries--);<br></blockquote><br =
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
display: inline !important;">Reports "Reconnecting ..." to the HMP =
monitor when in HMP context, else</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">to =
stderr. &nbsp;I.e. reports to stderr when we're in QMP context. &nbsp;Is =
this</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">really what we =
want?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>The vhost-user-blk has the same code, so just =
keep it the same here is a</div><div>good =
idea?</div><div><br><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Monaco; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><br>- =
&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_init(&amp;vsc-&gt;dev, =
&amp;s-&gt;vhost_user,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VHOS=
T_BACKEND_TYPE_USER, 0, errp);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; =
0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
free_vhost;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>+ &nbsp;&nbsp;&nbsp;/* =
we're fully initialized, now we can operate, so add the handler */<br>+ =
&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vs-&gt;conf.chardev, =
&nbsp;NULL, NULL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;vhost_user_scsi_event, NULL, (void *)dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;NULL, true);<br>&nbsp;&nbsp;&nbsp;&nbsp;/* Channel =
and lun both are 0 for bootable vhost-user-scsi disk =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;channel =3D =
0;<br>&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;lun =3D 0;<br>@@ -135,8 +285,12 @@ =
static void vhost_user_scsi_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;return;<br><br>free_vhost:<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;vhost_vqs);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D NULL;<br>+ =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_cleanup(&amp;s-&gt;vhost_user)=
;<br>- =
&nbsp;&nbsp;&nbsp;g_free(vqs);<br>+<br>free_virtio:<br>&nbsp;&nbsp;&nbsp;&=
nbsp;virtio_scsi_common_unrealize(dev);<br>}<br>@@ -146,16 +300,23 @@ =
static void vhost_user_scsi_unrealize(DeviceState =
*dev)<br>&nbsp;&nbsp;&nbsp;&nbsp;VirtIODevice *vdev =3D =
VIRTIO_DEVICE(dev);<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostUserSCSI *s =3D =
VHOST_USER_SCSI(dev);<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostSCSICommon *vsc =3D =
VHOST_SCSI_COMMON(s);<br>- &nbsp;&nbsp;&nbsp;struct vhost_virtqueue *vqs =
=3D vsc-&gt;dev.vqs;<br>+ &nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;/* This will =
stop the vhost backend. =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_set_status(vdev, 0);<br>+ =
&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vs-&gt;conf.chardev, =
NULL, NULL, NULL, NULL, NULL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;NULL, =
false);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;vhost_dev_cleanup(&amp;vsc-&gt;dev)=
;<br>- &nbsp;&nbsp;&nbsp;g_free(vqs);<br>+ =
&nbsp;&nbsp;&nbsp;g_free(s-&gt;vhost_vqs);<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;vhost_vqs =3D NULL;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;vhost_dev_free_inflight(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D NULL;<br><br>- =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_unrealize(dev);<br>&nbsp;&nbsp;&nbsp;=
&nbsp;vhost_user_cleanup(&amp;s-&gt;vhost_user);<br>+ =
&nbsp;&nbsp;&nbsp;virtio_scsi_common_unrealize(dev);<br>}<br><br>static =
Property vhost_user_scsi_properties[] =3D {<br>diff --git =
a/include/hw/virtio/vhost-user-scsi.h =
b/include/hw/virtio/vhost-user-scsi.h<br>index 521b08e559..b405ec952a =
100644<br>--- a/include/hw/virtio/vhost-user-scsi.h<br>+++ =
b/include/hw/virtio/vhost-user-scsi.h<br>@@ -29,6 +29,10 @@ =
OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)<br>struct =
VHostUserSCSI {<br>&nbsp;&nbsp;&nbsp;&nbsp;VHostSCSICommon =
parent_obj;<br>&nbsp;&nbsp;&nbsp;&nbsp;VhostUserState vhost_user;<br>+ =
&nbsp;&nbsp;&nbsp;bool connected;<br>+ &nbsp;&nbsp;&nbsp;bool =
started_vu;<br>+<br>+ &nbsp;&nbsp;&nbsp;struct vhost_virtqueue =
*vhost_vqs;<br>};<br><br>#endif /* VHOST_USER_SCSI_H =
*/</blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_5CEA8019-B28F-485A-8098-41C988D0820E--


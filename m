Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9F78FCDB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2pb-0006Bv-Lj; Fri, 01 Sep 2023 08:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc2pV-000652-Fj
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc2pR-0001dN-Mk
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693569645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYGvcbxqOqjbBIzjeBqFf3Nh2WxsPiZSET2SVUC8z7U=;
 b=E+QnHD+oAqo5++ya8pS2ElWgaiidhXkwhdmVgNVJaYY/IalGFD+LVAcx86MdjHeZ8G8O0G
 JlB2HdLxeMWATPEhBdqlUsiJgr5Gnicco0cKYTJfpCl6+RgRIo7o+2wSczG1WqhturhuuA
 NlAgqHanA1Bjj4PuojZ7RHuaweeHtRM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-ikBIkA81PGW2P643EBV5gg-1; Fri, 01 Sep 2023 08:00:40 -0400
X-MC-Unique: ikBIkA81PGW2P643EBV5gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EC791C18C6A;
 Fri,  1 Sep 2023 12:00:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C26582026D0E;
 Fri,  1 Sep 2023 12:00:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B987A21E692A; Fri,  1 Sep 2023 14:00:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Raphael Norwitz
 <raphael.norwitz@nutanix.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Viresh
 Kumar <viresh.kumar@linaro.org>,  qemu-block@nongnu.org (open list:Block
 layer core),  qemu-devel@nongnu.org (open list:All patches CC here)
Subject: Re: [PATCH v3 4/5] vhost-user-scsi: support reconnect to backend
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
 <20230731121018.2856310-5-fengli@smartx.com>
Date: Fri, 01 Sep 2023 14:00:38 +0200
In-Reply-To: <20230731121018.2856310-5-fengli@smartx.com> (Li Feng's message
 of "Mon, 31 Jul 2023 20:10:09 +0800")
Message-ID: <878r9q85nd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Li Feng <fengli@smartx.com> writes:

> If the backend crashes and restarts, the device is broken.
> This patch adds reconnect for vhost-user-scsi.
>
> Tested with spdk backend.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/scsi/vhost-user-scsi.c           | 199 +++++++++++++++++++++++++---
>  include/hw/virtio/vhost-user-scsi.h |   4 +
>  2 files changed, 184 insertions(+), 19 deletions(-)
>
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index ee99b19e7a..5bf012461b 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -43,26 +43,54 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
>  };
>  
> +static int vhost_user_scsi_start(VHostUserSCSI *s)
> +{
> +    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +    int ret;
> +
> +    ret = vhost_scsi_common_start(vsc);
> +    s->started_vu = (ret < 0 ? false : true);
> +
> +    return ret;
> +}
> +
> +static void vhost_user_scsi_stop(VHostUserSCSI *s)
> +{
> +    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +
> +    if (!s->started_vu) {
> +        return;
> +    }
> +    s->started_vu = false;
> +
> +    vhost_scsi_common_stop(vsc);
> +}
> +
>  static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>  {
>      VHostUserSCSI *s = (VHostUserSCSI *)vdev;
> +    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> -    bool start = (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_running;
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> +    bool should_start = virtio_device_should_start(vdev, status);
> +    int ret;
>  
> -    if (vhost_dev_is_started(&vsc->dev) == start) {
> +    if (!s->connected) {
>          return;
>      }
>  
> -    if (start) {
> -        int ret;
> +    if (vhost_dev_is_started(&vsc->dev) == should_start) {
> +        return;
> +    }
>  
> -        ret = vhost_scsi_common_start(vsc);
> +    if (should_start) {
> +        ret = vhost_user_scsi_start(s);
>          if (ret < 0) {
>              error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
> -            exit(1);
> +            qemu_chr_fe_disconnect(&vs->conf.chardev);
>          }
>      } else {
> -        vhost_scsi_common_stop(vsc);
> +        vhost_user_scsi_stop(s);
>      }
>  }
>  
> @@ -89,14 +117,126 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>  }
>  
> +static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> +    int ret = 0;
> +
> +    if (s->connected) {
> +        return 0;
> +    }
> +    s->connected = true;
> +
> +    vsc->dev.num_queues = vs->conf.num_queues;
> +    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> +    vsc->dev.vqs = s->vhost_vqs;
> +    vsc->dev.vq_index = 0;
> +    vsc->dev.backend_features = 0;
> +
> +    ret = vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
> +                         errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* restore vhost state */
> +    if (virtio_device_started(vdev, vdev->status)) {
> +        ret = vhost_user_scsi_start(s);
> +        if (ret < 0) {
> +            return ret;
> +        }

Fails without setting an error, violating the function's (tacit)
postcondition.  Callers:

* vhost_user_scsi_event()

  Dereferences the null error and crashes.

* vhost_user_scsi_realize_connect()

  Also fails without setting an error.  Caller:

  - vhost_user_scsi_realize()

    1. Doesn't emit the "Reconnecting after error: " message.  See
       also below.

    2. Succeeds instead of failing!

> +    }
> +
> +    return 0;
> +}
> +
> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_scsi_disconnect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +    s->connected = false;
> +
> +    vhost_user_scsi_stop(s);
> +
> +    vhost_dev_cleanup(&vsc->dev);
> +
> +    /* Re-instate the event handler for new connections */
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
> +                             vhost_user_scsi_event, NULL, dev, NULL, true);
> +}
> +
> +static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
> +{
> +    DeviceState *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
> +    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> +    Error *local_err = NULL;
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
> +static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error **errp)
> +{
> +    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> +    int ret;
> +
> +    s->connected = false;
> +
> +    ret = qemu_chr_fe_wait_connected(&vs->conf.chardev, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vhost_user_scsi_connect(dev, errp);
> +    if (ret < 0) {
> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> +        return ret;
> +    }
> +    assert(s->connected);
> +
> +    return 0;
> +}
> +
>  static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
>      VHostUserSCSI *s = VHOST_USER_SCSI(dev);
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> -    struct vhost_virtqueue *vqs = NULL;
>      Error *err = NULL;
>      int ret;
> +    int retries = VU_REALIZE_CONN_RETRIES;
>  
>      if (!vs->conf.chardev.chr) {
>          error_setg(errp, "vhost-user-scsi: missing chardev");
> @@ -115,18 +255,28 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>          goto free_virtio;
>      }
>  
> -    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> -    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
> -    vsc->dev.vq_index = 0;
> -    vsc->dev.backend_features = 0;
> -    vqs = vsc->dev.vqs;
> +    vsc->inflight = g_new0(struct vhost_inflight, 1);
> +    s->vhost_vqs = g_new0(struct vhost_virtqueue,
> +                          VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues);
> +
> +    assert(!*errp);

Dereferencing *errp is wrong.  Quoting qapi/error.h's big comment:

 * = Why, when and how to use ERRP_GUARD() =
 *
 * Without ERRP_GUARD(), use of the @errp parameter is restricted:
 * - It must not be dereferenced, because it may be null.
 * - It should not be passed to error_prepend() or
 *   error_append_hint(), because that doesn't work with &error_fatal.
 * ERRP_GUARD() lifts these restrictions.

See there for how to use ERRP_GUARD().

> +    do {
> +        if (*errp) {
> +            error_prepend(errp, "Reconnecting after error: ");
> +            error_report_err(*errp);
> +            *errp = NULL;
> +        }
> +        ret = vhost_user_scsi_realize_connect(s, errp);
> +    } while (ret < 0 && retries--);

Reports "Reconnecting ..." to the HMP monitor when in HMP context, else
to stderr.  I.e. reports to stderr when we're in QMP context.  Is this
really what we want?

>  
> -    ret = vhost_dev_init(&vsc->dev, &s->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
>      if (ret < 0) {
>          goto free_vhost;
>      }
>  
> +    /* we're fully initialized, now we can operate, so add the handler */
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev,  NULL, NULL,
> +                             vhost_user_scsi_event, NULL, (void *)dev,
> +                             NULL, true);
>      /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
>      vsc->channel = 0;
>      vsc->lun = 0;
> @@ -135,8 +285,12 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>      return;
>  
>  free_vhost:
> +    g_free(s->vhost_vqs);
> +    s->vhost_vqs = NULL;
> +    g_free(vsc->inflight);
> +    vsc->inflight = NULL;
>      vhost_user_cleanup(&s->vhost_user);
> -    g_free(vqs);
> +
>  free_virtio:
>      virtio_scsi_common_unrealize(dev);
>  }
> @@ -146,16 +300,23 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserSCSI *s = VHOST_USER_SCSI(dev);
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> -    struct vhost_virtqueue *vqs = vsc->dev.vqs;
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
>  
>      /* This will stop the vhost backend. */
>      vhost_user_scsi_set_status(vdev, 0);
> +    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL, NULL, NULL, NULL,
> +                             NULL, false);
>  
>      vhost_dev_cleanup(&vsc->dev);
> -    g_free(vqs);
> +    g_free(s->vhost_vqs);
> +    s->vhost_vqs = NULL;
> +
> +    vhost_dev_free_inflight(vsc->inflight);
> +    g_free(vsc->inflight);
> +    vsc->inflight = NULL;
>  
> -    virtio_scsi_common_unrealize(dev);
>      vhost_user_cleanup(&s->vhost_user);
> +    virtio_scsi_common_unrealize(dev);
>  }
>  
>  static Property vhost_user_scsi_properties[] = {
> diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
> index 521b08e559..b405ec952a 100644
> --- a/include/hw/virtio/vhost-user-scsi.h
> +++ b/include/hw/virtio/vhost-user-scsi.h
> @@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)
>  struct VHostUserSCSI {
>      VHostSCSICommon parent_obj;
>      VhostUserState vhost_user;
> +    bool connected;
> +    bool started_vu;
> +
> +    struct vhost_virtqueue *vhost_vqs;
>  };
>  
>  #endif /* VHOST_USER_SCSI_H */



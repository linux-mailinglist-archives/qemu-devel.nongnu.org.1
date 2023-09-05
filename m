Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A2779236F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:22:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdWv4-0001Rd-AP; Tue, 05 Sep 2023 10:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qdWv2-0001R6-Gb
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qdWur-0007dN-Gn
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693923627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/TEqKun8ZTfmcuAYj6AtPR6+tr3PQu8Ezq0n9A3YPw=;
 b=NjxTZe0CbCZY7Dd7iROAL5WJN2zdQwk51EXn9Yj/lh7X+ZTy4BxP3E2JkEt3WEColHwmO7
 Al/K9pVUZtav7gohZpaRPCSSdbWeYfDk7juTlz/oOz9T8gNzdjtLZJ7fxXpSIK1tcKGjpT
 O/IwpBqhg/EYMCEG3fnpOEz5jj4QuIU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-WOldPrbvMIS1B2HDUKakPg-1; Tue, 05 Sep 2023 10:19:22 -0400
X-MC-Unique: WOldPrbvMIS1B2HDUKakPg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3a9e0160cdbso2861538b6e.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 07:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693923561; x=1694528361;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/TEqKun8ZTfmcuAYj6AtPR6+tr3PQu8Ezq0n9A3YPw=;
 b=lCHIf9+AaH07q17A54xduboWBS0va1sZPxhDK55ua26vlVfTI7A0SGCt9YVmzL/E7p
 G1pgDvqEQj2WZAcu8ZwMQztuH3jCEJVc1qGiGlDMcg327WIKJlOnRCw941ISZks4dARC
 nMo+DsgYmRn5PIFQ0q2zGvpcdTC0+YuJGvChXuZT4EDko/5YmeCTVny53QRrS0PznXmh
 jFPfuzdLy/pTHNqHJh3RGDu6dUAOpQqrOvuasLSl4FJACpkdPQz5I+ls5YVcFSaoRHem
 G3N5Rml46bY8I8kMRlwJ1iC+gN9SeQ/Pt7zFrFm7O5veyegyYzeZ0/dlFyEok9oyXexF
 yqyw==
X-Gm-Message-State: AOJu0Yx51IP5Uy6yd7Tlh/6JTfzlhJ/4wYqtt9wk6vUGzEpA6G41ONMY
 vv285CkRTZYHlGnATGm4AtJgfMbZdohBT4g9TyKuhLAw14LEmJbvWqqIniXt6IpCZznh2EnZl7o
 FYIIyttVZ8sCYe5M=
X-Received: by 2002:a05:6808:220c:b0:3a8:5502:35aa with SMTP id
 bd12-20020a056808220c00b003a8550235aamr16205510oib.14.1693923561060; 
 Tue, 05 Sep 2023 07:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEys/0X3NKwNoiVWr1CDZeEdKx2bsJuMHhj/AtMY83qaQOkNOZXAAtyopyJszrIakl0yWJDbQ==
X-Received: by 2002:a05:6808:220c:b0:3a8:5502:35aa with SMTP id
 bd12-20020a056808220c00b003a8550235aamr16205482oib.14.1693923560800; 
 Tue, 05 Sep 2023 07:19:20 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 t26-20020ac8531a000000b0040324785e4csm4342687qtn.13.2023.09.05.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 07:19:20 -0700 (PDT)
Date: Tue, 5 Sep 2023 16:19:15 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 07/20] virtio: add vhost-user-base and a generic
 vhost-user-device
Message-ID: <ZPc44//qJCPNAOXE@fedora>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710153522.3469097-8-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 10, 2023 at 04:35:09PM +0100, Alex Bennée wrote:
> In theory we shouldn't need to repeat so much boilerplate to support
> vhost-user backends. This provides a generic vhost-user-base QOM
> object and a derived vhost-user-device for which the user needs to
> provide the few bits of information that aren't currently provided by
> the vhost-user protocol. This should provide a baseline implementation
> from which the other vhost-user stub can specialise.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - split into vub and vud
> ---
>  include/hw/virtio/vhost-user-device.h |  45 ++++
>  hw/virtio/vhost-user-device.c         | 324 ++++++++++++++++++++++++++
>  hw/virtio/meson.build                 |   2 +
>  3 files changed, 371 insertions(+)
>  create mode 100644 include/hw/virtio/vhost-user-device.h
>  create mode 100644 hw/virtio/vhost-user-device.c
> 
> diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio/vhost-user-device.h
> new file mode 100644
> index 0000000000..9105011e25
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-device.h
> @@ -0,0 +1,45 @@
> +/*
> + * Vhost-user generic virtio device
> + *
> + * Copyright (c) 2023 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_VHOST_USER_DEVICE_H
> +#define QEMU_VHOST_USER_DEVICE_H
> +
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
> +
> +#define TYPE_VHOST_USER_BASE "vhost-user-base"
> +
> +OBJECT_DECLARE_TYPE(VHostUserBase, VHostUserBaseClass, VHOST_USER_BASE)
> +
> +struct VHostUserBase {
> +    VirtIODevice parent;
> +    /* Properties */
> +    CharBackend chardev;
> +    uint16_t virtio_id;
> +    uint32_t num_vqs;
> +    /* State tracking */
> +    VhostUserState vhost_user;
> +    struct vhost_virtqueue *vhost_vq;
> +    struct vhost_dev vhost_dev;
> +    GPtrArray *vqs;
> +    bool connected;
> +};
> +
> +    /* needed so we can use the base realize after specialisation
> +       tweaks */
> +struct VHostUserBaseClass {
> +    /*< private >*/
> +    VirtioDeviceClass parent_class;
> +    /*< public >*/
> +    DeviceRealize parent_realize;
> +};
> +
> +/* shared for the benefit of the derived pci class */
> +#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
> +
> +#endif /* QEMU_VHOST_USER_DEVICE_H */
> diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
> new file mode 100644
> index 0000000000..b0239fa033
> --- /dev/null
> +++ b/hw/virtio/vhost-user-device.c
> @@ -0,0 +1,324 @@
> +/*
> + * Generic vhost-user stub. This can be used to connect to any
> + * vhost-user backend. All configuration details must be handled by
> + * the vhost-user daemon itself
> + *
> + * Copyright (c) 2023 Linaro Ltd
> + * Author: Alex Bennée <alex.bennee@linaro.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/vhost-user-device.h"
> +#include "qemu/error-report.h"
> +
> +static void vub_start(VirtIODevice *vdev)
> +{
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    int ret, i;
> +
> +    if (!k->set_guest_notifiers) {
> +        error_report("binding does not support guest notifiers");
> +        return;
> +    }
> +
> +    ret = vhost_dev_enable_notifiers(&vub->vhost_dev, vdev);
> +    if (ret < 0) {
> +        error_report("Error enabling host notifiers: %d", -ret);
> +        return;
> +    }
> +
> +    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, true);
> +    if (ret < 0) {
> +        error_report("Error binding guest notifier: %d", -ret);
> +        goto err_host_notifiers;
> +    }
> +
> +    vub->vhost_dev.acked_features = vdev->guest_features;
> +
> +    ret = vhost_dev_start(&vub->vhost_dev, vdev, true);
> +    if (ret < 0) {
> +        error_report("Error starting vhost-user-device: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +
> +    /*
> +     * guest_notifier_mask/pending not used yet, so just unmask
> +     * everything here. virtio-pci will do the right thing by
> +     * enabling/disabling irqfd.
> +     */
> +    for (i = 0; i < vub->vhost_dev.nvqs; i++) {
> +        vhost_virtqueue_mask(&vub->vhost_dev, vdev, i, false);
> +    }
> +
> +    return;
> +
> +err_guest_notifiers:
> +    k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
> +err_host_notifiers:
> +    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
> +}
> +
> +static void vub_stop(VirtIODevice *vdev)
> +{
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int ret;
> +
> +    if (!k->set_guest_notifiers) {
> +        return;
> +    }
> +
> +    vhost_dev_stop(&vub->vhost_dev, vdev, true);
> +
> +    ret = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
> +    if (ret < 0) {
> +        error_report("vhost guest notifier cleanup failed: %d", ret);
> +        return;
> +    }
> +
> +    vhost_dev_disable_notifiers(&vub->vhost_dev, vdev);
> +}
> +
> +static void vub_set_status(VirtIODevice *vdev, uint8_t status)
> +{
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    bool should_start = virtio_device_should_start(vdev, status);
> +
> +    if (vhost_dev_is_started(&vub->vhost_dev) == should_start) {
> +        return;
> +    }
> +
> +    if (should_start) {
> +        vub_start(vdev);
> +    } else {
> +        vub_stop(vdev);
> +    }
> +}
> +
> +/*
> + * For an implementation where everything is delegated to the backend
> + * we don't do anything other than return the full feature set offered
> + * by the daemon (module the reserved feature bit).
> + */
> +static uint64_t vub_get_features(VirtIODevice *vdev,
> +                                 uint64_t requested_features, Error **errp)
> +{
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    /* This should be set when the vhost connection initialises */
> +    g_assert(vub->vhost_dev.features);
> +    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
> +}
> +
> +static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    /*
> +     * Not normally called; it's the daemon that handles the queue;
> +     * however virtio's cleanup path can call this.
> +     */
> +}
> +
> +static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
> +{
> +    vhost_user_cleanup(&vub->vhost_user);
> +
> +    for (int i = 0; i < vub->num_vqs; i++) {
> +        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
> +        virtio_delete_queue(vq);
> +    }
> +
> +    virtio_cleanup(vdev);
> +}
> +
> +static int vub_connect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +
> +    if (vub->connected) {
> +        return 0;
> +    }
> +    vub->connected = true;
> +
> +    /* restore vhost state */
> +    if (virtio_device_started(vdev, vdev->status)) {
> +        vub_start(vdev);
> +    }
> +
> +    return 0;
> +}
> +
> +static void vub_disconnect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +
> +    if (!vub->connected) {
> +        return;
> +    }
> +    vub->connected = false;
> +
> +    if (vhost_dev_is_started(&vub->vhost_dev)) {
> +        vub_stop(vdev);
> +    }
> +}
> +
> +static void vub_event(void *opaque, QEMUChrEvent event)
> +{
> +    DeviceState *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (vub_connect(dev) < 0) {
> +            qemu_chr_fe_disconnect(&vub->chardev);
> +            return;
> +        }
> +        break;
> +    case CHR_EVENT_CLOSED:
> +        vub_disconnect(dev);
> +        break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
> +    }
> +}
> +
> +static void vub_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBase *vub = VHOST_USER_BASE(dev);
> +    int ret;
> +
> +    if (!vub->chardev.chr) {
> +        error_setg(errp, "vhost-user-device: missing chardev");
> +        return;
> +    }
> +
> +    if (!vub->virtio_id) {
> +        error_setg(errp, "vhost-user-device: need to define device id");
> +        return;
> +    }
> +
> +    if (!vub->num_vqs) {
> +        vub->num_vqs = 1; /* reasonable default? */
> +    }
> +
> +    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
> +        return;
> +    }
> +
> +    virtio_init(vdev, vub->virtio_id, 0);
> +
> +    /*
> +     * Disable guest notifiers, by default all notifications will be via the
> +     * asynchronous vhost-user socket.
> +     */
> +    vdev->use_guest_notifier_mask = false;
> +
> +    /* Allocate queues */
> +    vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
> +    for (int i = 0; i < vub->num_vqs; i++) {
> +        g_ptr_array_add(vub->vqs,
> +                        virtio_add_queue(vdev, 4, vub_handle_output));
> +    }
> +

Hello Alex, apologies if someone already asked this. If I understand
correctly, the second parameter of virtio_add_queue() is the len of the
queue. Why have you chosen "4" as its value? Shall qemu query the len of
the queue from the vhost-user device instead?

Matias



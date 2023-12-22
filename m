Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F581CE9C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 20:00:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGkje-0003Ct-6B; Fri, 22 Dec 2023 13:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGkjc-0003CA-9e
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGkja-0005ii-DZ
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703271537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hs99becgImQZPqXUScg4NuzWe/HwUAu8ppCfknP/cNs=;
 b=ROd5IWY5kX3koliidJjfsWBnX1yLheRHtLx9qjfUeRfPB26FRyQY0Xg//V5TZg3dZA/FKd
 ia19iligstbAj6wrZ4r3Quq7oSFjbuTs37c1SziUYcKREFwp+k2QDaPR8neSyxdH9ElPHZ
 WTZilO5mG2o14ORuEhupc2+a+mVAuac=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-q7BtTPFQPmOXvco5505QSw-1; Fri, 22 Dec 2023 13:58:55 -0500
X-MC-Unique: q7BtTPFQPmOXvco5505QSw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5cf4696e202so42572137b3.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703271535; x=1703876335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hs99becgImQZPqXUScg4NuzWe/HwUAu8ppCfknP/cNs=;
 b=C+7IYEgVKdsSoEw9E6czn2ld8onNNnSTQ6ZJuk7HdnbQBDbeCcwP7veuYo7qxVl8Qo
 uydN/k7jJ41EQ93lztaegjJanM4IfJVe3P7tf9WtD4nRGfZRXXmMpWj+0aak+2cJ9Uos
 qrVJG0/x6juJQSxwaky8zjpU/aenuR/Eg0Kl/HLcnjN+pF9bMNPlYWK7LuMS2+odW4LB
 f7M9uXV1FAmNU8x29W+ZrbKNrdpKvRaU2NbzZsnNQC48EfxDeU8nIAIQcct7T8JxN8RD
 RioPftHHkJqzv5itgaJRQ32euYgGlsA8/b6SCHujsdKuGYO4a/63lxIfQLBhxCauPZrs
 /eqA==
X-Gm-Message-State: AOJu0YwdSefuZU/hAzBFs6g3PwlE2aeE7CG97tDd4pOMzg47LwLFTaKk
 nt2ubJr6jqngGOGcGh62qp/nmEaPujXa58CwCL21VYW7cTS54Uo4uAz5Ewk/4r17eo3uS85gRNY
 HuJulwgI9B5gYt1SmpimJ9BNlWN21zCFFIRDPtqM=
X-Received: by 2002:a81:924d:0:b0:5d7:9515:6ae3 with SMTP id
 j74-20020a81924d000000b005d795156ae3mr1780058ywg.33.1703271535450; 
 Fri, 22 Dec 2023 10:58:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHkV1+jkPbHYwrBWo3DpAZsJum0hAIyrklprrPt2TdbAIFC9d1NQO0JhQj0nJmBUbadEQ+cwAJLzJtnKT0Uvc=
X-Received: by 2002:a81:924d:0:b0:5d7:9515:6ae3 with SMTP id
 j74-20020a81924d000000b005d795156ae3mr1780045ywg.33.1703271535164; Fri, 22
 Dec 2023 10:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20230918044932.1433744-1-yajunw@nvidia.com>
 <20230918044932.1433744-6-yajunw@nvidia.com>
In-Reply-To: <20230918044932.1433744-6-yajunw@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Dec 2023 19:58:19 +0100
Message-ID: <CAJaqyWcGbNGWPf67Bwh6=omMbLOYR=9RrMOGh1AoiAo=VGpaag@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] virtio-net: Introduce LM early load
To: Yajun Wu <yajunw@nvidia.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com, 
 Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Sep 18, 2023 at 6:51=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
> Register a new vmstate for virtio-net with an early_setup flag to send
> the device state during migration setup.
>
> This can reduce the migration downtime of a virtio-net device with a
> vhost-user backend.
>
> This feature is disabled by default and can be enabled by setting the
> "x-early-migration" device property to on.
>
> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  hw/net/trace-events            |   1 +
>  hw/net/virtio-net.c            | 100 +++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-net.h |   1 +
>  3 files changed, 102 insertions(+)
>
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 6b5ba669a2..ec89229044 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -399,6 +399,7 @@ virtio_net_post_load_device(void)
>  virtio_net_rss_disable(void)
>  virtio_net_rss_error(const char *msg, uint32_t value) "%s, value 0x%08x"
>  virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x=
, table of %d, key of %d"
> +virtio_net_load_early_setup(void) ""
>
>  # tulip.c
>  tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val)=
 "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7102ec4817..d0b0cc2ffe 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -46,6 +46,7 @@
>  #include "net_rx_pkt.h"
>  #include "hw/virtio/vhost.h"
>  #include "sysemu/qtest.h"
> +#include "sysemu/runstate.h"
>
>  #define VIRTIO_NET_VM_VERSION    11
>
> @@ -3568,6 +3569,95 @@ static bool failover_hide_primary_device(DeviceLis=
tener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>
> +static int virtio_net_load_early_setup(void *opaque, int version_id)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    NetClientState *nc =3D qemu_get_queue(n->nic);
> +    int queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> +    int cvq =3D virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
> +        n->max_ncs - n->max_queue_pairs : 0;
> +    VHostNetState *net;
> +    int r;
> +
> +    assert(nc->peer);
> +    assert(nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER);
> +
> +    net =3D get_vhost_net(nc->peer);
> +    assert(net);
> +    assert(net->dev.vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_US=
ER);
> +
> +    trace_virtio_net_load_early_setup();
> +
> +    /* backend should support presetup */
> +    r =3D vhost_dev_set_presetup_state(&net->dev, true);
> +    if (r < 0) {
> +        error_report("Start presetup device fail: %d", r);
> +        return r;
> +    }
> +
> +    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MTU)) {
> +        r =3D vhost_net_set_mtu(get_vhost_net(nc->peer), n->net_conf.mtu=
);
> +        if (r < 0) {
> +            error_report("%uBytes MTU not supported by the backend",
> +                         n->net_conf.mtu);
> +            goto error;
> +        }
> +    }
> +
> +    r =3D vhost_net_presetup(vdev, n->nic->ncs, queue_pairs, cvq);
> +    if (r < 0) {
> +        error_report("Presetup device fail: %d", r);
> +        goto error;
> +    }
> +
> +    r =3D vhost_dev_set_presetup_state(&net->dev, false);

I guess this is to signal the backend the end of the presetup
information, isn't it?

Can we do it in the vhost-user backend itself? You can check the queue
a function is running against with dev->vq_index and
dev->vq_index_end.

You can see an example of checking if the function is running at the
first device with at vhost_user_backend_init, that checks
dev->vq_index =3D=3D 0.

You can see an example of vq_index_end at vhost_user_dev_start, that
only add the status if it runs in the last device. In this case, the
check is (dev->vq_index + dev->nvqs !=3D dev->vq_index_end).

> +    if (r < 0) {
> +        error_report("Finish presetup device fail: %d", r);
> +        return r;
> +    }
> +    return 0;
> +
> +error:
> +    vhost_dev_set_presetup_state(&net->dev, false);
> +    return r;
> +}
> +
> +static bool virtio_net_early_setup_needed(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    NetClientState *nc =3D qemu_get_queue(n->nic);
> +    VHostNetState *net =3D get_vhost_net(nc->peer);
> +
> +    /*
> +     * Presetup aims to reduce live migration downtime by sync device
> +     * status in setup stage. So only do presetup when source VM is in
> +     * running state.
> +     */
> +    if (runstate_is_running() &&
> +        nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER &&
> +        net->dev.vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER =
&&
> +        !vhost_dev_has_iommu(&net->dev) &&
> +        n->vhost_started &&
> +        n->status & VIRTIO_NET_S_LINK_UP) {
> +        return true;
> +    }
> +    return false;
> +}

I think it is better not to check for vhost-user here, as:
* All backends can potentially benefit from this.
* Source running vhost-user does not mean the destination is running
vhost-user too.

Another nitpick, you can directly "return runstate_is_running() &&
...;". But I'm fine with this version too.

> +
> +static const VMStateDescription vmstate_virtio_net_early =3D {
> +    .name =3D "virtio-net-early",
> +    .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
> +    .version_id =3D VIRTIO_NET_VM_VERSION,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_EARLY_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .early_setup =3D true,
> +    .post_load =3D virtio_net_load_early_setup,
> +    .needed =3D virtio_net_early_setup_needed,
> +};
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -3743,6 +3833,11 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>      if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>          virtio_net_load_ebpf(n);
>      }
> +
> +    if (n->early_migration) {
> +        vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
> +                         &vmstate_virtio_net_early, n);
> +    }
>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -3787,6 +3882,10 @@ static void virtio_net_device_unrealize(DeviceStat=
e *dev)
>      g_free(n->rss_data.indirections_table);
>      net_rx_pkt_uninit(n->rx_pkt);
>      virtio_cleanup(vdev);
> +
> +    if (n->early_migration) {
> +        vmstate_unregister(NULL, &vmstate_virtio_net_early, n);
> +    }
>  }
>
>  static void virtio_net_instance_init(Object *obj)
> @@ -3922,6 +4021,7 @@ static Property virtio_net_properties[] =3D {
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN)=
,
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>      DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> +    DEFINE_PROP_BOOL("x-early-migration", VirtIONet, early_migration, fa=
lse),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index e07a723027..9e6f90b46f 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -212,6 +212,7 @@ struct VirtIONet {
>      /* primary failover device is hidden*/
>      bool failover_primary_hidden;
>      bool failover;
> +    bool early_migration;
>      DeviceListener primary_listener;
>      QDict *primary_opts;
>      bool primary_opts_from_json;
> --
> 2.27.0
>
>



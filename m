Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB3707A28
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:14:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWuA-0002gx-Sn; Thu, 18 May 2023 02:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWu4-0002fp-85
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWu1-0005R0-Jy
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684390456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s602FP0yE5Rrz53ja+ZMAu4zf0TTsEx88sK6a4cCpU8=;
 b=BrPhZXQEciPYUtcRsqmXL3c8cF3NlvC/c7ldMRcjeWQ7qU+xyGFgIQgJtJJdLldbgR9QEd
 72IpweTkseO+1jTJA2ZJb/eturptHOeMMKDKVWwWm/lvyoAg3wh/1+wf2B3trSTDm7PjlP
 6YppkS76d7kqfUfKu3wWJ56mdEY82fc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-TATCRVdUMdiiBllyGjZPSQ-1; Thu, 18 May 2023 02:14:14 -0400
X-MC-Unique: TATCRVdUMdiiBllyGjZPSQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4ef455ba989so1135230e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684390452; x=1686982452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s602FP0yE5Rrz53ja+ZMAu4zf0TTsEx88sK6a4cCpU8=;
 b=W+NIsYM+0eHm7Xftqz1s+xOtlPbaJhgfBefTu6iZPliFhzBB93Mt+Lixf6D6xlxf9G
 9AAzGt4bz2c5xHruFKnQaQLA2TthLiPl4Zf95jcE91rrCfvwBXedaHqjMDQ9TLhZaZ4f
 v4TQ1xU5ZbwNcw1GkRoXRS0oDcL7M8l6LwXwkFZ38XLTewH01q39yEOsXechykT0bs1l
 ToWJu9cQSDilaSqaCaU4CeSrKyS3Yi6S0pvdrN1LNWwviqvBP8e6xnFnq6gvFk+PrWrQ
 VH/hRR2lk/4ibMnIHgPl/YldfC3rj4FosXOfuNsJ3AhdfNi2BwO0N0x+vmUsiiL4/Cvu
 YkcA==
X-Gm-Message-State: AC+VfDwKu7v93zcMPA3sV3VBCxbmlMZjvsdpZXOQNvCd/A0G3PWaWi77
 W2BxsNVJ7y6TuFhMaDqLQCS6/wfrrkDQgwZcTzBQN6JUe11MzooNj49OkffLboOE0lXgzYLoLqw
 IMiLuNT9zZvsTfbAVRSCmMNhNJaNcwkg=
X-Received: by 2002:a19:f709:0:b0:4eb:4335:e104 with SMTP id
 z9-20020a19f709000000b004eb4335e104mr1037233lfe.47.1684390452681; 
 Wed, 17 May 2023 23:14:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79RDGrVR7of0lnmqUq5XSC5Njtya2NAji47V2azGTFYd8KakLYBA3KP8ap9FL3IiEtpz1qWPb50Uf2e4nMeW0=
X-Received: by 2002:a19:f709:0:b0:4eb:4335:e104 with SMTP id
 z9-20020a19f709000000b004eb4335e104mr1037221lfe.47.1684390452363; Wed, 17 May
 2023 23:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230512135122.70403-1-viktor@daynix.com>
 <20230512135122.70403-3-viktor@daynix.com>
In-Reply-To: <20230512135122.70403-3-viktor@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:14:01 +0800
Message-ID: <CACGkMEvYV4jZTjejM04PRtdYPPLwW7JGnBRa3QXeWoizxJqQkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vhost: register and change IOMMU flag depending on
 Device-TLB state
To: Viktor Prutyanov <viktor@daynix.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, 
 yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 12, 2023 at 9:51=E2=80=AFPM Viktor Prutyanov <viktor@daynix.com=
> wrote:
>
> The guest can disable or never enable Device-TLB. In these cases,
> it can't be used even if enabled in QEMU. So, check Device-TLB state
> before registering IOMMU notifier and select unmap flag depending on
> that. Also, implement a way to change IOMMU notifier flag if Device-TLB
> state is changed.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2001312
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>  hw/virtio/vhost-backend.c         |  6 ++++++
>  hw/virtio/vhost.c                 | 30 ++++++++++++++++++------------
>  include/hw/virtio/vhost-backend.h |  3 +++
>  include/hw/virtio/vhost.h         |  1 +
>  4 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 8e581575c9..d39bfefd2d 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -297,6 +297,11 @@ static void vhost_kernel_set_iotlb_callback(struct v=
host_dev *dev,
>          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
>  }
>
> +static void vhost_kernel_toggle_device_iotlb(struct vhost_dev *dev)
> +{
> +    vhost_toggle_device_iotlb(dev);
> +}
> +
>  const VhostOps kernel_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
>          .vhost_backend_init =3D vhost_kernel_init,
> @@ -328,6 +333,7 @@ const VhostOps kernel_ops =3D {
>          .vhost_vsock_set_running =3D vhost_kernel_vsock_set_running,
>          .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg =3D vhost_kernel_send_device_iotlb_=
msg,
> +        .vhost_toggle_device_iotlb =3D vhost_kernel_toggle_device_iotlb,
>  };
>  #endif
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 746d130c74..41c9fbf286 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -781,7 +781,6 @@ static void vhost_iommu_region_add(MemoryListener *li=
stener,
>      Int128 end;
>      int iommu_idx;
>      IOMMUMemoryRegion *iommu_mr;
> -    int ret;
>
>      if (!memory_region_is_iommu(section->mr)) {
>          return;
> @@ -796,7 +795,9 @@ static void vhost_iommu_region_add(MemoryListener *li=
stener,
>      iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
>                                                     MEMTXATTRS_UNSPECIFIE=
D);
>      iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> -                        IOMMU_NOTIFIER_DEVIOTLB_UNMAP,
> +                        dev->vdev->device_iotlb_enabled ?
> +                            IOMMU_NOTIFIER_DEVIOTLB_UNMAP :
> +                            IOMMU_NOTIFIER_UNMAP,
>                          section->offset_within_region,
>                          int128_get64(end),
>                          iommu_idx);
> @@ -804,16 +805,8 @@ static void vhost_iommu_region_add(MemoryListener *l=
istener,
>      iommu->iommu_offset =3D section->offset_within_address_space -
>                            section->offset_within_region;
>      iommu->hdev =3D dev;
> -    ret =3D memory_region_register_iommu_notifier(section->mr, &iommu->n=
, NULL);
> -    if (ret) {
> -        /*
> -         * Some vIOMMUs do not support dev-iotlb yet.  If so, try to use=
 the
> -         * UNMAP legacy message
> -         */
> -        iommu->n.notifier_flags =3D IOMMU_NOTIFIER_UNMAP;
> -        memory_region_register_iommu_notifier(section->mr, &iommu->n,
> -                                              &error_fatal);
> -    }

So we lose this fallback. Is this really intended?

E.g does it work if you are using virtio-iommu?

Thanks

> +    memory_region_register_iommu_notifier(section->mr, &iommu->n,
> +                                          &error_fatal);
>      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
>      /* TODO: can replay help performance here? */
>  }
> @@ -841,6 +834,19 @@ static void vhost_iommu_region_del(MemoryListener *l=
istener,
>      }
>  }
>
> +void vhost_toggle_device_iotlb(struct vhost_dev *dev)
> +{
> +    struct vhost_iommu *iommu;
> +
> +    QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
> +        memory_region_unregister_iommu_notifier(iommu->mr, &iommu->n);
> +        iommu->n.notifier_flags =3D dev->vdev->device_iotlb_enabled ?
> +                IOMMU_NOTIFIER_DEVIOTLB_UNMAP : IOMMU_NOTIFIER_UNMAP;
> +        memory_region_register_iommu_notifier(iommu->mr, &iommu->n,
> +                                              &error_fatal);
> +    }
> +}
> +
>  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
>                                      struct vhost_virtqueue *vq,
>                                      unsigned idx, bool enable_log)
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index ec3fbae58d..10a3c36b4b 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -133,6 +133,8 @@ typedef int (*vhost_set_config_call_op)(struct vhost_=
dev *dev,
>
>  typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
>
> +typedef void (*vhost_toggle_device_iotlb_op)(struct vhost_dev *dev);
> +
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
>      vhost_backend_init vhost_backend_init;
> @@ -181,6 +183,7 @@ typedef struct VhostOps {
>      vhost_force_iommu_op vhost_force_iommu;
>      vhost_set_config_call_op vhost_set_config_call;
>      vhost_reset_status_op vhost_reset_status;
> +    vhost_toggle_device_iotlb_op vhost_toggle_device_iotlb;
>  } VhostOps;
>
>  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index a52f273347..785832ed46 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -320,6 +320,7 @@ bool vhost_has_free_slot(void);
>  int vhost_net_set_backend(struct vhost_dev *hdev,
>                            struct vhost_vring_file *file);
>
> +void vhost_toggle_device_iotlb(struct vhost_dev *dev);
>  int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int wr=
ite);
>
>  int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vd=
ev,
> --
> 2.35.1
>



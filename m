Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68971711EA5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 06:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2OkK-00025s-FW; Fri, 26 May 2023 00:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2OkE-00025e-In
 for qemu-devel@nongnu.org; Fri, 26 May 2023 00:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2OkC-0008Bd-JG
 for qemu-devel@nongnu.org; Fri, 26 May 2023 00:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685074078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJBPpEb806tLeYglOYS+8fr1DGF22+gIjh0S/gKxUBw=;
 b=JwP5H7sI/bbetOcZUb34/fcF+l8hOLFiH1OdvlAWX+Sl+2TI6ohZl5AXCBwmv2Mp5ceT3/
 j85xBHk/pSlop7i+JwnePeKZXIDS/MEfBS54Y71IXVnxNQEkhvKjJqa6WPVf9bni3Wt/Kx
 3SypYTuP5kLRfjmiHpSsVcmtB0Vl0Vw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-R7fCn2TkN4yrpM-9DtheTg-1; Fri, 26 May 2023 00:07:54 -0400
X-MC-Unique: R7fCn2TkN4yrpM-9DtheTg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f0176dcc1eso267952e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 21:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685074073; x=1687666073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJBPpEb806tLeYglOYS+8fr1DGF22+gIjh0S/gKxUBw=;
 b=LDhq2h5y333pFZpy2EqxlPVqfybcpgj45H8MrffYqvydcytnLqN+Jr0WpFMWrYuFKT
 YpDv5yAYJ5Z4JEOyAJ7H/ZRIywOMb+lBuHARdirJxEVa3i7q7vtAQBXcl/JmcdbeS+dR
 uDs3EzuXmmfoUOrMGnN6WFtaX2HYEK1Ax6L/1yX035aEfEXKRbNYOs8QCS1hkhJjE2jI
 nF3izMV1A9MySqWOG2q4guxQurRpsDoaFBBss38WQIm3BJN0MSqF32NLLfy/SiSdR7Zs
 InAkJ1MkDL8QdOaH39nKuPu/NoTeA3yXA2WiUwSc0KrJPngjl6XkSkGMGbZMoH3CjLQk
 zSvg==
X-Gm-Message-State: AC+VfDzsTnx8UqS4rhrpr920h/aAU9fvLE+TYzo3joOQKmWCNGKFBZ8C
 VCPopgMA1q00Cryn3HJJp1rGlZUm8mAD/v50yZF0IBRL/TMSY89y4Dafr0U5PNCEGJb8W30byl0
 MVyzHXdcivMTJkRtEgNDJeOpBSq6D8K0=
X-Received: by 2002:a05:6512:33c9:b0:4dc:8049:6f36 with SMTP id
 d9-20020a05651233c900b004dc80496f36mr1379043lfg.1.1685074073442; 
 Thu, 25 May 2023 21:07:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6q6q/Lx2FxTw7yHSndVqltB4hUnnTCxSaR5Eud8zv2NsV5qgA1Omo1p59TTIO5lsD2aLxtiuPDLz7coKqlyyA=
X-Received: by 2002:a05:6512:33c9:b0:4dc:8049:6f36 with SMTP id
 d9-20020a05651233c900b004dc80496f36mr1379037lfg.1.1685074073109; Thu, 25 May
 2023 21:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525125742.4190-1-viktor@daynix.com>
 <20230525125742.4190-2-viktor@daynix.com>
In-Reply-To: <20230525125742.4190-2-viktor@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 12:07:42 +0800
Message-ID: <CACGkMEvopt5vjqy3yxxSfFAngDAHo_mt2AZ=6ETacrYueN2GDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] vhost: register and change IOMMU flag depending on
 Device-TLB state
To: Viktor Prutyanov <viktor@daynix.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, 
 yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Thu, May 25, 2023 at 8:58=E2=80=AFPM Viktor Prutyanov <viktor@daynix.com=
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

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 23da579ce2..e48507b5a1 100644
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
> +    memory_region_register_iommu_notifier(section->mr, &iommu->n,
> +                                          &error_fatal);
>      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
>      /* TODO: can replay help performance here? */
>  }
> @@ -841,6 +834,27 @@ static void vhost_iommu_region_del(MemoryListener *l=
istener,
>      }
>  }
>
> +void vhost_toggle_device_iotlb(VirtIODevice *vdev)
> +{
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> +    struct vhost_dev *dev;
> +    struct vhost_iommu *iommu;
> +
> +    if (vdev->vhost_started) {
> +        dev =3D vdc->get_vhost(vdev);
> +    } else {
> +        return;
> +    }
> +
> +    QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
> +        memory_region_unregister_iommu_notifier(iommu->mr, &iommu->n);
> +        iommu->n.notifier_flags =3D vdev->device_iotlb_enabled ?
> +                IOMMU_NOTIFIER_DEVIOTLB_UNMAP : IOMMU_NOTIFIER_UNMAP;
> +        memory_region_register_iommu_notifier(iommu->mr, &iommu->n,
> +                                              &error_fatal);
> +    }
> +}
> +
>  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
>                                      struct vhost_virtqueue *vq,
>                                      unsigned idx, bool enable_log)
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index f7f10c8fb7..6a173cb9fa 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -320,6 +320,7 @@ bool vhost_has_free_slot(void);
>  int vhost_net_set_backend(struct vhost_dev *hdev,
>                            struct vhost_vring_file *file);
>
> +void vhost_toggle_device_iotlb(VirtIODevice *vdev);
>  int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int wr=
ite);
>
>  int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vd=
ev,
> --
> 2.21.0
>



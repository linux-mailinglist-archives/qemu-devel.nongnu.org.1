Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 227467A684C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicty-0004Ja-FC; Tue, 19 Sep 2023 11:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qictw-0004Ik-Pl
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qictv-0003tH-1R
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695138273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQRNG8JPeyPIO1u1PW71+Eev+WC4xLfclkPWphshiBk=;
 b=IAt7ZwYYwMpfGRs6LAWLwRkLUnJ7X0zPhTsrXp7BJJuG5OZG1q0wSYBIEcUgYVK00PJaaX
 fnQiV0Z5t3GBaF+S8ham7+a/PQYMHjARv6TeZOEgG1LgF/RCRGEyKEdrAcInOt197ilCWU
 4L0sCTlkAxV8zsN874CouHGNzzEGXpU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-THOYxj2aNTSggdJtws8aFw-1; Tue, 19 Sep 2023 11:44:32 -0400
X-MC-Unique: THOYxj2aNTSggdJtws8aFw-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34fc2428821so34263115ab.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 08:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695138271; x=1695743071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQRNG8JPeyPIO1u1PW71+Eev+WC4xLfclkPWphshiBk=;
 b=tGCNSnpHotwxK1UR0nf6M8f/ohSRL9VvDjVAYxr6PaoGG+HXXr3AMTYNdM5/qZXeZd
 Q9XtwWkJ7aT7Bpe/bFIjC36BVA35n+A1HA3auJjsqxI670TPG2dsoAa2hAzh0CIOZL9I
 XjQqmyVkhmmzEqxJ9y9PI/5bcsftCI30SZNnD/J578bcPM0LBFV6KdjKQp5S37At2iEJ
 C+J9FzDu8tiQp01kj7Mds26x0dmLLqVHfkpEClMoU+QoEZ4/W35pmqSmvrECeeryWSzc
 kbPZYvJLbeXtDYp5sX6NbuX3AVPcslVUDduDtkXytBoWG46hN3WCC5JejSPSruBkW2cL
 M8yQ==
X-Gm-Message-State: AOJu0YxrLrqPcW6UYiUgTo3gdv69TzLkJGCCGLwqbGCNp2FNDUcfXAUJ
 Xrpr5g1bC95kLC2UnPXSqkY21nvCUQ7yFoMPfyac3TnxSRXGPujBNb4rd99nLkzp8Q77cE6fhpG
 IzB9rM3+SsuSjfAc=
X-Received: by 2002:a05:6e02:14c1:b0:34f:70ec:d4cf with SMTP id
 o1-20020a056e0214c100b0034f70ecd4cfmr210895ilk.8.1695138271466; 
 Tue, 19 Sep 2023 08:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdNBhwJ7sHqFvflrKP2fxEKbkTZZQzPPuwxQNhOVNP6SnMF6NE7pqp2y5s1QRRz7FEnu7fsA==
X-Received: by 2002:a05:6e02:14c1:b0:34f:70ec:d4cf with SMTP id
 o1-20020a056e0214c100b0034f70ecd4cfmr210872ilk.8.1695138271183; 
 Tue, 19 Sep 2023 08:44:31 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 fu3-20020a056638668300b0043a0aa909bfsm49415jab.159.2023.09.19.08.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:44:30 -0700 (PDT)
Date: Tue, 19 Sep 2023 09:44:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 03/12] vfio: Collect container iova range info
Message-ID: <20230919094428.2cedaa30.alex.williamson@redhat.com>
In-Reply-To: <20230913080423.523953-4-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-4-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 13 Sep 2023 10:01:38 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> capability is supported.
> 
> This allows to propagate the information though the IOMMU MR
> set_iova_ranges() callback so that virtual IOMMUs
> get aware of those aperture constraints.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/common.c              | 45 +++++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index da43d27352..74b9b27270 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -98,6 +98,8 @@ typedef struct VFIOContainer {
>      QLIST_HEAD(, VFIOGroup) group_list;
>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>      QLIST_ENTRY(VFIOContainer) next;
> +    unsigned nr_iovas;
> +    struct  vfio_iova_range *iova_ranges;
>  } VFIOContainer;
>  
>  typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9aac21abb7..26da38de05 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1157,6 +1157,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>              goto fail;
>          }
>  
> +        ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
> +                container->nr_iovas, (struct Range *)container->iova_ranges,
> +                &err);

The semantics of calling this with nr_iovas == 0 and the vIOMMU driver
ignoring that it's being told there are no usable iova ranges is rather
strange.  Should nr_iovas be initialized to -1 for that or should this
call be conditional on non-zero nr_iovas?

Also, vfio_get_info_iova_range() is only called in the type1 container
path and the IOVA range info capability has only existed since kernel
v5.4.  So we need to do something sane even if we don't have the kernel
telling us about the IOVA ranges.  I think this precludes the assert in
the final patch of the series or else new QEMU on an old kernel is
broken.

> +        if (ret) {
> +            g_free(giommu);
> +            goto fail;
> +        }
> +
>          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
>                                                      &err);
>          if (ret) {
> @@ -1981,6 +1989,29 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>      return true;
>  }
>  
> +static void vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
> +                                     unsigned int *nr_iovas,
> +                                     struct  vfio_iova_range **iova_ranges)

Just pass the VFIOContainer pointer?  Thanks,

Alex

> +{
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_iommu_type1_info_cap_iova_range *cap;
> +
> +    hdr = vfio_get_iommu_type1_info_cap(info,
> +                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> +    if (hdr == NULL) {
> +        return;
> +    }
> +
> +    cap = (void *)hdr;
> +    *nr_iovas = cap->nr_iovas;
> +
> +    if (*nr_iovas == 0) {
> +        return;
> +    }
> +    *iova_ranges = g_memdup2(cap->iova_ranges,
> +                             *nr_iovas * sizeof(struct  vfio_iova_range));
> +}
> +
>  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                            struct vfio_region_info *info)
>  {
> @@ -2433,6 +2464,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>      }
>  }
>  
> +static void vfio_free_container(VFIOContainer *container)
> +{
> +    g_free(container->iova_ranges);
> +    g_free(container);
> +}
> +
>  static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                    Error **errp)
>  {
> @@ -2550,6 +2587,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
>              container->dma_max_mappings = 65535;
>          }
> +
> +        vfio_get_info_iova_range(info, &container->nr_iovas,
> +                                 &container->iova_ranges);
> +
>          vfio_get_iommu_info_migration(container, info);
>          g_free(info);
>  
> @@ -2663,7 +2704,7 @@ enable_discards_exit:
>      vfio_ram_block_discard_disable(container, false);
>  
>  free_container_exit:
> -    g_free(container);
> +    vfio_free_container(container);
>  
>  close_fd_exit:
>      close(fd);
> @@ -2717,7 +2758,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>  
>          trace_vfio_disconnect_container(container->fd);
>          close(container->fd);
> -        g_free(container);
> +        vfio_free_container(container);
>  
>          vfio_put_address_space(space);
>      }



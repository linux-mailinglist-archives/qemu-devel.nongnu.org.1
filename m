Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A17F7CE75C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:09:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBtY-0007YE-1W; Wed, 18 Oct 2023 15:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qtBtS-0007JI-0O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qtBtQ-0001iF-6f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697656062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtLAGwEmzwXMW0eTnsLgGCNwhbx7LVbuUhIXl2K1ExI=;
 b=iOU/ppKwmMx7+d6UTG5X+oD6NNNoOMDCsoAfP5px16nt2RolXgODkj3FNlP5l+GbpmU2me
 ycSuVafrqpBeOkaaoFkqrFROVLaaW1HMgq6Yx8COyZhxM3sUPJHNChPQirZLddnE1fR153
 KHUKW0Lv3qko3TWxMSXSurJWqclLvqw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-RSMJT9UnNNmqx26Y_1Ix_w-1; Wed, 18 Oct 2023 15:07:40 -0400
X-MC-Unique: RSMJT9UnNNmqx26Y_1Ix_w-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-35760da0842so22625ab.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 12:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697656059; x=1698260859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtLAGwEmzwXMW0eTnsLgGCNwhbx7LVbuUhIXl2K1ExI=;
 b=llOmqVY4B6NJnskb2iQNWJSH7hvG/Oz9SM8ATOCp1PjvrmUBOY9KXefN9enFV9hMTp
 8fjHL57DvhyrZWF1BfOMORc0m7invOw0KRzAuZNjf68pDaQ7st4qD6PD58TTxFOrfLP+
 2JfiTtsaif8Aml8ylD7nGNVjo8n+n1CN8qBpkb6PGjV5cMUdhZQWuUq73uqWOsTyaOb4
 rONrQcneP4Opq3T1HfH3mQgHIcOyNjNJkDF86CX8X9EYcPKBWPIGVcpMwzuJMGu50x5k
 GA4H4SKdebAHowpEWnVmZ4Em5Tmfd8azP/7C/8PRI5XFhtRGOUYU/Nyc3QF48vqVsAxy
 6Tgg==
X-Gm-Message-State: AOJu0YxWrQa9cq6b1256gYMRqnal1IV7oftaByoGW6Gthf6OO6LrQfr1
 DHkOFwgtXZfBzxXGRk8LJ50kiVR4/I4RP5rSf6JwzTyjhD1c7RC9loVwQHlq0/Mlk50L29/XpkD
 Z2KPrVqoVWIHc1mQ=
X-Received: by 2002:a05:6e02:1b81:b0:357:5c29:18ec with SMTP id
 h1-20020a056e021b8100b003575c2918ecmr6423699ili.1.1697656059537; 
 Wed, 18 Oct 2023 12:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdJKO8cx+e4NQNtYy7+K6nN37av7RhmEbZnxoqy5vOYkNaa9UpXcf9CXccJoV6vmDxvBvtxw==
X-Received: by 2002:a05:6e02:1b81:b0:357:5c29:18ec with SMTP id
 h1-20020a056e021b8100b003575c2918ecmr6423676ili.1.1697656059215; 
 Wed, 18 Oct 2023 12:07:39 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 h12-20020a056638062c00b00459d7c3dcf3sm1353701jar.115.2023.10.18.12.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 12:07:38 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:07:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com
Subject: Re: [PATCH v3 03/13] vfio: Collect container iova range info
Message-ID: <20231018130737.3815d3c4.alex.williamson@redhat.com>
In-Reply-To: <20231011175516.541374-4-eric.auger@redhat.com>
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231011175516.541374-4-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 11 Oct 2023 19:52:19 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> capability is supported.
> 
> This allows to propagate the information though the IOMMU MR
> set_iova_ranges() callback so that virtual IOMMUs
> get aware of those aperture constraints. This is only done if
> the info is available and the number of iova ranges is greater than
> 0.
> 
> A new vfio_get_info_iova_range helper is introduced matching
> the coding style of existing vfio_get_info_dma_avail. The
> boolean returned value isn't used though. Code is aligned
> between both.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - Turn nr_iovas into a int initialized to -1
> - memory_region_iommu_set_iova_ranges only is called if nr_iovas > 0
> - vfio_get_info_iova_range returns a bool to match
>   vfio_get_info_dma_avail. Uniformize both code by using !hdr in
>   the check
> - rebase on top of vfio-next
> ---
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/common.c              |  9 +++++++
>  hw/vfio/container.c           | 44 ++++++++++++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7780b9073a..848ff47960 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -99,6 +99,8 @@ typedef struct VFIOContainer {
>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>      QLIST_ENTRY(VFIOContainer) next;
>      QLIST_HEAD(, VFIODevice) device_list;
> +    int nr_iovas;
> +    GList *iova_ranges;

Nit, nr_iovas seems like it has a pretty weak use case here.  We can
just test iova_ranges != NULL for calling set_iova_ranges.  In patch 13
we can again test against NULL, which I think also negates the need to
assert nr_iovas since the NULL test automatically catches the zero
case.  Otherwise

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

>  } VFIOContainer;
>  
>  typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5ff5acf1d8..9d804152ba 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -699,6 +699,15 @@ static void vfio_listener_region_add(MemoryListener *listener,
>              goto fail;
>          }
>  
> +        if (container->nr_iovas > 0) {
> +            ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
> +                    container->iova_ranges, &err);
> +            if (ret) {
> +                g_free(giommu);
> +                goto fail;
> +            }
> +        }
> +
>          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
>                                                      &err);
>          if (ret) {
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index adc467210f..5122ff6d92 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -382,7 +382,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>      /* If the capability cannot be found, assume no DMA limiting */
>      hdr = vfio_get_iommu_type1_info_cap(info,
>                                          VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
> -    if (hdr == NULL) {
> +    if (!hdr) {
>          return false;
>      }
>  
> @@ -394,6 +394,33 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>      return true;
>  }
>  
> +static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
> +                                     VFIOContainer *container)
> +{
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_iommu_type1_info_cap_iova_range *cap;
> +
> +    hdr = vfio_get_iommu_type1_info_cap(info,
> +                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> +    if (!hdr) {
> +        return false;
> +    }
> +
> +    cap = (void *)hdr;
> +
> +    container->nr_iovas = cap->nr_iovas;
> +    for (int i = 0; i < cap->nr_iovas; i++) {
> +        Range *range = g_new(Range, 1);
> +
> +        range_set_bounds(range, cap->iova_ranges[i].start,
> +                         cap->iova_ranges[i].end);
> +        container->iova_ranges =
> +            range_list_insert(container->iova_ranges, range);
> +    }
> +
> +    return true;
> +}
> +
>  static void vfio_kvm_device_add_group(VFIOGroup *group)
>  {
>      Error *err = NULL;
> @@ -535,6 +562,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>      }
>  }
>  
> +static void vfio_free_container(VFIOContainer *container)
> +{
> +    g_list_free_full(container->iova_ranges, g_free);
> +    g_free(container);
> +}
> +
>  static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                    Error **errp)
>  {
> @@ -616,6 +649,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container->error = NULL;
>      container->dirty_pages_supported = false;
>      container->dma_max_mappings = 0;
> +    container->nr_iovas = -1;
> +    container->iova_ranges = NULL;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
>      QLIST_INIT(&container->vrdl_list);
> @@ -652,6 +687,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
>              container->dma_max_mappings = 65535;
>          }
> +
> +        vfio_get_info_iova_range(info, container);
> +
>          vfio_get_iommu_info_migration(container, info);
>          g_free(info);
>  
> @@ -765,7 +803,7 @@ enable_discards_exit:
>      vfio_ram_block_discard_disable(container, false);
>  
>  free_container_exit:
> -    g_free(container);
> +    vfio_free_container(container);
>  
>  close_fd_exit:
>      close(fd);
> @@ -819,7 +857,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>  
>          trace_vfio_disconnect_container(container->fd);
>          close(container->fd);
> -        g_free(container);
> +        vfio_free_container(container);
>  
>          vfio_put_address_space(space);
>      }



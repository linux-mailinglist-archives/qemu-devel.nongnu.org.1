Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B7722ED8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 20:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6F79-0000jg-Gk; Mon, 05 Jun 2023 14:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6F77-0000jA-RP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6F74-0002F4-9X
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685990369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIHsvaZsVa1Zn8ydzetkd8XdUtKcs9iKN6OxF8yv+o4=;
 b=KLog8KX5M4EPAmeClf4oCMIYuuH7G7T/aF5qvVgzCupTK8hfaNv6Q3msZJ8Q6TCrJb1aOt
 NrvWm5hscOzigAdai5C14ybr+0l9MEFKUFMYpcdXzFw2r8haj1nt12yh4K1EE3Ta0ZZguK
 myp2IyxYZYTF5EmBEXraLwz07sOl6YA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ozvrEj8LM-OkFIDAQ8AVGw-1; Mon, 05 Jun 2023 14:39:28 -0400
X-MC-Unique: ozvrEj8LM-OkFIDAQ8AVGw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f8654d47b4so3930901cf.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 11:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685990368; x=1688582368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIHsvaZsVa1Zn8ydzetkd8XdUtKcs9iKN6OxF8yv+o4=;
 b=W6o/xIZqeaJZsusSVhtINQO3Cs3WQfNPvBRS0RyX+IGzzs87a6KbpQTTDbYDA6t0ME
 7ogmaysdDq0WwrM+v8LfjJREYv2+ZQh5VHHM/fzl1yYcCdnijZ4cmntCyIJhNHTbZ/ow
 y3KTOKPZxovIKCMkQDUEhxQjFya9l/PcgbQS73XFnm/bmVfxIOknLtc7QEjtl8IutnUi
 VvHAP/qpyH4SDlXEmBjFGv43tnuwTjiMsXiVVTHKphSVSWVJ1tKn3z88CNbVSwxhysmn
 UgloXpBHfyjkLPvsPbP1fgz32y5gAfqWgdZP2jRkeYCkNkAOIkIyf8lAWi2ZwKndp4YP
 kK3Q==
X-Gm-Message-State: AC+VfDwr+zwGXCkftFqRP+yboBZ6Gos1xgBPdYJNjufXtybrxt7DYxD1
 tFZ1QXQ05xevF9YismVnUxLVxl7XYOHrfM8JK38vvVMQ8gIzbhZocoGinDCcE/OdDuiK3THC8Y+
 E1jkI2Uji6GS9+1k=
X-Received: by 2002:a05:622a:1706:b0:3f8:46d:dacc with SMTP id
 h6-20020a05622a170600b003f8046ddaccmr25128317qtk.2.1685990367690; 
 Mon, 05 Jun 2023 11:39:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sTWXSuAI2fuV7ZCBZkMpfEDYwx7XRLWNajIe2/SsGUcMs0qZwQe3w5yZ+otc3gPASr95Y/Q==
X-Received: by 2002:a05:622a:1706:b0:3f8:46d:dacc with SMTP id
 h6-20020a05622a170600b003f8046ddaccmr25128288qtk.2.1685990367376; 
 Mon, 05 Jun 2023 11:39:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g1-20020ac87d01000000b003f27719c179sm4910927qtb.69.2023.06.05.11.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 11:39:26 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:39:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Message-ID: <ZH4r3FCIU8uOiV8h@x1n>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601063320.139308-3-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 01, 2023 at 02:33:18PM +0800, Zhenzhong Duan wrote:
> Peter Xu found a potential issue:
> 
> "The other thing is when I am looking at the new code I found that we
> actually extended the replay() to be used also in dirty tracking of vfio,
> in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
> unmap_all() because afaiu log_sync() can be called in migration thread
> anytime during DMA so I think it means the device is prone to DMA with the
> IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
> fail unexpectedly.  Copy Alex, Kirti and Neo."
> 
> To eliminate this small window with empty mapping, we should remove the
> call to unmap_all(). Besides that, introduce a new notifier type called
> IOMMU_NOTIFIER_FULL_MAP to get full mappings as intel_iommu only notifies
> changed mappings while VFIO dirty page sync needs full mappings. Thanks
> to current implementation of iova tree, we could pick mappings from iova
> trees directly instead of walking through guest IOMMU page table.
> 
> IOMMU_NOTIFIER_MAP is still used to get changed mappings for optimization
> purpose. As long as notification for IOMMU_NOTIFIER_MAP could ensure shadow
> page table in sync, then it's OK.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 49 +++++++++++++++++++++++++++++++++++--------
>  hw/vfio/common.c      |  2 +-
>  include/exec/memory.h | 13 ++++++++++++
>  softmmu/memory.c      |  4 ++++
>  4 files changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 94d52f4205d2..061fcded0dfb 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3819,6 +3819,41 @@ static int vtd_replay_hook(IOMMUTLBEvent *event, void *private)
>      return 0;
>  }
>  
> +static gboolean vtd_replay_full_map(DMAMap *map, gpointer *private)
> +{
> +    IOMMUTLBEvent event;
> +
> +    event.type = IOMMU_NOTIFIER_MAP;
> +    event.entry.iova = map->iova;
> +    event.entry.addr_mask = map->size;
> +    event.entry.target_as = &address_space_memory;
> +    event.entry.perm = map->perm;
> +    event.entry.translated_addr = map->translated_addr;
> +
> +    return vtd_replay_hook(&event, private);
> +}
> +
> +/*
> + * This is a fast path to notify the full mappings falling in the scope
> + * of IOMMU notifier. The call site should ensure no iova tree update by
> + * taking necessary locks(e.x. BQL).

We should be accurate on the locking - I think it's the BQL so far.

> + */
> +static int vtd_page_walk_full_map_fast_path(IOVATree *iova_tree,
> +                                            IOMMUNotifier *n)
> +{
> +    DMAMap map;
> +
> +    map.iova = n->start;
> +    map.size = n->end - n->start;
> +    if (!iova_tree_find(iova_tree, &map)) {
> +        return 0;
> +    }
> +
> +    iova_tree_foreach_range_data(iova_tree, &map, vtd_replay_full_map,
> +                                 (gpointer *)n);
> +    return 0;
> +}
> +
>  static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>  {
>      VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
> @@ -3826,13 +3861,6 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      uint8_t bus_n = pci_bus_num(vtd_as->bus);
>      VTDContextEntry ce;
>  
> -    /*
> -     * The replay can be triggered by either a invalidation or a newly
> -     * created entry. No matter what, we release existing mappings
> -     * (it means flushing caches for UNMAP-only registers).
> -     */
> -    vtd_address_space_unmap(vtd_as, n);
> -
>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
>                                    "legacy mode",
> @@ -3850,8 +3878,11 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>                  .as = vtd_as,
>                  .domain_id = vtd_get_domain_id(s, &ce, vtd_as->pasid),
>              };
> -
> -            vtd_page_walk(s, &ce, 0, ~0ULL, &info, vtd_as->pasid);
> +            if (n->notifier_flags & IOMMU_NOTIFIER_FULL_MAP) {
> +                vtd_page_walk_full_map_fast_path(vtd_as->iova_tree, n);
> +            } else {
> +                vtd_page_walk(s, &ce, 0, ~0ULL, &info, vtd_as->pasid);
> +            }
>          }
>      } else {
>          trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..5dae4502b908 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1890,7 +1890,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>  
>                  iommu_notifier_init(&gdn.n,
>                                      vfio_iommu_map_dirty_notify,
> -                                    IOMMU_NOTIFIER_MAP,
> +                                    IOMMU_NOTIFIER_FULL_MAP,
>                                      section->offset_within_region,
>                                      int128_get64(llend),
>                                      idx);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index c3661b2276c7..eecc3eec6702 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -142,6 +142,10 @@ struct IOMMUTLBEntry {
>   *       events (e.g. VFIO). Both notifications must be accurate so that
>   *       the shadow page table is fully in sync with the guest view.
>   *
> + *       Besides MAP, there is a special use case called FULL_MAP which
> + *       requests notification for all the existent mappings (e.g. VFIO
> + *       dirty page sync).

Why do we need FULL_MAP?  Can we simply reimpl MAP?

> + *
>   *   (2) When the device doesn't need accurate synchronizations of the
>   *       vIOMMU page tables, it needs to register only with UNMAP or
>   *       DEVIOTLB_UNMAP notifies.
> @@ -164,6 +168,8 @@ typedef enum {
>      IOMMU_NOTIFIER_MAP = 0x2,
>      /* Notify changes on device IOTLB entries */
>      IOMMU_NOTIFIER_DEVIOTLB_UNMAP = 0x04,
> +    /* Notify every existent entries */
> +    IOMMU_NOTIFIER_FULL_MAP = 0x8,
>  } IOMMUNotifierFlag;
>  
>  #define IOMMU_NOTIFIER_IOTLB_EVENTS (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
> @@ -237,6 +243,13 @@ static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         hwaddr start, hwaddr end,
>                                         int iommu_idx)
>  {
> +    /*
> +     * memory_region_notify_iommu_one() needs IOMMU_NOTIFIER_MAP set to
> +     * trigger notifier.
> +     */
> +    if (flags & IOMMU_NOTIFIER_FULL_MAP) {
> +        flags |= IOMMU_NOTIFIER_MAP;
> +    }
>      n->notify = fn;
>      n->notifier_flags = flags;
>      n->start = start;
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 7d9494ce7028..0a8465007c66 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1922,6 +1922,10 @@ int memory_region_register_iommu_notifier(MemoryRegion *mr,
>      assert(n->iommu_idx >= 0 &&
>             n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
>  
> +    if (n->notifier_flags & IOMMU_NOTIFIER_FULL_MAP) {
> +        error_setg(errp, "FULL_MAP could only be used in replay");
> +    }
> +
>      QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
>      ret = memory_region_update_iommu_notify_flags(iommu_mr, errp);
>      if (ret) {
> -- 
> 2.34.1
> 

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E204870FC14
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 19:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1rp5-0001SS-Ca; Wed, 24 May 2023 12:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1rp3-0001SE-AJ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1rp0-0001du-1g
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684947523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ah5NKvypcF/AWxyzRUkpa4KEA3gAW9SihB1U6MvY5i8=;
 b=Dl8zfmenbAtsl0N+o4qF6Du7MExxlowV+kTq+IMyT3Jtcu8ozsJUO8E0Mo0NU41++UJltS
 t/KFmYzcGMLIbNWrXnqR2WQmzQG4qtTOEXLUXJBRZJf/7Rd9alvqhHOC173SDrVtDDOdNY
 zefA8XhGFGe1Vd4TDthwnr4azYxIvWI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-VqamJMxCNdu4TbUsMH_biA-1; Wed, 24 May 2023 12:58:42 -0400
X-MC-Unique: VqamJMxCNdu4TbUsMH_biA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-623a54565e6so1823196d6.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 09:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684947521; x=1687539521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ah5NKvypcF/AWxyzRUkpa4KEA3gAW9SihB1U6MvY5i8=;
 b=if2abfY5WePKMyhO1pb7P86qeoEHyjg1/MnA9DJbeVam+epIRtoSpoWwM6rTn+k0ys
 hAXNePor9g+57Ebtyy7zX0pnOqKXWK4gt/H/UntZzQ4O1MNrFPCPdDjqAm1m5u/mnZau
 QX99fNyZCX4XeKpJz4GQB0ogsnGUxGPL1XEnl2vFJHhvy0Qn7xYZmA18TNsfGMrFPx9+
 dLGuyGTPg/wNOxHtRdxSdHRo/Lw/V4Ik1UuL8n9c9qDMNssEB9Vw5kLgSLLU+RSqHJ2E
 Nqm6G6BdnXiq6m4HrSXPbltLI1gHmfJRJM7UPKg7G53JGsCwoSvHuAhowJ9a6IapidOl
 bOHg==
X-Gm-Message-State: AC+VfDz5nV8UXUoIAGYh2Dh5Iyi8y2UrbuQieE/rGrQi3/ngHgB5S5qR
 vj+R8cjNh510X0FF2xPoM/g9L8lqUyg7xbMVQjGb4Int4kW9gUdLx85XIuX7ax85rFVkau5jq7L
 cFQl6PExXO4aZPIM=
X-Received: by 2002:a05:6214:5098:b0:5ed:c96e:ca4a with SMTP id
 kk24-20020a056214509800b005edc96eca4amr3531011qvb.1.1684947521473; 
 Wed, 24 May 2023 09:58:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xOD6kXnj6EfOefLSBef8niAxUct8kgzwGV9jmffJPyhC1QNX/H9YgKt+Akl6rhQkkZ5XTKg==
X-Received: by 2002:a05:6214:5098:b0:5ed:c96e:ca4a with SMTP id
 kk24-20020a056214509800b005edc96eca4amr3530988qvb.1.1684947521120; 
 Wed, 24 May 2023 09:58:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 v19-20020ad448d3000000b0061b698e2acesm3702985qvx.18.2023.05.24.09.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 09:58:40 -0700 (PDT)
Date: Wed, 24 May 2023 12:58:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Message-ID: <ZG5CPws85lIvpT07@x1n>
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523080702.179363-1-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi, Zhenzhong,

On Tue, May 23, 2023 at 04:07:02PM +0800, Zhenzhong Duan wrote:
> Commit 63b88968f1 ("intel-iommu: rework the page walk logic") adds logic
> to record mapped IOVA ranges so we only need to send MAP or UNMAP when
> necessary. But there are still a few corner cases of unnecessary UNMAP.
> 
> One is address space switch. During switching to iommu address space,
> all the original mappings have been dropped by VFIO memory listener,
> we don't need to unmap again in replay. The other is invalidation,
> we only need to unmap when there are recorded mapped IOVA ranges,
> presuming most of OSes allocating IOVA range continuously,
> ex. on x86, linux sets up mapping from 0xffffffff downwards.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> Tested on x86 with a net card passed or hotpluged to kvm guest,
> ping/ssh pass.

Since this is a performance related patch, do you have any number to show
the effect?

> 
>  hw/i386/intel_iommu.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 94d52f4205d2..6afd6428aaaa 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3743,6 +3743,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      hwaddr start = n->start;
>      hwaddr end = n->end;
>      IntelIOMMUState *s = as->iommu_state;
> +    IOMMUTLBEvent event;
>      DMAMap map;
>  
>      /*
> @@ -3762,22 +3763,25 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      assert(start <= end);
>      size = remain = end - start + 1;
>  
> +    event.type = IOMMU_NOTIFIER_UNMAP;
> +    event.entry.target_as = &address_space_memory;
> +    event.entry.perm = IOMMU_NONE;
> +    /* This field is meaningless for unmap */
> +    event.entry.translated_addr = 0;
> +
>      while (remain >= VTD_PAGE_SIZE) {
> -        IOMMUTLBEvent event;
>          uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
>          uint64_t size = mask + 1;
>  
>          assert(size);
>  
> -        event.type = IOMMU_NOTIFIER_UNMAP;
> -        event.entry.iova = start;
> -        event.entry.addr_mask = mask;
> -        event.entry.target_as = &address_space_memory;
> -        event.entry.perm = IOMMU_NONE;
> -        /* This field is meaningless for unmap */
> -        event.entry.translated_addr = 0;
> -
> -        memory_region_notify_iommu_one(n, &event);
> +        map.iova = start;
> +        map.size = size;
> +        if (iova_tree_find(as->iova_tree, &map)) {
> +            event.entry.iova = start;
> +            event.entry.addr_mask = mask;
> +            memory_region_notify_iommu_one(n, &event);
> +        }

This one looks fine to me, but I'm not sure how much benefit we'll get here
either as this path should be rare afaiu.

>  
>          start += size;
>          remain -= size;
> @@ -3826,13 +3830,6 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      uint8_t bus_n = pci_bus_num(vtd_as->bus);
>      VTDContextEntry ce;
>  
> -    /*
> -     * The replay can be triggered by either a invalidation or a newly
> -     * created entry. No matter what, we release existing mappings
> -     * (it means flushing caches for UNMAP-only registers).
> -     */
> -    vtd_address_space_unmap(vtd_as, n);

IIUC this is needed to satisfy current replay() semantics:

    /**
     * @replay:
     *
     * Called to handle memory_region_iommu_replay().
     *
     * The default implementation of memory_region_iommu_replay() is to
     * call the IOMMU translate method for every page in the address space
     * with flag == IOMMU_NONE and then call the notifier if translate
     * returns a valid mapping. If this method is implemented then it
     * overrides the default behaviour, and must provide the full semantics
     * of memory_region_iommu_replay(), by calling @notifier for every
     * translation present in the IOMMU.

The problem is vtd_page_walk() currently by default only notifies on page
changes, so we'll notify all MAP only if we unmap all of them first.

I assumed it was not a major issue with/without it before because
previously AFAIU the major path to trigger this is when someone hot plug a
vfio-pci into an existing guest IOMMU domain, so the unmap_all() is indeed
no-op.  However from semantics level it seems unmap_all() is still needed.

The other thing is when I am looking at the new code I found that we
actually extended the replay() to be used also in dirty tracking of vfio,
in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
unmap_all() because afaiu log_sync() can be called in migration thread
anytime during DMA so I think it means the device is prone to DMA with the
IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
fail unexpectedly.  Copy Alex, Kirti and Neo.

Perhaps to fix it we'll need to teach the vtd pgtable walker to notify all
existing MAP events without touching the IOVA tree at all.

> -
>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
>                                    "legacy mode",
> -- 
> 2.34.1
> 

-- 
Peter Xu



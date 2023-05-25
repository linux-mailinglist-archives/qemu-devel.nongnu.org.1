Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B9710DA9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BPq-0004rD-QC; Thu, 25 May 2023 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2BPo-0004r2-Uc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2BPj-0002nP-DP
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685022838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0JNkGW/GgeMAeU1NWkn8A5Cywb+CQPmK1JXQ+wM+oo=;
 b=eR1O8adgIqbwj8HGURlxTl3QjhAkMfZMiGLC3A/Vf9ius2GqgD1mQHF2c1DIOUxTepYt08
 E81HNsLU6G5qcowJXgNmBLOlKlnggAXxXKLDlp3Nt388RpF8GZPsTYetgOySn/WBjIBD0e
 CbptQG4mN3o8+cawP9K/K+/13jQzB2s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-5bcgoC25Oeywu3w_TCVF1A-1; Thu, 25 May 2023 09:53:57 -0400
X-MC-Unique: 5bcgoC25Oeywu3w_TCVF1A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-624a29df9feso4584886d6.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685022836; x=1687614836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0JNkGW/GgeMAeU1NWkn8A5Cywb+CQPmK1JXQ+wM+oo=;
 b=X5EhwmeEg5vqHQcmlDy+5/at0bgbKx8M3m9t2g2gNvmO2BPp3QTp80azzRX8sMi9d+
 36t78YZk8GgWDY2JH7IrYq+s0lroXqy7IEUqyIKPSNWKBzDIW9b6OsEcW5Jqj8vnfaFi
 0E1zKUfzLahoy8iWDVfa37fN7TtRoxUAcj1KM0lhm+mDpQam+4MeiE8llAlJRS/dL/WX
 S863WYw/mZ3y4M5YfuWjgs5zA9kaYlB/uPYv2lH2oqIOWHDQHwB1itKG+DvflS3Z2jvG
 Xs8LUKt6pzb7eIwaBB+FqsFFWg0v0b2KX12eJmu1wJd/QK5wGZskgo8EjdJ96iN5CCVY
 7hfg==
X-Gm-Message-State: AC+VfDyHQwAHYwi1fCJx4QynpRV7hkfVcn/uje5EN8ovvQDIqxqUUDki
 luQm/2UdilkDzUekel4S/2achkTMDV9Nl/vOKEtM8tJi1SRuub8n9HhACNzCIS3Sx2wvJk0XvXJ
 nPYZwVnOod4KIEko=
X-Received: by 2002:a05:6214:501b:b0:625:aa48:e50f with SMTP id
 jo27-20020a056214501b00b00625aa48e50fmr5692991qvb.6.1685022836169; 
 Thu, 25 May 2023 06:53:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mgZd+cjr/N55j7nOI1m4d0zk/b5uwNWz/AeJFakCiQqQxEclAhxDh2iNMZGvVHze1thpTdA==
X-Received: by 2002:a05:6214:501b:b0:625:aa48:e50f with SMTP id
 jo27-20020a056214501b00b00625aa48e50fmr5692970qvb.6.1685022835846; 
 Thu, 25 May 2023 06:53:55 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 x7-20020ac81207000000b003f7f66d5a0esm414015qti.44.2023.05.25.06.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:53:55 -0700 (PDT)
Date: Thu, 25 May 2023 09:53:53 -0400
From: Peter Xu <peterx@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Message-ID: <ZG9ocSY+vJAd1Hjs@x1n>
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
 <ZG5CPws85lIvpT07@x1n>
 <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On Thu, May 25, 2023 at 11:29:34AM +0000, Duan, Zhenzhong wrote:
> Hi Peter,
> 
> See inline.
> >-----Original Message-----
> >From: Peter Xu <peterx@redhat.com>
> >Sent: Thursday, May 25, 2023 12:59 AM
> >Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP
> >calls
> >
> >Hi, Zhenzhong,
> >
> >On Tue, May 23, 2023 at 04:07:02PM +0800, Zhenzhong Duan wrote:
> >> Commit 63b88968f1 ("intel-iommu: rework the page walk logic") adds
> >> logic to record mapped IOVA ranges so we only need to send MAP or
> >> UNMAP when necessary. But there are still a few corner cases of
> >unnecessary UNMAP.
> >>
> >> One is address space switch. During switching to iommu address space,
> >> all the original mappings have been dropped by VFIO memory listener,
> >> we don't need to unmap again in replay. The other is invalidation, we
> >> only need to unmap when there are recorded mapped IOVA ranges,
> >> presuming most of OSes allocating IOVA range continuously, ex. on x86,
> >> linux sets up mapping from 0xffffffff downwards.
> >>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >> Tested on x86 with a net card passed or hotpluged to kvm guest,
> >> ping/ssh pass.
> >
> >Since this is a performance related patch, do you have any number to show
> >the effect?
> 
> I straced the time of UNMAP ioctl, its time is 0.000014us and we have 28 ioctl() due to
> the two notifiers in x86 are split into power of 2 pieces.
> 
> ioctl(48, VFIO_DEVICE_QUERY_GFX_PLANE or VFIO_IOMMU_UNMAP_DMA, 0x7ffffd5c42f0) = 0 <0.000014>

Could you add some information like this into the commit message when
repost?  E.g. UNMAP was xxx sec before, and this patch reduces it to yyy.

> 
> >
> >>
> >>  hw/i386/intel_iommu.c | 31 ++++++++++++++-----------------
> >>  1 file changed, 14 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> >> 94d52f4205d2..6afd6428aaaa 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -3743,6 +3743,7 @@ static void
> >vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >>      hwaddr start = n->start;
> >>      hwaddr end = n->end;
> >>      IntelIOMMUState *s = as->iommu_state;
> >> +    IOMMUTLBEvent event;
> >>      DMAMap map;
> >>
> >>      /*
> >> @@ -3762,22 +3763,25 @@ static void
> >vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >>      assert(start <= end);
> >>      size = remain = end - start + 1;
> >>
> >> +    event.type = IOMMU_NOTIFIER_UNMAP;
> >> +    event.entry.target_as = &address_space_memory;
> >> +    event.entry.perm = IOMMU_NONE;
> >> +    /* This field is meaningless for unmap */
> >> +    event.entry.translated_addr = 0;
> >> +
> >>      while (remain >= VTD_PAGE_SIZE) {
> >> -        IOMMUTLBEvent event;
> >>          uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
> >>          uint64_t size = mask + 1;
> >>
> >>          assert(size);
> >>
> >> -        event.type = IOMMU_NOTIFIER_UNMAP;
> >> -        event.entry.iova = start;
> >> -        event.entry.addr_mask = mask;
> >> -        event.entry.target_as = &address_space_memory;
> >> -        event.entry.perm = IOMMU_NONE;
> >> -        /* This field is meaningless for unmap */
> >> -        event.entry.translated_addr = 0;
> >> -
> >> -        memory_region_notify_iommu_one(n, &event);
> >> +        map.iova = start;
> >> +        map.size = size;
> >> +        if (iova_tree_find(as->iova_tree, &map)) {
> >> +            event.entry.iova = start;
> >> +            event.entry.addr_mask = mask;
> >> +            memory_region_notify_iommu_one(n, &event);
> >> +        }
> >
> >This one looks fine to me, but I'm not sure how much benefit we'll get here
> >either as this path should be rare afaiu.
> 
> Yes, I only see such UNMAP call at cold bootup/shutdown, hot plug and unplug.
> 
> In fact, the other purpose of this patch is to eliminate noisy error log when
> we work with IOMMUFD. It looks the duplicate UNMAP call will fail with IOMMUFD
> while always succeed with legacy container. This behavior difference lead to below
> error log for IOMMUFD:
> 
> IOMMU_IOAS_UNMAP failed: No such file or directory
> vfio_container_dma_unmap(0x562012d6b6d0, 0x0, 0x80000000) = -2 (No such file or directory)
> IOMMU_IOAS_UNMAP failed: No such file or directory
> vfio_container_dma_unmap(0x562012d6b6d0, 0x80000000, 0x40000000) = -2 (No such file or directory)

I see.  Please also mention this in the commit log, that'll help reviewers
understand the goal of the patch, thanks!

> 
> >
> >>
> >>          start += size;
> >>          remain -= size;
> >> @@ -3826,13 +3830,6 @@ static void
> >vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> >>      uint8_t bus_n = pci_bus_num(vtd_as->bus);
> >>      VTDContextEntry ce;
> >>
> >> -    /*
> >> -     * The replay can be triggered by either a invalidation or a newly
> >> -     * created entry. No matter what, we release existing mappings
> >> -     * (it means flushing caches for UNMAP-only registers).
> >> -     */
> >> -    vtd_address_space_unmap(vtd_as, n);
> >
> >IIUC this is needed to satisfy current replay() semantics:
> >
> >    /**
> >     * @replay:
> >     *
> >     * Called to handle memory_region_iommu_replay().
> >     *
> >     * The default implementation of memory_region_iommu_replay() is to
> >     * call the IOMMU translate method for every page in the address space
> >     * with flag == IOMMU_NONE and then call the notifier if translate
> >     * returns a valid mapping. If this method is implemented then it
> >     * overrides the default behaviour, and must provide the full semantics
> >     * of memory_region_iommu_replay(), by calling @notifier for every
> >     * translation present in the IOMMU.
> Above semantics claims calling @notifier for every translation present in the IOMMU
> But it doesn't claim if calling @notifier for non-present translation.
> I checked other custom replay() callback, ex. virtio_iommu_replay(), spapr_tce_replay()
> it looks only intel_iommu is special by calling unmap_all() before rebuild mapping.

Yes, and I'll reply below for this..

> 
> >
> >The problem is vtd_page_walk() currently by default only notifies on page
> >changes, so we'll notify all MAP only if we unmap all of them first.
> Hmm, I didn't get this point. Checked vtd_page_walk_one(), it will rebuild the
> mapping except the DMAMap is exactly same which it will skip. See below:
> 
>     /* Update local IOVA mapped ranges */
>     if (event->type == IOMMU_NOTIFIER_MAP) {
>         if (mapped) {
>             /* If it's exactly the same translation, skip */
>             if (!memcmp(mapped, &target, sizeof(target))) {
>                 trace_vtd_page_walk_one_skip_map(entry->iova, entry->addr_mask,
>                                                  entry->translated_addr);
>                 return 0;
>             } else {
>                 /*
>                  * Translation changed.  Normally this should not
>                  * happen, but it can happen when with buggy guest

So I haven't touched the vIOMMU code for a few years, but IIRC if we
replay() on an address space that has mapping already, then if without the
unmap_all() at the start we'll just notify nothing, because "mapped" will
be true for all the existing mappings, and memcmp() should return 0 too if
nothing changed?

I think (and agree) it could be a "bug" for vtd only, mostly not affecting
anything at least before vfio migration.

Do you agree, and perhaps want to fix it altogether?  If so I suppose it'll
also fix the issue below on vfio dirty sync.

Thanks,

> 
> >
> >I assumed it was not a major issue with/without it before because previously
> >AFAIU the major path to trigger this is when someone hot plug a vfio-pci into
> >an existing guest IOMMU domain, so the unmap_all() is indeed no-op.
> Yes, same for cold plug.
> 
> >However from semantics level it seems unmap_all() is still needed.
> >
> >The other thing is when I am looking at the new code I found that we actually
> >extended the replay() to be used also in dirty tracking of vfio, in
> >vfio_sync_dirty_bitmap().  For that maybe it's already broken if
> >unmap_all() because afaiu log_sync() can be called in migration thread
> >anytime during DMA so I think it means the device is prone to DMA with the
> >IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
> >fail unexpectedly.  Copy Alex, Kirti and Neo.
> Good catch, indeed.
> 
> Thanks
> Zhenzhong
> >
> >Perhaps to fix it we'll need to teach the vtd pgtable walker to notify all existing
> >MAP events without touching the IOVA tree at all.
> >
> >> -
> >>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> >>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
> >>                                    "legacy mode",
> >> --
> >> 2.34.1
> >>
> >
> >--
> >Peter Xu

-- 
Peter Xu



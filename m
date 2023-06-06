Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2C72481A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YpP-0000ec-A3; Tue, 06 Jun 2023 11:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Yof-00072H-ON
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Yod-0008Nk-Gg
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686066106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6L93cZg8Jij3ITRefcpCFuksmrQ7wrTvi+ZS+81q2o=;
 b=bMMhZRlMr6eMnQhCV1fvzDv7CQZ1l3kwJhfoAIAqwNQV2mfKFfovxmXMr4qTEHoM0CJaad
 ahr3DaL983/irhk3x6kwgXR7HoaO6HgCR1cjfx8jvSzzh5emkH/QWA5g1z/paqBUTVeyPE
 kUTnRQWC82QhYglV74SR0WOgBAUOH+E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-asDdSserOdGHvDg8LZmByA-1; Tue, 06 Jun 2023 11:41:45 -0400
X-MC-Unique: asDdSserOdGHvDg8LZmByA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75d54053a76so29611685a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066104; x=1688658104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6L93cZg8Jij3ITRefcpCFuksmrQ7wrTvi+ZS+81q2o=;
 b=B48g10vbfu3jOaUR+iLIs5BxjEEKk1YKfUO0SaK/OVHbZRRh/iWpHfO2Kcz7RFa4Ih
 MmAkJvsrow5SJUDKQne/07FEga5qB3juLRa1Y5h3ZOAvSTpTdwQJGR9dE2OJc5qginrS
 x1Kc170bZvRtE7Uhdc8Hr47v1NxZK2X4AJXCQnGEHCXMZFFyI+iBSFr+Mdec6wGdM6gi
 mKUIxky2LScaFvAxL7BQ/EE7VfsHf28317vgqd+ivXGEAwDmXYFLov1ZcqX32K0uM6qC
 kKFqJH1+rNCfInWo4r0yVh1pobfbNKSR//LVjd5rjNH49xjhOqF5osQ6d31RRHSAvNn9
 b8Tg==
X-Gm-Message-State: AC+VfDwM8dixNXExGvblQpmKIqDBITEC8jwcoUYsd9MKfnCEAImDIZtd
 x7nPMF+Fi/cnWg8Y0sZl+dtuJD816Rin1t/YsBlXO6hGMjf0GebmJSw7gxWeUwgj0gC16aWwMta
 k4hHN3nomfKIp5yE=
X-Received: by 2002:a05:620a:8c93:b0:75d:5259:1f87 with SMTP id
 ra19-20020a05620a8c9300b0075d52591f87mr2347175qkn.7.1686066104541; 
 Tue, 06 Jun 2023 08:41:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NOlWbyGzjeKMO9XC5WvCRB2Q7nv6eVx8Gy+IymHiZVTwMidFnGZwQYAOC2uE9qNSN6qM+gw==
X-Received: by 2002:a05:620a:8c93:b0:75d:5259:1f87 with SMTP id
 ra19-20020a05620a8c9300b0075d52591f87mr2347133qkn.7.1686066104100; 
 Tue, 06 Jun 2023 08:41:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i21-20020ae9ee15000000b0075cc4d03b70sm4993649qkg.22.2023.06.06.08.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:41:43 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:41:41 -0400
From: Peter Xu <peterx@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Message-ID: <ZH9TtfQ/iSChuPSj@x1n>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-3-zhenzhong.duan@intel.com>
 <ZH4r3FCIU8uOiV8h@x1n>
 <SJ0PR11MB674438D23927056A81F447DC9252A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB674438D23927056A81F447DC9252A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Jun 06, 2023 at 02:35:41AM +0000, Duan, Zhenzhong wrote:
> >-----Original Message-----
> >From: Peter Xu <peterx@redhat.com>
> >Sent: Tuesday, June 6, 2023 2:39 AM
> >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >Cc: qemu-devel@nongnu.org; mst@redhat.com; jasowang@redhat.com;
> >pbonzini@redhat.com; richard.henderson@linaro.org; eduardo@habkost.net;
> >marcel.apfelbaum@gmail.com; alex.williamson@redhat.com;
> >clg@redhat.com; david@redhat.com; philmd@linaro.org;
> >kwankhede@nvidia.com; cjia@nvidia.com; Liu, Yi L <yi.l.liu@intel.com>; Peng,
> >Chao P <chao.p.peng@intel.com>
> >Subject: Re: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
> >page sync
> >
> >On Thu, Jun 01, 2023 at 02:33:18PM +0800, Zhenzhong Duan wrote:
> >> Peter Xu found a potential issue:
> >>
> >> "The other thing is when I am looking at the new code I found that we
> >> actually extended the replay() to be used also in dirty tracking of vfio,
> >> in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
> >> unmap_all() because afaiu log_sync() can be called in migration thread
> >> anytime during DMA so I think it means the device is prone to DMA with the
> >> IOMMU pgtable quickly erased and rebuilt here, which means the DMA
> >could
> >> fail unexpectedly.  Copy Alex, Kirti and Neo."
> >>
> >> To eliminate this small window with empty mapping, we should remove the
> >> call to unmap_all(). Besides that, introduce a new notifier type called
> >> IOMMU_NOTIFIER_FULL_MAP to get full mappings as intel_iommu only
> >notifies
> >> changed mappings while VFIO dirty page sync needs full mappings. Thanks
> >> to current implementation of iova tree, we could pick mappings from iova
> >> trees directly instead of walking through guest IOMMU page table.
> >>
> >> IOMMU_NOTIFIER_MAP is still used to get changed mappings for
> >optimization
> >> purpose. As long as notification for IOMMU_NOTIFIER_MAP could ensure
> >shadow
> >> page table in sync, then it's OK.
> >>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>  hw/i386/intel_iommu.c | 49 +++++++++++++++++++++++++++++++++++------
> >--
> >>  hw/vfio/common.c      |  2 +-
> >>  include/exec/memory.h | 13 ++++++++++++
> >>  softmmu/memory.c      |  4 ++++
> >>  4 files changed, 58 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index 94d52f4205d2..061fcded0dfb 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -3819,6 +3819,41 @@ static int vtd_replay_hook(IOMMUTLBEvent
> >*event, void *private)
> >>      return 0;
> >>  }
> >>
> >> +static gboolean vtd_replay_full_map(DMAMap *map, gpointer *private)
> >> +{
> >> +    IOMMUTLBEvent event;
> >> +
> >> +    event.type = IOMMU_NOTIFIER_MAP;
> >> +    event.entry.iova = map->iova;
> >> +    event.entry.addr_mask = map->size;
> >> +    event.entry.target_as = &address_space_memory;
> >> +    event.entry.perm = map->perm;
> >> +    event.entry.translated_addr = map->translated_addr;
> >> +
> >> +    return vtd_replay_hook(&event, private);
> >> +}
> >> +
> >> +/*
> >> + * This is a fast path to notify the full mappings falling in the scope
> >> + * of IOMMU notifier. The call site should ensure no iova tree update by
> >> + * taking necessary locks(e.x. BQL).
> >
> >We should be accurate on the locking - I think it's the BQL so far.
> 
> Will update comments.
> 
> >
> >> + */
> >> +static int vtd_page_walk_full_map_fast_path(IOVATree *iova_tree,
> >> +                                            IOMMUNotifier *n)
> >> +{
> >> +    DMAMap map;
> >> +
> >> +    map.iova = n->start;
> >> +    map.size = n->end - n->start;
> >> +    if (!iova_tree_find(iova_tree, &map)) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    iova_tree_foreach_range_data(iova_tree, &map, vtd_replay_full_map,
> >> +                                 (gpointer *)n);
> >> +    return 0;
> >> +}
> >> +
> >>  static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr,
> >IOMMUNotifier *n)
> >>  {
> >>      VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace,
> >iommu);
> >> @@ -3826,13 +3861,6 @@ static void
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
> >> -
> >>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> >>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
> >>                                    "legacy mode",
> >> @@ -3850,8 +3878,11 @@ static void
> >vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> >>                  .as = vtd_as,
> >>                  .domain_id = vtd_get_domain_id(s, &ce, vtd_as->pasid),
> >>              };
> >> -
> >> -            vtd_page_walk(s, &ce, 0, ~0ULL, &info, vtd_as->pasid);
> >> +            if (n->notifier_flags & IOMMU_NOTIFIER_FULL_MAP) {
> >> +                vtd_page_walk_full_map_fast_path(vtd_as->iova_tree, n);
> >> +            } else {
> >> +                vtd_page_walk(s, &ce, 0, ~0ULL, &info, vtd_as->pasid);
> >> +            }
> >>          }
> >>      } else {
> >>          trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >> index 78358ede2764..5dae4502b908 100644
> >> --- a/hw/vfio/common.c
> >> +++ b/hw/vfio/common.c
> >> @@ -1890,7 +1890,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer
> >*container,
> >>
> >>                  iommu_notifier_init(&gdn.n,
> >>                                      vfio_iommu_map_dirty_notify,
> >> -                                    IOMMU_NOTIFIER_MAP,
> >> +                                    IOMMU_NOTIFIER_FULL_MAP,
> >>                                      section->offset_within_region,
> >>                                      int128_get64(llend),
> >>                                      idx);
> >> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >> index c3661b2276c7..eecc3eec6702 100644
> >> --- a/include/exec/memory.h
> >> +++ b/include/exec/memory.h
> >> @@ -142,6 +142,10 @@ struct IOMMUTLBEntry {
> >>   *       events (e.g. VFIO). Both notifications must be accurate so that
> >>   *       the shadow page table is fully in sync with the guest view.
> >>   *
> >> + *       Besides MAP, there is a special use case called FULL_MAP which
> >> + *       requests notification for all the existent mappings (e.g. VFIO
> >> + *       dirty page sync).
> >
> >Why do we need FULL_MAP?  Can we simply reimpl MAP?
> 
> Sorry, I just realized IOMMU_NOTIFIER_FULL_MAP is confusing.
> Maybe IOMMU_NOTIFIER_MAP_FAST_PATH could be a bit more accurate.
> 
> IIUC, currently replay() is called from two paths, one is VFIO device address
> space switch which walks over the IOMMU page table to setup initial
> mapping and cache it in IOVA tree. The other is VFIO dirty sync which
> walks over the IOMMU page table to notify the mapping, because we
> already cache the mapping in IOVA tree and VFIO dirty sync is protected
> by BQL, so I think it's fine to pick mapping from IOVA tree directly instead
> of walking over IOMMU page table. That's the reason of FULL_MAP
> (IOMMU_NOTIFIER_MAP_FAST_PATH better).
> 
> About "reimpl MAP", do you mean to walk over IOMMU page table to
> notify all existing MAP events without checking with the IOVA tree for
> difference? If you prefer, I'll rewrite an implementation this way.

We still need to maintain iova tree. IIUC that's the major complexity of
vt-d emulation, because we have that extra cache layer to sync with the
real guest iommu pgtables.

But I think we were just wrong to also notify in the unmap_all() procedure.

IIUC the right thing to do (keeping replay() the interface as-is, per it
used to be defined) is we should replace the unmap_all() to only evacuate
the iova tree (keeping all host mappings untouched, IOW, don't notify
UNMAP), and do a full resync there, which will notify all existing mappings
as MAP.  Then we don't interrupt with any existing mapping if there is
(e.g. for the dirty sync case), meanwhile we keep sync too to latest (for
moving a vfio device into an existing iommu group).

Do you think that'll work for us?

-- 
Peter Xu



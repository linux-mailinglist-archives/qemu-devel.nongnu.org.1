Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B2711FF3
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:28:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QwE-0001Xo-UY; Fri, 26 May 2023 02:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2Qw2-0001Vj-Jk
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2Qw0-0001Np-FS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685082499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0ApooA5cK9zePUEdazH/MkzaM9b4VdhlV6AowTqO4k=;
 b=G/CYa4J7MgyywAaY3NMLr9A5rFCrDW0P/8hFlEJm80vCCPoCrvq0Fkpgk/Mpd73l7I+Ntb
 20fecvPW/y3X3Ve8vznJ2et9GPcCVEZbWCh4/WxfcXrKoEahVFcyut/4LmfF0Bja66es8g
 uoKPTyAp8pLHuXnkDUl14YtKCez1KdA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-seh52HK5OPiqrvMxjL3oow-1; Fri, 26 May 2023 02:28:17 -0400
X-MC-Unique: seh52HK5OPiqrvMxjL3oow-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af28aae675so1462291fa.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 23:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685082496; x=1687674496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0ApooA5cK9zePUEdazH/MkzaM9b4VdhlV6AowTqO4k=;
 b=N2KPEkCN0g6oxRUqeClbuvDQ2WcDB06FPV0YSwgFPo9XTGL2ru1qUnaGgbpCFAMqcn
 JB4Yy5MPtykw5y116ey3vTmjUQb9Szfy4N31M/Xt80uIMQ49sdfWRSoF9YAgz6nUhFJE
 203pLk5ujF3Q7/WIHpxc9ePWVdCHFvSJfRA+ChqN62Z5OA4MFnKpBYXr1dZb3EL8UCiQ
 wwqmnCwoXX61aCIGNnPbf1ubR/bxp1f6Zc3L3etL1O+VbkvNlKbnjhAoY17JNiiBMKpk
 fyM10pFtUGZWg9y2ox+6sEla8d5Kqa2sjPReBzsoVsaWYqAlLoUZxz5ZMdFslPeJtAog
 Rdqw==
X-Gm-Message-State: AC+VfDzr1XqUtMTQ2eoD6KKvt+KQzdoIGgM5Xc0ftlD63vLRNctgTQbD
 O6vaH+UaHk/puoTf1WMRx4wtoYflhrxKXvBIxaeLOML3mOI74NB+Cv91I5oyrcZHIs5PH6Jb/1j
 4ewdVprn+WGbvs4jUFA+bLATeOKc4bTM=
X-Received: by 2002:a2e:720d:0:b0:2af:29ea:c72 with SMTP id
 n13-20020a2e720d000000b002af29ea0c72mr294992ljc.6.1685082496281; 
 Thu, 25 May 2023 23:28:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hWKKFZftcYg94AsU3cc3oF77/A6xk+lxEPx/SWYUEr8WhgbK3fqTwfdlLsmjTzIcPY3hzisr2lk812qmLH5M=
X-Received: by 2002:a2e:720d:0:b0:2af:29ea:c72 with SMTP id
 n13-20020a2e720d000000b002af29ea0c72mr294973ljc.6.1685082495883; Thu, 25 May
 2023 23:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
 <ZG5CPws85lIvpT07@x1n>
 <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZG9ocSY+vJAd1Hjs@x1n>
 <SJ0PR11MB67449B49619CCF94ECA7447392479@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67449B49619CCF94ECA7447392479@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 14:28:04 +0800
Message-ID: <CACGkMEueaUvopf0zv4dxe=D5PLHkQkeV8-QshH8gmObVY6J9cg@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>, 
 Alex Williamson <alex.williamson@redhat.com>
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

On Fri, May 26, 2023 at 2:22=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
> >-----Original Message-----
> >From: Peter Xu <peterx@redhat.com>
> >Sent: Thursday, May 25, 2023 9:54 PM
> >Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP
> >calls
> >
> >On Thu, May 25, 2023 at 11:29:34AM +0000, Duan, Zhenzhong wrote:
> >> Hi Peter,
> >>
> >> See inline.
> >> >-----Original Message-----
> >> >From: Peter Xu <peterx@redhat.com>
> >> >Sent: Thursday, May 25, 2023 12:59 AM
> >> >Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP
> >> >calls
> >> >
> >> >Hi, Zhenzhong,
> >> >
> >> >On Tue, May 23, 2023 at 04:07:02PM +0800, Zhenzhong Duan wrote:
> >> >> Commit 63b88968f1 ("intel-iommu: rework the page walk logic") adds
> >> >> logic to record mapped IOVA ranges so we only need to send MAP or
> >> >> UNMAP when necessary. But there are still a few corner cases of
> >> >unnecessary UNMAP.
> >> >>
> >> >> One is address space switch. During switching to iommu address
> >> >> space, all the original mappings have been dropped by VFIO memory
> >> >> listener, we don't need to unmap again in replay. The other is
> >> >> invalidation, we only need to unmap when there are recorded mapped
> >> >> IOVA ranges, presuming most of OSes allocating IOVA range
> >> >> continuously, ex. on x86, linux sets up mapping from 0xffffffff
> >downwards.
> >> >>
> >> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> >> ---
> >> >> Tested on x86 with a net card passed or hotpluged to kvm guest,
> >> >> ping/ssh pass.
> >> >
> >> >Since this is a performance related patch, do you have any number to
> >> >show the effect?
> >>
> >> I straced the time of UNMAP ioctl, its time is 0.000014us and we have
> >> 28 ioctl() due to the two notifiers in x86 are split into power of 2 p=
ieces.
> >>
> >> ioctl(48, VFIO_DEVICE_QUERY_GFX_PLANE or VFIO_IOMMU_UNMAP_DMA,
> >> 0x7ffffd5c42f0) =3D 0 <0.000014>
> >
> >Could you add some information like this into the commit message when
> >repost?  E.g. UNMAP was xxx sec before, and this patch reduces it to yyy=
.
> Sure, will do.
>
> >
> >>
> >> >
> >> >>
> >> >>  hw/i386/intel_iommu.c | 31 ++++++++++++++-----------------
> >> >>  1 file changed, 14 insertions(+), 17 deletions(-)
> >> >>
> >> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> >> >> 94d52f4205d2..6afd6428aaaa 100644
> >> >> --- a/hw/i386/intel_iommu.c
> >> >> +++ b/hw/i386/intel_iommu.c
> >> >> @@ -3743,6 +3743,7 @@ static void
> >> >vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >> >>      hwaddr start =3D n->start;
> >> >>      hwaddr end =3D n->end;
> >> >>      IntelIOMMUState *s =3D as->iommu_state;
> >> >> +    IOMMUTLBEvent event;
> >> >>      DMAMap map;
> >> >>
> >> >>      /*
> >> >> @@ -3762,22 +3763,25 @@ static void
> >> >vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >> >>      assert(start <=3D end);
> >> >>      size =3D remain =3D end - start + 1;
> >> >>
> >> >> +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> >> >> +    event.entry.target_as =3D &address_space_memory;
> >> >> +    event.entry.perm =3D IOMMU_NONE;
> >> >> +    /* This field is meaningless for unmap */
> >> >> +    event.entry.translated_addr =3D 0;
> >> >> +
> >> >>      while (remain >=3D VTD_PAGE_SIZE) {
> >> >> -        IOMMUTLBEvent event;
> >> >>          uint64_t mask =3D dma_aligned_pow2_mask(start, end, s->aw_=
bits);
> >> >>          uint64_t size =3D mask + 1;
> >> >>
> >> >>          assert(size);
> >> >>
> >> >> -        event.type =3D IOMMU_NOTIFIER_UNMAP;
> >> >> -        event.entry.iova =3D start;
> >> >> -        event.entry.addr_mask =3D mask;
> >> >> -        event.entry.target_as =3D &address_space_memory;
> >> >> -        event.entry.perm =3D IOMMU_NONE;
> >> >> -        /* This field is meaningless for unmap */
> >> >> -        event.entry.translated_addr =3D 0;
> >> >> -
> >> >> -        memory_region_notify_iommu_one(n, &event);
> >> >> +        map.iova =3D start;
> >> >> +        map.size =3D size;
> >> >> +        if (iova_tree_find(as->iova_tree, &map)) {
> >> >> +            event.entry.iova =3D start;
> >> >> +            event.entry.addr_mask =3D mask;
> >> >> +            memory_region_notify_iommu_one(n, &event);
> >> >> +        }
> >> >
> >> >This one looks fine to me, but I'm not sure how much benefit we'll
> >> >get here either as this path should be rare afaiu.
> >>
> >> Yes, I only see such UNMAP call at cold bootup/shutdown, hot plug and
> >unplug.
> >>
> >> In fact, the other purpose of this patch is to eliminate noisy error
> >> log when we work with IOMMUFD. It looks the duplicate UNMAP call will
> >> fail with IOMMUFD while always succeed with legacy container. This
> >> behavior difference lead to below error log for IOMMUFD:

A dumb question, should IOMMUFD stick the same behaviour with legacy contai=
ner?

Thanks

> >>
> >> IOMMU_IOAS_UNMAP failed: No such file or directory
> >> vfio_container_dma_unmap(0x562012d6b6d0, 0x0, 0x80000000) =3D -2 (No
> >> such file or directory) IOMMU_IOAS_UNMAP failed: No such file or
> >> directory vfio_container_dma_unmap(0x562012d6b6d0, 0x80000000,
> >> 0x40000000) =3D -2 (No such file or directory)
> >
> >I see.  Please also mention this in the commit log, that'll help reviewe=
rs
> >understand the goal of the patch, thanks!
> Will do.
>
> >
> >>
> >> >
> >> >>
> >> >>          start +=3D size;
> >> >>          remain -=3D size;
> >> >> @@ -3826,13 +3830,6 @@ static void
> >> >vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier
> >*n)
> >> >>      uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
> >> >>      VTDContextEntry ce;
> >> >>
> >> >> -    /*
> >> >> -     * The replay can be triggered by either a invalidation or a n=
ewly
> >> >> -     * created entry. No matter what, we release existing mappings
> >> >> -     * (it means flushing caches for UNMAP-only registers).
> >> >> -     */
> >> >> -    vtd_address_space_unmap(vtd_as, n);
> >> >
> >> >IIUC this is needed to satisfy current replay() semantics:
> >> >
> >> >    /**
> >> >     * @replay:
> >> >     *
> >> >     * Called to handle memory_region_iommu_replay().
> >> >     *
> >> >     * The default implementation of memory_region_iommu_replay() is =
to
> >> >     * call the IOMMU translate method for every page in the address =
space
> >> >     * with flag =3D=3D IOMMU_NONE and then call the notifier if tran=
slate
> >> >     * returns a valid mapping. If this method is implemented then it
> >> >     * overrides the default behaviour, and must provide the full sem=
antics
> >> >     * of memory_region_iommu_replay(), by calling @notifier for ever=
y
> >> >     * translation present in the IOMMU.
> >> Above semantics claims calling @notifier for every translation present
> >> in the IOMMU But it doesn't claim if calling @notifier for non-present
> >translation.
> >> I checked other custom replay() callback, ex. virtio_iommu_replay(),
> >> spapr_tce_replay() it looks only intel_iommu is special by calling unm=
ap_all()
> >before rebuild mapping.
> >
> >Yes, and I'll reply below for this..
> >
> >>
> >> >
> >> >The problem is vtd_page_walk() currently by default only notifies on
> >> >page changes, so we'll notify all MAP only if we unmap all of them fi=
rst.
> >> Hmm, I didn't get this point. Checked vtd_page_walk_one(), it will
> >> rebuild the mapping except the DMAMap is exactly same which it will sk=
ip.
> >See below:
> >>
> >>     /* Update local IOVA mapped ranges */
> >>     if (event->type =3D=3D IOMMU_NOTIFIER_MAP) {
> >>         if (mapped) {
> >>             /* If it's exactly the same translation, skip */
> >>             if (!memcmp(mapped, &target, sizeof(target))) {
> >>                 trace_vtd_page_walk_one_skip_map(entry->iova, entry-
> >>addr_mask,
> >>                                                  entry->translated_add=
r);
> >>                 return 0;
> >>             } else {
> >>                 /*
> >>                  * Translation changed.  Normally this should not
> >>                  * happen, but it can happen when with buggy guest
> >
> >So I haven't touched the vIOMMU code for a few years, but IIRC if we
> >replay() on an address space that has mapping already, then if without t=
he
> >unmap_all() at the start we'll just notify nothing, because "mapped" wil=
l be
> >true for all the existing mappings, and memcmp() should return 0 too if
> >nothing changed?
> Understood, you are right. VFIO migration dirty sync needs to be notified
> even if mapping is unchanged.
>
> >
> >I think (and agree) it could be a "bug" for vtd only, mostly not affecti=
ng
> >anything at least before vfio migration.
> >
> >Do you agree, and perhaps want to fix it altogether?  If so I suppose it=
'll also
> >fix the issue below on vfio dirty sync.
> Yes, I'll write an implementation.
>
> Thanks
> Zhenzhong



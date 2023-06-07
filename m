Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 752757262DA
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uBQ-0005WN-I5; Wed, 07 Jun 2023 10:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6uBG-0005VM-6o
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6uBE-0005dE-GC
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686148231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E95GVJnb/tCku5yHEPFo3xwlEkjFtQVWwBlNWXe+wv4=;
 b=Q1cyJgKC1aiCpaQk9qu5TUGpuHsJvUabyTtim4p7L1js6ig0s9AM0L8hGWX3GymmeKqh5a
 FLxBUsKyRjfgQgTkgvg4dP7ck/YEt61rhrESnQhelqHDaidfvvUYs4L9bmd9thaNE+YBZU
 viLa15xbC0ST2tYqKuF0s9XBlr0mzVY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-nDuc1E1wOSiOw9gTwmGoHQ-1; Wed, 07 Jun 2023 10:06:24 -0400
X-MC-Unique: nDuc1E1wOSiOw9gTwmGoHQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f86a3ce946so8027751cf.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686146783; x=1688738783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E95GVJnb/tCku5yHEPFo3xwlEkjFtQVWwBlNWXe+wv4=;
 b=TQhKLIc7hi7F2PQBX7DkSus/a1ys8SsEWrRfp+hykhVX1GM2lyYdNMyeeP/+3Yr8Rs
 gFLj1z1P8wyPuH4lxRXnNlHFUM/cctB3lbb2EtZqACLTLeJt0gKUrIdAPu+/0q2yOCxN
 YbazuafJkcuZ+hpBky6a78UfW0xt1YGso/MDR+UKL0BtOHEs7mCq6jHxzgQ0RRf3op5W
 1zgTj4cgJi0KnnE7pX9vaOHCjW/kw/7OkbItlx/m5SIYaAgzgPT9PErrC1R89tumxYKZ
 7rCQYN8AFDrT3LSCtuCkllaUn/4MSJhkLi330quX+81AyuDGnS5xPjKCHcBxeB2Hjtlz
 /oXA==
X-Gm-Message-State: AC+VfDxOwtkMgJyzOTRQYX0Y8Pa+yXQHspFibKzZBMCVvD7xuhPGKDeC
 DooKSY6uJzYKCSkQFDH/VRDwaZvtY95+NN58wrJ47LRnF1OR7Fqivs/FEe0E9Iooe/vaUn75+hz
 mnaJ9e9ZvrivyZx0=
X-Received: by 2002:a05:622a:19a9:b0:3f9:bb67:12ba with SMTP id
 u41-20020a05622a19a900b003f9bb6712bamr1853070qtc.2.1686146783301; 
 Wed, 07 Jun 2023 07:06:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5iIRrTUB1a0qbqGMFZDhkRBXZ7BrXau5gf/a0mTcIvPX3Iu9CA7oI2HnHLFwHwAY3JI1xFhw==
X-Received: by 2002:a05:622a:19a9:b0:3f9:bb67:12ba with SMTP id
 u41-20020a05622a19a900b003f9bb6712bamr1852975qtc.2.1686146781864; 
 Wed, 07 Jun 2023 07:06:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i4-20020ac813c4000000b003f4e1cf23easm72574qtj.73.2023.06.07.07.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 07:06:21 -0700 (PDT)
Date: Wed, 7 Jun 2023 10:06:19 -0400
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
Message-ID: <ZICO2/bsxC4cnDRX@x1n>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-3-zhenzhong.duan@intel.com>
 <ZH4r3FCIU8uOiV8h@x1n>
 <SJ0PR11MB674438D23927056A81F447DC9252A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZH9TtfQ/iSChuPSj@x1n>
 <SJ0PR11MB6744F1C210BFDB46BD9269389253A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744F1C210BFDB46BD9269389253A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On Wed, Jun 07, 2023 at 03:14:07AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Peter Xu <peterx@redhat.com>
> >Sent: Tuesday, June 6, 2023 11:42 PM
> >Subject: Re: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
> >page sync
> >
> ...
> >> >> a/include/exec/memory.h b/include/exec/memory.h index
> >> >> c3661b2276c7..eecc3eec6702 100644
> >> >> --- a/include/exec/memory.h
> >> >> +++ b/include/exec/memory.h
> >> >> @@ -142,6 +142,10 @@ struct IOMMUTLBEntry {
> >> >>   *       events (e.g. VFIO). Both notifications must be accurate so that
> >> >>   *       the shadow page table is fully in sync with the guest view.
> >> >>   *
> >> >> + *       Besides MAP, there is a special use case called FULL_MAP which
> >> >> + *       requests notification for all the existent mappings (e.g. VFIO
> >> >> + *       dirty page sync).
> >> >
> >> >Why do we need FULL_MAP?  Can we simply reimpl MAP?
> >>
> >> Sorry, I just realized IOMMU_NOTIFIER_FULL_MAP is confusing.
> >> Maybe IOMMU_NOTIFIER_MAP_FAST_PATH could be a bit more accurate.
> >>
> >> IIUC, currently replay() is called from two paths, one is VFIO device
> >> address space switch which walks over the IOMMU page table to setup
> >> initial mapping and cache it in IOVA tree. The other is VFIO dirty
> >> sync which walks over the IOMMU page table to notify the mapping,
> >> because we already cache the mapping in IOVA tree and VFIO dirty sync
> >> is protected by BQL, so I think it's fine to pick mapping from IOVA
> >> tree directly instead of walking over IOMMU page table. That's the
> >> reason of FULL_MAP (IOMMU_NOTIFIER_MAP_FAST_PATH better).
> >>
> >> About "reimpl MAP", do you mean to walk over IOMMU page table to
> >> notify all existing MAP events without checking with the IOVA tree for
> >> difference? If you prefer, I'll rewrite an implementation this way.
> >
> >We still need to maintain iova tree. IIUC that's the major complexity of vt-d
> >emulation, because we have that extra cache layer to sync with the real guest
> >iommu pgtables.
> 
> Can't agree more, looks only intel-iommu and virtio-iommu implemented such
> optimization for now.
> 
> >
> >But I think we were just wrong to also notify in the unmap_all() procedure.
> >
> >IIUC the right thing to do (keeping replay() the interface as-is, per it used to be
> >defined) is we should replace the unmap_all() to only evacuate the iova tree
> >(keeping all host mappings untouched, IOW, don't notify UNMAP), and do a
> >full resync there, which will notify all existing mappings as MAP.  Then we
> >don't interrupt with any existing mapping if there is (e.g. for the dirty sync
> >case), meanwhile we keep sync too to latest (for moving a vfio device into an
> >existing iommu group).
> >
> >Do you think that'll work for us?
> 
> Yes, I think I get your point.
> Below simple change will work in your suggested way, do you agree?
> 
> @@ -3825,13 +3833,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      IntelIOMMUState *s = vtd_as->iommu_state;
>      uint8_t bus_n = pci_bus_num(vtd_as->bus);
>      VTDContextEntry ce;
> +    DMAMap map = { .iova = 0, .size = HWADDR_MAX }
> 
> -    /*
> -     * The replay can be triggered by either a invalidation or a newly
> -     * created entry. No matter what, we release existing mappings
> -     * (it means flushing caches for UNMAP-only registers).
> -     */
> -    vtd_address_space_unmap(vtd_as, n);
> +    /* replay is protected by BQL, page walk will re-setup IOVA tree safely */
> +    iova_tree_remove(as->iova_tree, map);
> 
>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :

Yes, thanks!

-- 
Peter Xu



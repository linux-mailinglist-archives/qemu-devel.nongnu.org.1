Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278BF72473C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YFM-0005b4-Ic; Tue, 06 Jun 2023 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6YFJ-0005Ye-Hh
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6YFG-00004s-Pg
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686063913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uchxo4L8N2b+bTWvzt3RWsZcs6DUSWNpMmEb4Z//v0o=;
 b=hhxSKD48FPXwwm6EkyfDx5nuAPB0JvZIHABGFg5By2FScD39AQO2d+e6Uo80y7mc6ErxY/
 oF0/k7zEx6PFPJ46kuoc40s8MdbOWJhjvLynOOT3+3tIpM6cdlTCU6ao2gWNQ8NyKTKzOH
 kLUzlJLo5+ZsyK3AEhZKnakZRyvUgC0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-q7jVyC_uM-6j_n9SUCKigw-1; Tue, 06 Jun 2023 11:05:10 -0400
X-MC-Unique: q7jVyC_uM-6j_n9SUCKigw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75ec91f26c8so24474485a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686063909; x=1688655909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uchxo4L8N2b+bTWvzt3RWsZcs6DUSWNpMmEb4Z//v0o=;
 b=G9jiS07ab2vSNv3eTcE+3Yg14xdWyOj5j9qKJ0cuZxF1SMW3Yi0ZXQ7Ht1QiX112WM
 jliYakpIKbiDfJGtbNV4uBGSIBrd/g6LVHKLfckf1IXkjT54I5CRX3YO+z1ErohFnoF+
 149Ar10l6JQ5x4/X1nun9w776IBbM8OjhQUqodMmWytaH/u+/Ydly3eo2LsbP+a2of5N
 4+WzA5db9eSnNAbq722PsmHdA8OB9cWx0GY0wgimQkyVRySShc4BzWTXEbXIcHxkpMus
 Fja6heZiKCuqT7YDqiO4n8soU6xhAiHB9QFEINAEnAQvyc/Cli5AYwfeMkg5/HWQCr/l
 oG1A==
X-Gm-Message-State: AC+VfDyl1qxuBAwUeiDz2dCATEeL+g3jp04j9lZINK8iA1eHb2/b8cVO
 vbFX+6X8Mv3+GJcIeXrowdd40B5j5QJfjCO8qG2sy5eobZ+0NVNVXx669uZMx83E/r6YmTxILpc
 3rKoseNWnNtuA9AxMXBap/iw=
X-Received: by 2002:a05:620a:268b:b0:75d:4db2:6824 with SMTP id
 c11-20020a05620a268b00b0075d4db26824mr3026316qkp.2.1686063908976; 
 Tue, 06 Jun 2023 08:05:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50b+gg/f+CFu2cRw8l2hoCd2rba/yBpMl+STczwVydFi4+JDAUCm3P89866qxyzgcWIEGqZw==
X-Received: by 2002:a05:620a:268b:b0:75d:4db2:6824 with SMTP id
 c11-20020a05620a268b00b0075d4db26824mr3026278qkp.2.1686063908550; 
 Tue, 06 Jun 2023 08:05:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d2-20020a05620a166200b0075cecc90e95sm4922660qko.90.2023.06.06.08.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:05:07 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:05:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 03/15] hw/pci: Add a pci_device_iommu_memory_region()
 helper
Message-ID: <ZH9LIqTK2KBafcXO@x1n>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-4-joao.m.martins@oracle.com>
 <ZH4UAtl1v8JDWsl1@x1n>
 <8db546c9-395a-432e-ef07-ed6d6447a097@oracle.com>
 <ZH9Kr6mrKNqUgcYs@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH9Kr6mrKNqUgcYs@x1n>
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

[ I forgot to really copy anyone, as usual.. trying again ]

On Tue, Jun 06, 2023 at 11:03:11AM -0400, Peter Xu wrote:
> On Tue, Jun 06, 2023 at 12:22:16PM +0100, Joao Martins wrote:
> > On 05/06/2023 17:57, Peter Xu wrote:
> > > On Tue, May 30, 2023 at 06:59:25PM +0100, Joao Martins wrote:
> > >> Much like pci_device_iommu_address_space() fetches the IOMMU AS, add a
> > >> pci_device_iommu_memory_region() which lets it return an the IOMMU MR
> > >> associated with it. The IOMMU MR is returned correctly for vIOMMUs using
> > >> pci_setup_iommu_info(). Note that today most vIOMMUs create the address
> > >> space and IOMMU MR at the same time, it's just mainly that there's API
> > >> to make the latter available.
> > > 
> > > Have you looked into other archs outside x86?  IIRC on some other arch one
> > > address space can have >1 IOMMU memory regions.. at least with such AS and
> > > MR layering it seems always possible?  Thanks,
> > > 
> > 
> > I looked at all callers of pci_setup_iommu() restricting to those that actually
> > track an IOMMUMemoryRegion when they create a address space... as this is where
> > pci_device_iommu_memory_region() is applicable. From looking at those[*], I see
> > always a 1:1 association between the AS and the IOMMU-MR in their initialization
> > when iommu_fn is called. Unless I missed something... Is there an arch you were
> > thinking specifically?
> 
> If only observing the ones that "track an IOMMUMemoryRegion when they
> create a address space", probably we're fine.  I was thinking ppc but I
> don't really know the details, and I assume that's not in the scope.
> Copying David Gibson just in case he got some comments here.
> 
> > 
> > [I am not sure we can track today an 1:N AS->IOMMU association today in Qemu]
> 
> IIUC we can?  The address space only have a root MR, and with that after
> translate() upon the root mr (per address_space_translate_iommu(), it can
> even be a few rounds of nested translations) it can go into whatever MR
> under it IIUC.  Different ranges can map to a different IOMMU MR logically.
> 
> > 
> > [*] alpha, arm smmu, ppc, s390, virtio, and some pci bridges (pnv_phb3 and pnv_phb4)
> 
> I just worried what we need here is not a MR object but a higher level
> object like the vIOMMU object.  We used to have a requirement with Scalable
> IOV (SVA) on Intel.  I tried to dig a bit in my inbox, not sure whether
> it's the latest status, just to show what I meant:
> 
> https://lore.kernel.org/r/20210302203827.437645-6-yi.l.liu@intel.com
> 
> Copy Yi too for that too.  From that aspect it makes more sense to me to
> fetching things from either an IOMMUops or "an iommu object", rather than
> relying on a specific MR (it'll also make it even harder when we can have
> >1 vIOMMUs so different MR can point to different IOMMUs in the future).
> 
> I assume the two goals have similar requirement, iiuc.  If that's the case,
> we'd better make sure we'll have one way to work for both.
> 
> -- 
> Peter Xu

-- 
Peter Xu



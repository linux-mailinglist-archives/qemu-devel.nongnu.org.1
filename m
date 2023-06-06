Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B797B724733
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YDU-0004OP-5p; Tue, 06 Jun 2023 11:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6YDR-0004Nt-B2
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6YDP-0007rb-5g
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686063797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7pVKKPpdpfRnLzpFkbTN0VrxzJJg2IJrH8m3xg3TGxc=;
 b=V7m1E0wOuN2/QV8zN8jVeRj6hMO6k9zQy92SgcJOmV/hkEAxebj9UL65clXCDZD1NJwONB
 JPow9cTbweT3cZqZwm+rpdNg+VKol+vTyksnbYrmdZ4AI1RxXYpAFu1IitBDk9wmN15cnC
 2FK2V7c6c8lFm62JWuy7udu5rE3GpIM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-9olNpG1EO8KLlAnLqwBp6A-1; Tue, 06 Jun 2023 11:03:15 -0400
X-MC-Unique: 9olNpG1EO8KLlAnLqwBp6A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62b6792293dso718816d6.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686063795; x=1688655795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pVKKPpdpfRnLzpFkbTN0VrxzJJg2IJrH8m3xg3TGxc=;
 b=BW3QPajKi+skAzEnAEmiC3cbt3vj7ZKyv5Js6ZP1+CjBjND/h5wVHJVSffvXA0YaoZ
 LxAH8KVFZYayXTbkfmZqqjGRTa9AfEf0qzaCKGTjBRQrp7wvdIyiuXFg9dQ/buhzvWKv
 8zW71e58Gud5WFuytmTpKsQK/Vc2CXe7YXjzbkX77DR4O1gdKEAy3+ZQTpjAS7qQMgh7
 aExhQdaIv6MnQUy/DmP4yFvV6FWjTXWn08dLj+g+h5cOx4Fg1lzeeXIKEYuMtpX94EVA
 d2oMR7f2S+5ScIniuP1xBReowSyc0Bb9l62E+3wC6sTDbWQ3zycu2j0Slxp+Gwy4sfsE
 CWiw==
X-Gm-Message-State: AC+VfDyh6rnumV6DvHhfy6QbgJQ72WXLiVOyhvuSF9AIfQkuNwYfVIQ+
 RWinXHeK644R6wFT8uyj9+RJJ8inoa/nOycVEwZckq1FSkG2ZpqVr7oDGnYhL7kvhHw5t2tl9wU
 NSFRwyVyNAtWzkyI=
X-Received: by 2002:ad4:5dea:0:b0:624:dcc5:819f with SMTP id
 jn10-20020ad45dea000000b00624dcc5819fmr2522815qvb.1.1686063794390; 
 Tue, 06 Jun 2023 08:03:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pTfx1eR0xVxg96JwvZhclIcsBYotr9QKC6G/Cwy8xxli0OVI3QjsMfXM8i2jXaNUvaTe9oA==
X-Received: by 2002:ad4:5dea:0:b0:624:dcc5:819f with SMTP id
 jn10-20020ad45dea000000b00624dcc5819fmr2522784qvb.1.1686063794081; 
 Tue, 06 Jun 2023 08:03:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ph12-20020a0562144a4c00b0061c83f00767sm5451839qvb.3.2023.06.06.08.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:03:13 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:03:11 -0400
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
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 03/15] hw/pci: Add a pci_device_iommu_memory_region()
 helper
Message-ID: <ZH9Kr6mrKNqUgcYs@x1n>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-4-joao.m.martins@oracle.com>
 <ZH4UAtl1v8JDWsl1@x1n>
 <8db546c9-395a-432e-ef07-ed6d6447a097@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8db546c9-395a-432e-ef07-ed6d6447a097@oracle.com>
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

On Tue, Jun 06, 2023 at 12:22:16PM +0100, Joao Martins wrote:
> On 05/06/2023 17:57, Peter Xu wrote:
> > On Tue, May 30, 2023 at 06:59:25PM +0100, Joao Martins wrote:
> >> Much like pci_device_iommu_address_space() fetches the IOMMU AS, add a
> >> pci_device_iommu_memory_region() which lets it return an the IOMMU MR
> >> associated with it. The IOMMU MR is returned correctly for vIOMMUs using
> >> pci_setup_iommu_info(). Note that today most vIOMMUs create the address
> >> space and IOMMU MR at the same time, it's just mainly that there's API
> >> to make the latter available.
> > 
> > Have you looked into other archs outside x86?  IIRC on some other arch one
> > address space can have >1 IOMMU memory regions.. at least with such AS and
> > MR layering it seems always possible?  Thanks,
> > 
> 
> I looked at all callers of pci_setup_iommu() restricting to those that actually
> track an IOMMUMemoryRegion when they create a address space... as this is where
> pci_device_iommu_memory_region() is applicable. From looking at those[*], I see
> always a 1:1 association between the AS and the IOMMU-MR in their initialization
> when iommu_fn is called. Unless I missed something... Is there an arch you were
> thinking specifically?

If only observing the ones that "track an IOMMUMemoryRegion when they
create a address space", probably we're fine.  I was thinking ppc but I
don't really know the details, and I assume that's not in the scope.
Copying David Gibson just in case he got some comments here.

> 
> [I am not sure we can track today an 1:N AS->IOMMU association today in Qemu]

IIUC we can?  The address space only have a root MR, and with that after
translate() upon the root mr (per address_space_translate_iommu(), it can
even be a few rounds of nested translations) it can go into whatever MR
under it IIUC.  Different ranges can map to a different IOMMU MR logically.

> 
> [*] alpha, arm smmu, ppc, s390, virtio, and some pci bridges (pnv_phb3 and pnv_phb4)

I just worried what we need here is not a MR object but a higher level
object like the vIOMMU object.  We used to have a requirement with Scalable
IOV (SVA) on Intel.  I tried to dig a bit in my inbox, not sure whether
it's the latest status, just to show what I meant:

https://lore.kernel.org/r/20210302203827.437645-6-yi.l.liu@intel.com

Copy Yi too for that too.  From that aspect it makes more sense to me to
fetching things from either an IOMMUops or "an iommu object", rather than
relying on a specific MR (it'll also make it even harder when we can have
>1 vIOMMUs so different MR can point to different IOMMUs in the future).

I assume the two goals have similar requirement, iiuc.  If that's the case,
we'd better make sure we'll have one way to work for both.

-- 
Peter Xu



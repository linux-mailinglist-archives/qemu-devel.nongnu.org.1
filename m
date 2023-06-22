Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF373A9A6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:51:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRGM-0001hn-HY; Thu, 22 Jun 2023 16:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCRGJ-0001hU-9b
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCRGH-0000Za-LW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687467036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwzX4Mzs30RnJAAGTLXl9bOivXBTGy+p4HrdsN1kF6I=;
 b=ERfWEr/o2n5gv3nuxWvgn2TZmuP1fpMjTZwELacOSo2XcrfEAAJnO4tswxoroeFzc6rewx
 kc552YOA4OdGbDRT7ZAjHq/0FRJHOxfMAez0ZlSTePPu8H5gQkzYMhRpNHBPJ47oCXjovB
 +i5VgEYTVudiriua4V6jmosRZLMrRHQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-km7ZAZMpPcyq9hWsGwSaHQ-1; Thu, 22 Jun 2023 16:50:34 -0400
X-MC-Unique: km7ZAZMpPcyq9hWsGwSaHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-312a08e70e3so1169501f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687467033; x=1690059033;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NwzX4Mzs30RnJAAGTLXl9bOivXBTGy+p4HrdsN1kF6I=;
 b=A2eKsbbKTV2dbnmGxDtQlC1meOrhGveBnw66iQhW+OBpHskeI0tUWudWvglH7XOS8i
 HXiAr05s2UL8xQ5wd+yjZkAIuHqAIvAy+hfIkeCy0tPFFQ43mT0t3O2DV5h8dgbANm1s
 m8MeOPdrT2wEuFy1X3pAuZIrMDER8uwCOqo74PlwjhoYy3EqG3futkRHNDFGSkiDgSx6
 P0Mzd7QZWZwvo7HEZ7YxfTaxbBJNoKPpd/4reFaU0lzInEfnZxjoLVD2JjIRVfqkike7
 nkUFLkUec3VfzjZvATQr7c+SJz5B1gZwaWl8z7xxU6YtUs0xJvmCWdL27C3bt9fadykr
 rWnw==
X-Gm-Message-State: AC+VfDz/ELnK7VEqqbCyn5BGnEt86E1K21CgUGGEBIwcKJZqWxJG2kto
 1simNfCeEFf3VjIIOrlVQdYbPnq3zoeSXm63ku5CfXDEHNXL/Nd5JJAF5c7hHhdtW7ZSp0V5jyx
 bJqfDcWRXnoD8jlo=
X-Received: by 2002:adf:e585:0:b0:307:8879:6cc1 with SMTP id
 l5-20020adfe585000000b0030788796cc1mr19291184wrm.71.1687467033181; 
 Thu, 22 Jun 2023 13:50:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aQmgnRRL7y1dfc5/lL1m46qR8D4rx/UMwIwffLTW/mYHgJtGJi03/saMMXC4ou8f520bC9g==
X-Received: by 2002:adf:e585:0:b0:307:8879:6cc1 with SMTP id
 l5-20020adfe585000000b0030788796cc1mr19291156wrm.71.1687467032875; 
 Thu, 22 Jun 2023 13:50:32 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 d2-20020adff842000000b00312793cc763sm7895492wrq.15.2023.06.22.13.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 13:50:32 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:50:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 01/15] hw/pci: Refactor pci_device_iommu_address_space()
Message-ID: <20230622165003-mutt-send-email-mst@kernel.org>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-2-joao.m.martins@oracle.com>
 <ad557a25-0cca-518e-9d0f-f69f8bbd98c6@linaro.org>
 <41a452d7-5b17-d2b8-401e-5b5e7ddb5299@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41a452d7-5b17-d2b8-401e-5b5e7ddb5299@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 11:03:23AM +0100, Joao Martins wrote:
> On 30/05/2023 23:04, Philippe Mathieu-Daudé wrote:
> > Hi Joao,
> > 
> > On 30/5/23 19:59, Joao Martins wrote:
> >> Rename pci_device_iommu_address_space() into pci_device_iommu_info().
> >> In the new function return a new type PCIAddressSpace that encapsulates
> >> the AddressSpace pointer that originally was returned.
> >>
> >> The new type is added in preparation to expanding it to include the IOMMU
> >> memory region as a new field, such that we are able to fetch attributes of
> >> the vIOMMU e.g. at vfio migration setup.
> >>
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >> ---
> >>   hw/pci/pci.c         |  9 ++++++---
> >>   include/hw/pci/pci.h | 21 ++++++++++++++++++++-
> > 
> > Please consider using scripts/git.orderfile.
> > 
> Will do -- wasn't aware of that script.
> 
> >>   2 files changed, 26 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 1cc7c89036b5..ecf8a543aa77 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -2633,11 +2633,12 @@ static void pci_device_class_base_init(ObjectClass
> >> *klass, void *data)
> >>       }
> >>   }
> >>   -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> >> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev)
> >>   {
> > 
> > This function is PCI specific, ...
> > 
> >>   }
> >>     void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
> >> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >> index e6d0574a2999..9ffaf47fe2ab 100644
> >> --- a/include/hw/pci/pci.h
> >> +++ b/include/hw/pci/pci.h
> >> @@ -363,9 +363,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
> >>     void pci_device_deassert_intx(PCIDevice *dev);
> >>   +typedef struct PCIAddressSpace {
> >> +    AddressSpace *as;
> > 
> > ... but here I fail to understand what is PCI specific in this
> > structure. You are just trying to an AS with a IOMMU MR, right?
> > 
> Right. The patch is trying to better split the changes to use one function to
> return everything (via pci_device_iommu_info) with the PCIAddressSpace
> intermediate structure as retval, such that patch 3 just adds a
> IOMMUMemoryRegion* in the latter for usage with the
> pci_device_iommu_memory_region().
> 
> I've named the structure with a 'PCI' prefix, because it seemed to me that it is
> the only case (AIUI) that cares about whether a PCI has a different address
> space that the memory map.


yea keep that pls. It should be possible to figure out the header
from the name.

> >> +} PCIAddressSpace;
> >> +
> >>   typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
> >> +static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
> >> +{
> >> +    PCIAddressSpace ret = { .as = as };
> >> +
> >> +    return ret;
> >> +}
> >> +static inline AddressSpace *pci_as_to_as(PCIAddressSpace pci_as)
> >> +{
> >> +    return pci_as.as;
> >> +}
> >> +
> >> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev);
> >> +static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> >> +{
> >> +    return pci_as_to_as(pci_device_iommu_info(dev));
> >> +}
> >>   -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> >>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
> >>     pcibus_t pci_bar_address(PCIDevice *d,
> > 



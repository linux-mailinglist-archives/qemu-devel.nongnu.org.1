Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2C7BB384
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogXf-0004N1-Ag; Fri, 06 Oct 2023 04:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qogXc-0004GH-Iu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qogXR-0004ze-Rm
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696582224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVFBhoOVfGrZvdZn25pRgO05TJw3L+qsfL0ARFoUUKE=;
 b=ZdQNMNZz8dmNAmBckK0vvBx/uz4zTvvln8HomkZbKEovQxHlctP7ld+pHKEL5jAR9Gcl2L
 IB1uQyyMIHl1VJ4sFq/hcsCJfg5ainFeTQ2ExJRtbaspqM6vC8PLsPAPArBucSjxVxFzzv
 PWXFIJm3aWmUESLds3I2qs/znZgACts=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-QPwe02yaP_KjfsJc4W-A0g-1; Fri, 06 Oct 2023 04:50:23 -0400
X-MC-Unique: QPwe02yaP_KjfsJc4W-A0g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7740829f2beso220585685a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696582223; x=1697187023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVFBhoOVfGrZvdZn25pRgO05TJw3L+qsfL0ARFoUUKE=;
 b=TpdLYnKXxkbAscx2f1ZxmvGDBgwzJPNiEXkUg+zmBNfRAi7qAphkjQm/BMoL+EemV+
 +0v8G1GhCItHVt7q3y1CVyV9OQX+101JLjrkkZF6dzb6UAwmQEqWm5tNeEAXHfTrm5gJ
 UV8mnddeUe4+KdhQtL0+CbblbZ6H4moCU7lXGswlbNol6XPZrC0f17AxrBtXqmjVcU5B
 74fRfsbJDkfIhWsQItkpW6FgUXp/5vn8pmC8nX/Grn92lpsMbaCwT9Rmzz5XdaUhZ5L8
 SSt2biIr6r1YZGStUCIUAODkEZVH+f9ju43CfN+gkq3q3tPIoNBpMdrbpMTI5boyN4Vx
 UEmA==
X-Gm-Message-State: AOJu0YwHEoJzEc1eNajOOWlGIa/5pwK0Fz6oyZOLVJ/HrxkHz4i/zCK8
 +RImr+6CLf3/82iHG2Yq3JWCir8k+y8CMbFverQZfsQu6z71/maLgbbcUkfmtjMd2RisOB3Dkbq
 U8GEmqJDN1Fo9uNM=
X-Received: by 2002:a05:620a:4487:b0:775:9a54:a02b with SMTP id
 x7-20020a05620a448700b007759a54a02bmr8236325qkp.64.1696582222886; 
 Fri, 06 Oct 2023 01:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERz+U1hTKFINqrPCr5A57INKflZH56C1H7rwrAUDBz64EPwFQebjCyc+lro6ZIEBwl71uOwA==
X-Received: by 2002:a05:620a:4487:b0:775:9a54:a02b with SMTP id
 x7-20020a05620a448700b007759a54a02bmr8236310qkp.64.1696582222618; 
 Fri, 06 Oct 2023 01:50:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a05620a11b800b0076ee973b9a7sm1146377qkk.27.2023.10.06.01.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:50:22 -0700 (PDT)
Message-ID: <d09a2778-8097-b6a7-b570-7d36bf29d9d5@redhat.com>
Date: Fri, 6 Oct 2023 10:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
 <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
 <db965f35-e568-44bb-9da4-2c2888928eb8@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <db965f35-e568-44bb-9da4-2c2888928eb8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/6/23 10:38, Joao Martins wrote:
> On 02/10/2023 16:12, Cédric Le Goater wrote:
>> Hello Joao,
>>
>> On 6/22/23 23:48, Joao Martins wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Add a pci_setup_iommu_ops() that uses a newly added structure
>>> (PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
>>> that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
>>> an address space for a PCI device in vendor specific way.
>>>
>>> In preparation to expand to supplying vIOMMU attributes, add a
>>> alternate helper pci_setup_iommu_ops() to setup the PCI device IOMMU.
>>> For now the PCIIOMMUOps just defines the address_space, but it will
>>> be extended to have another callback.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> [joao: Massage commit message and subject, and make it a complementary
>>> rather than changing every single consumer of pci_setup_iommu()]
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> v1: https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>>> ---
>>>    include/hw/pci/pci.h     |  7 +++++++
>>>    include/hw/pci/pci_bus.h |  1 +
>>>    hw/pci/pci.c             | 26 +++++++++++++++++++++++---
>>>    3 files changed, 31 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index e6d0574a2999..f59aef5a329a 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *,
>>> int);
>>>    AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>>    void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>>>    +typedef struct PCIIOMMUOps PCIIOMMUOps;
>>> +struct PCIIOMMUOps {
>>> +    AddressSpace * (*get_address_space)(PCIBus *bus,
>>> +                                void *opaque, int32_t devfn);
>>> +};
>>> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void
>>> *opaque);
>>> +
>>
>> I think you should first convert all PHBs to PCIIOMMUOps to avoid all the
>> tests as below and adapt pci_setup_iommu_ops() with the new parameter.
>>
> 
> OK, that's Yi's original patch:
> 
> https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
> 
> I went with this one is that 1) it might take eons to get every single IOMMU
> maintainer ack; and 2) it would allow each IOMMU to move at its own speed
> specially as I can't test most of the other ones. essentially iterative, rather
> than invasive change? Does that make sense?

I think it is ok to make global changes to replace a function by a struct
of ops. This is not major (unless the extra indirection has a major perf
impact on some platforms). Getting acks from everyone will be difficult
since some PHBs are orphans.

C.




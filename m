Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4A7A822A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwmB-00072A-PG; Wed, 20 Sep 2023 08:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiwm6-00071A-Hi
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiwm4-0006Rn-M6
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695214667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qo8mntiskrAti9EXs8zZJnxg3/6E1c2bYUYtCT9g8rM=;
 b=RQ4soKCGL1A7vscCf/jGzeBn6+ohPMt8PUCV8Ryl+x43cmMwsLYJC25gjWpHESS769z8BF
 is1gDTzbb/pb3eKHbYgrnL0zoqPTY+LnCaJ0xz6aFGRxYWMPDR9pIxKBIGN3ilD+K5ox47
 uZkzcvj3T+2ytL0y4Sk8GhoQ1SbEzVI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-KvkghxhJOFCMWW2Dmu4mqg-1; Wed, 20 Sep 2023 08:57:46 -0400
X-MC-Unique: KvkghxhJOFCMWW2Dmu4mqg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63d0c38e986so66866506d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 05:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695214665; x=1695819465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qo8mntiskrAti9EXs8zZJnxg3/6E1c2bYUYtCT9g8rM=;
 b=RbxKaSsWgOZUgYfezlI0S1afYJubP4fpWQEklSdk4MgR6PY/65JvfGPNUpzZbdxZYY
 J3QEg1wgmTHg3Pec2BwEUDiQz/j2kj2MAA64oe6w9xc4wTIY+21fwdcjbZSumcNL2/M4
 aJdKYlcmG6zlV1xrYLr2fEJLs8UvjH5LKYujh1upAOw5wD6C2wI18My5VFHA5jwRATRx
 NGJQj0qMT0iAz12p3n903eGKlLD+hSzpZL/AE39N2eEk0mPftYanJmzjPpQRK0jeHgp2
 fvZfGs3rBIDyGclVMNkOQJaymyRnMcNjnUbCm2tv53T+ppG15zZHOhgGEGBzm7RJo7wV
 L2CQ==
X-Gm-Message-State: AOJu0YyJLPveWkp52cboUQREFoeIMpCBMvGEJ46Tebw7CLyOixRPq9ZQ
 HQaMWwlmsJVLpBgZvmOdqhggxJcyXtPWj1cfMi297TqOFKS7JqkBjyfSEauqN/yEibletZiW+Ev
 GNmy6Y2kVA3Yr0UQ=
X-Received: by 2002:ad4:530c:0:b0:655:de6d:f0be with SMTP id
 y12-20020ad4530c000000b00655de6df0bemr2271893qvr.55.1695214665509; 
 Wed, 20 Sep 2023 05:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExGVkQhDjYRDyVMs9+HOIEaY32ZG6MSeg/prVSL3M0DmljZBy/MVHSFv609e3NDtCz8xdiCw==
X-Received: by 2002:ad4:530c:0:b0:655:de6d:f0be with SMTP id
 y12-20020ad4530c000000b00655de6df0bemr2271880qvr.55.1695214665253; 
 Wed, 20 Sep 2023 05:57:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 e12-20020ad4418c000000b00647386a3234sm4863482qvp.85.2023.09.20.05.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 05:57:44 -0700 (PDT)
Message-ID: <4df735b7-addb-cc02-05dc-360752d5ae35@redhat.com>
Date: Wed, 20 Sep 2023 14:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 13/22] vfio: Add base container
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
 <SJ0PR11MB67449058E09E80EB7891381F92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67449058E09E80EB7891381F92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/20/23 10:48, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Wednesday, September 20, 2023 1:24 AM
>> Subject: Re: [PATCH v1 13/22] vfio: Add base container
>>
>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Abstract the VFIOContainer to be a base object. It is supposed to be
>>> embedded by legacy VFIO container and later on, into the new iommufd
>>> based container.
>>>
>>> The base container implements generic code such as code related to
>>> memory_listener and address space management. The VFIOContainerOps
>>> implements callbacks that depend on the kernel user space being used.
>>>
>>> 'common.c' and vfio device code only manipulates the base container with
>>> wrapper functions that calls the functions defined in VFIOContainerOpsClass.
>>> Existing 'container.c' code is converted to implement the legacy container
>>> ops functions.
>>>
>>> Below is the base container. It's named as VFIOContainer, old VFIOContainer
>>> is replaced with VFIOLegacyContainer.
>>
>> Usualy, we introduce the new interface solely, port the current models
>> on top of the new interface, wire the new models in the current
>> implementation and remove the old implementation. Then, we can start
>> adding extensions to support other implementations.
> 
> Not sure if I understand your point correctly. Do you mean to introduce
> a new type for the base container as below:
> 
> static const TypeInfo vfio_container_info = {
>      .parent             = TYPE_OBJECT,
>      .name               = TYPE_VFIO_CONTAINER,
>      .class_size         = sizeof(VFIOContainerClass),
>      .instance_size      = sizeof(VFIOContainer),
>      .abstract           = true,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_VFIO_IOMMU_BACKEND_OPS },
>          { }
>      }
> };
> 
> and a new interface as below:
> 
> static const TypeInfo nvram_info = {
>      .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
>      .parent = TYPE_INTERFACE,
>      .class_size = sizeof(VFIOIOMMUBackendOpsClass),
> };
> 
> struct VFIOIOMMUBackendOpsClass {
>      InterfaceClass parent;
>      VFIODevice *(*dev_iter_next)(VFIOContainer *container, VFIODevice *curr);
>      int (*dma_map)(VFIOContainer *container,
>      ......
> };
> 
> and legacy container on top of TYPE_VFIO_CONTAINER?
> 
> static const TypeInfo vfio_legacy_container_info = {
>      .parent = TYPE_VFIO_CONTAINER,
>      .name = TYPE_VFIO_LEGACY_CONTAINER,
>      .class_init = vfio_legacy_container_class_init,
> };
> 
> This object style is rejected early in RFCv1.
> See https://lore.kernel.org/kvm/20220414104710.28534-8-yi.l.liu@intel.com/

ouch. this is long ago and I was not aware :/ Bare with me, I will
probably ask the same questions. Nevertheless, we could improve the
cover and the flow of changes in the patchset to help the reader.

>> spapr should be taken care of separatly following the principle above.
>> With my PPC hat, I would not even read such a massive change, too risky
>> for the subsystem. This path will need (much) further splitting to be
>> understandable and acceptable.
> 
> I'll digging into this and try to split it. 

I know I am asking for a lot of work. Thanks for that.

> Meanwhile, there are many changes
> just renaming the parameter or function name for code readability.
> For example:
> 
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> -                   ram_addr_t size, IOMMUTLBEntry *iotlb)
> +static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
> +                          ram_addr_t size, IOMMUTLBEntry *iotlb)
> 
> -        ret = vfio_get_dirty_bitmap(container, iova, size,
> +        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> 
> Let me know if you think such changes are unnecessary which could reduce
> this patch largely.

Cleanups, renames, some code reshuffling, anything preparing ground for
the new abstraction is good to have first and can be merged very quickly
if there are no functional changes. It reduces the overall patchset and
ease the coming reviews.

You can send such series independently. That's fine.

> 
>>
>> Also, please include the .h file first, it helps in reading.
> 
> Do you mean to put struct declaration earlier in patch description?

Just add to your .gitconfig :

[diff]
	orderFile = /path/to/qemu/scripts/git.orderfile

It should be enough

>> Have you considered using an InterfaceClass ?
> 
> See above, with object style rejected, it looks hard to use InterfaceClass.

I am not convinced by the QOM approach. I will dig in the past arguments
and let's see what we come with.

Thanks,

C.


> Thanks
> Zhenzhong
> 



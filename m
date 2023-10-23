Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510A7D3ABC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwrh-0000Cs-2C; Mon, 23 Oct 2023 11:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1quwrf-0000CN-8X
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1quwrd-0001pN-3M
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698074940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OxU5WpCyp9E+sJFAdFbp6yzU33pPCmUKfveI2DD6yY=;
 b=RCGifh9RqvVCh7LlwHg1P+NOSfhR+5OxaERbkXfFzOIOajv7di1OscNnjkTk5kefcrJIyF
 y8WpU54CFRxjwWI7ZMPbkTTZ12YHRpSjuoZgM6T/R2KtkTB/6x7148DpBtXEhejCXXJe5f
 Lm8fHhm5UAj/fFeX2qpZ2dgBS4Ng1lo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-XTCKNnYrM0ODHEFE4vv0qw-1; Mon, 23 Oct 2023 11:28:53 -0400
X-MC-Unique: XTCKNnYrM0ODHEFE4vv0qw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65aff02d602so51449106d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698074933; x=1698679733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8OxU5WpCyp9E+sJFAdFbp6yzU33pPCmUKfveI2DD6yY=;
 b=KrrLDWpuaUjUxU0KQjGSKfoupy4I7bCqAa/JUdvI9TZmm405w5VLvqPIrthDh9YZe4
 2Pi7R1A/pdsrbPMUlKT3bOEj86keclSpEk3IGjZaQbEMrnIrQJeRz8hVSrcVRRLqwtoE
 suNTM59rRoj+KQ+EWsHWdkO4zYNJfE3sZbsxestZHfXykV3Ede7LgnwkcIV5rYGagdw7
 bd8c5Uh6LIFC9dXQJrw4nCsGJ9W0Of2Se/jsfXmQ1Tc4mnkpNWipxbOEnMMMjsL5GbwW
 /g+fxWWPTmPwgASrMtupJQpONhBHu90mnfURij2Dug1HGlgVwHhIdpM59HNEmgCTK4AP
 Wyzg==
X-Gm-Message-State: AOJu0Ywy3fvlSWLgMrtV8AVsTmdgqClRtYR6TCCh1zNEKQy/duB7Dt6q
 zXZoA1JDzjxhsPlxsDEaiGy3glciUmFeeiZlM828Wpfum2uSy/3SzLvXFP/VFsIRBlh4/x80PBD
 EHmsevEFgAK5EjC8=
X-Received: by 2002:a05:6214:404:b0:66d:9d71:9b28 with SMTP id
 z4-20020a056214040400b0066d9d719b28mr10458096qvx.11.1698074932871; 
 Mon, 23 Oct 2023 08:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFagqY8dBXiM9Lc0um9yjdYisLc3v/R5+VTsVGPElKbbonNBgrfA3AIIFd3xv/q6fRnbWrlSg==
X-Received: by 2002:a05:6214:404:b0:66d:9d71:9b28 with SMTP id
 z4-20020a056214040400b0066d9d719b28mr10458076qvx.11.1698074932608; 
 Mon, 23 Oct 2023 08:28:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 f7-20020ad45587000000b0066d1b4ce863sm2944538qvx.31.2023.10.23.08.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:28:52 -0700 (PDT)
Message-ID: <759053f1-995b-4238-b0be-bace84a1249c@redhat.com>
Date: Mon, 23 Oct 2023 17:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Content-Language: en-US
To: eric.auger@redhat.com, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
 <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
 <PH7PR11MB67226A6A32A4655138CE1C8A92D4A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <cf232093-a59c-49ef-9271-bb691860215b@redhat.com>
 <PH7PR11MB6722D6969CD287A86CFC469792DBA@PH7PR11MB6722.namprd11.prod.outlook.com>
 <3573353d-5153-2678-e121-33cf20798aa6@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <3573353d-5153-2678-e121-33cf20798aa6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/20/23 10:19, Eric Auger wrote:
> Hi,
> On 10/20/23 07:48, Duan, Zhenzhong wrote:
>> Hi Cédric,
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: Thursday, October 19, 2023 8:18 PM
>>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer and
>>> targetted interface
>>>
>>> On 10/19/23 04:29, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>> Sent: Wednesday, October 18, 2023 4:04 PM
>>>>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
>>> and
>>>>> targetted interface
>>>>>
>>>>> On 10/18/23 04:41, Duan, Zhenzhong wrote:
>>>>>> Hi Cédric,
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>> Sent: Tuesday, October 17, 2023 11:51 PM
>>>>>>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
>>>>> and
>>>>>>> targetted interface
>>>>>>>
>>>>>>> On 10/16/23 10:31, Zhenzhong Duan wrote:
>>>>>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>>>>>
>>>>>>>> Introduce a dumb VFIOContainer base object and its targetted interface.
>>>>>>>> This is willingly not a QOM object because we don't want it to be
>>>>>>>> visible from the user interface.  The VFIOContainer will be smoothly
>>>>>>>> populated in subsequent patches as well as interfaces.
>>>>>>>>
>>>>>>>> No fucntional change intended.
>>>>>>>>
>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>> ---
>>>>>>>>      include/hw/vfio/vfio-common.h         |  8 +--
>>>>>>>>      include/hw/vfio/vfio-container-base.h | 82
>>>>> +++++++++++++++++++++++++++
>>>>>>>>      2 files changed, 84 insertions(+), 6 deletions(-)
>>>>>>>>      create mode 100644 include/hw/vfio/vfio-container-base.h
>>>>>>>>
>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>>>> common.h
>>>>>>>> index 34648e518e..9651cf921c 100644
>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>>      #include <linux/vfio.h>
>>>>>>>>      #endif
>>>>>>>>      #include "sysemu/sysemu.h"
>>>>>>>> +#include "hw/vfio/vfio-container-base.h"
>>>>>>>>
>>>>>>>>      #define VFIO_MSG_PREFIX "vfio %s: "
>>>>>>>>
>>>>>>>> @@ -81,6 +82,7 @@ typedef struct VFIOAddressSpace {
>>>>>>>>      struct VFIOGroup;
>>>>>>>>
>>>>>>>>      typedef struct VFIOLegacyContainer {
>>>>>>>> +    VFIOContainer bcontainer;
>>>>>>> That's the parent class, right ?
>>>>>> Right.
>>>>>>
>>>>>>>>          VFIOAddressSpace *space;
>>>>>>>>          int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>>>>>>          MemoryListener listener;
>>>>>>>> @@ -200,12 +202,6 @@ typedef struct VFIODisplay {
>>>>>>>>          } dmabuf;
>>>>>>>>      } VFIODisplay;
>>>>>>>>
>>>>>>>> -typedef struct {
>>>>>>>> -    unsigned long *bitmap;
>>>>>>>> -    hwaddr size;
>>>>>>>> -    hwaddr pages;
>>>>>>>> -} VFIOBitmap;
>>>>>>>> -
>>>>>>>>      void vfio_host_win_add(VFIOLegacyContainer *container,
>>>>>>>>                             hwaddr min_iova, hwaddr max_iova,
>>>>>>>>                             uint64_t iova_pgsizes);
>>>>>>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>>>>>>> container-base.h
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000000..afc8543d22
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/include/hw/vfio/vfio-container-base.h
>>>>>>>> @@ -0,0 +1,82 @@
>>>>>>>> +/*
>>>>>>>> + * VFIO BASE CONTAINER
>>>>>>>> + *
>>>>>>>> + * Copyright (C) 2023 Intel Corporation.
>>>>>>>> + * Copyright Red Hat, Inc. 2023
>>>>>>>> + *
>>>>>>>> + * Authors: Yi Liu <yi.l.liu@intel.com>
>>>>>>>> + *          Eric Auger <eric.auger@redhat.com>
>>>>>>>> + *
>>>>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>>>>> + * it under the terms of the GNU General Public License as published by
>>>>>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>>>>>> + * (at your option) any later version.
>>>>>>>> +
>>>>>>>> + * This program is distributed in the hope that it will be useful,
>>>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>>>> + * GNU General Public License for more details.
>>>>>>>> +
>>>>>>>> + * You should have received a copy of the GNU General Public License
>>> along
>>>>>>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
>>>>>>>> +#define HW_VFIO_VFIO_BASE_CONTAINER_H
>>>>>>>> +
>>>>>>>> +#include "exec/memory.h"
>>>>>>>> +#ifndef CONFIG_USER_ONLY
>>>>>>>> +#include "exec/hwaddr.h"
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>> +typedef struct VFIOContainer VFIOContainer;
>>>>>>>> +typedef struct VFIODevice VFIODevice;
>>>>>>>> +typedef struct VFIOIOMMUBackendOpsClass
>>> VFIOIOMMUBackendOpsClass;
>>>>>>>> +
>>>>>>>> +typedef struct {
>>>>>>>> +    unsigned long *bitmap;
>>>>>>>> +    hwaddr size;
>>>>>>>> +    hwaddr pages;
>>>>>>>> +} VFIOBitmap;
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * This is the base object for vfio container backends
>>>>>>>> + */
>>>>>>>> +struct VFIOContainer {
>>>>>>>> +    VFIOIOMMUBackendOpsClass *ops;
>>>>>>> This is unexpected.
>>>>>>>
>>>>>>> I thought that an abstract QOM model for VFIOContainer was going
>>>>>>> to be introduced with a VFIOContainerClass with the ops below
>>>>>>> (VFIOIOMMUBackendOpsClass).
>>>>>>>
>>>>>>> Then, we would call :
>>>>>>>
>>>>>>>       VFIOContainerClass *vcc = VFIO_CONTAINER_GET_CLASS(container);
>>>>>>>
>>>>>>> to get the specific implementation for the current container.
>>>>>>>
>>>>>>> I don't understand the VFIOIOMMUBackendOpsClass pointer and
>>>>>>> TYPE_VFIO_IOMMU_BACKEND_OPS. It seems redundant.
>>>>>> The original implementation was abstract QOM model. But it wasn't
>>> accepted,
>>>>>> see https://lore.kernel.org/all/YmuFv2s5TPuw7K%2Fu@yekko/ for details.
>>>>> I see the idea was challenged, not rejected. I need to dig in further and this
>>>>> will take time.
>>>> Thanks for help looking into it.
>>>>
>>>> +David, Hi David, I'm digging into your concern of using QOM to abstract base
>>>> container and legacy VFIOContainer:
>>>> "The QOM class of things is visible to the user/config layer via QMP (and
>>> sometimes command line).
>>>> It doesn't necessarily correspond to guest visible differences, but it often does."
>>>>
>>>> AIUI, while it's true when the QOM type includes TYPE_USER_CREATABLE
>>> interface,
>>>> otherwise, user can't create an object of this type. Only difference is user will
>>> see
>>>> "object type '%s' isn't supported by object-add" instead of "invalid object
>>> type: %s".
>>>> Is your expectation to not permit user to create this object or only want user
>>>> to see "invalid object type: %s".
>>>> If you mean the first, then I think QOM could be suitable if we don't include
>>>> TYPE_USER_CREATABLE interface?
>>> I was imagining some kind of QOM hierarchy under the vfio device
>>> with various QOM interfaces (similar to the ops) to define the
>>> possible IOMMU backends. The fact that we use the IOMMUFD object
>> >from the command line made it more plausible. I might be mistaking.
>>
>> Got your point.
>> This way we introduce a new QOM type "vfio-pci-iommufd" for iommufd support,
>> and vfio-pci keep same for legacy backend, e.g:
>>
>> #qemu  -object iommufd,id=iommufd0 \
>>                -device vfio-pci-iommufd,iommufd=iommufd0,id=vfio0... \
>>               -device vfio-pci,id=vfio1...
> you would need to do that for all types for vfio devices, ap, ccw,
> platform. Looks heavy to me. Why would we need to use a different
> vfio-pci-* device while we could switch the iommu backend according to
> the "iommufd" prop presence. The initial discussion was about QOMyfying
> the container instead.

yes.

I took a closer look at the first part which adds the backend ops,
including patch 19 adding the iommufd backend, not saying that I have
identified all the dark corners.

A QOM-like design would have introduced a VFIOLegacyContainer,
inheriting from VFIOContainer (same for VFIOIOMMUFDContainer) with a
VFIOContainerClass to implement the specific backend ops.
VFIOspaprContainer would have made sense also.

But QOM doesn't seem well adapted for the current needs. So let's try
a simpler approach. It seems that VFIOIOMMUBackendOpsClass is
useless. IMO, it could be a callbacks structure like we have for
memory regions initialized with vfio_container_init(). This would
remove some noise around the QOM typeinfo definitions.

'struct vfio_iommu_ops' reads/sounds like a good name.

Can we try that in a v3 ? It should not be such an earthquake.

spapr has some singularities which would be good to isolate in a
vfio_iommu_spapr_ops to remove all the VFIO_SPAPR_TCE_*_IOMMU code in
container.c. vfio_legacy_{add,del}_section_window are SPAPR specific.

FYI, I did some adjustements bc of the recent introduction of iova_ranges
in my branch :

  https://github.com/legoater/qemu/commits/vfio-8.2

Thanks,

C.




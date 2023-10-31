Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9557DC7C5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 08:58:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxjdM-00063U-HB; Tue, 31 Oct 2023 03:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxjdJ-00063C-Jy
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxjdH-00038y-K6
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698739070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9bypwdFdwSGM9YLNHVOE2DtnTI9Q9r52HV8ShWKERQ=;
 b=Ud+3giYSihxTa8GZolgIk21+mAZYrFGyMeF9wIRHsmwjJKLnAuUQ7fcwkanmGPk0DvWVzv
 mY9za6CB4tIaJYwfwYaKAGCFyzWRD1Nn2dH/gEQVloDUHFE9b8TgG5khC2Nf+1GlF+B7gS
 4VR24xy2G4ZveZSTGxaxjhKnTSBpO4Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-K5qcikDoOyKD4dd9fWPDLA-1; Tue, 31 Oct 2023 03:57:48 -0400
X-MC-Unique: K5qcikDoOyKD4dd9fWPDLA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cb5ff64b0so65417321cf.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 00:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698739068; x=1699343868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G9bypwdFdwSGM9YLNHVOE2DtnTI9Q9r52HV8ShWKERQ=;
 b=oeRwpiZTkxQl/O+s8k5k+qQnWNehrBzf1bigvel2vKOyX7OPC5qQQfzYgCOfTdShJp
 EtCQIjnylRt9kTm8vh9XEciEPvGRLfKFBHM23+0+gMjDyOVHNj/52jRr7lx59gvydNsY
 mXcGCto4PXUBNLayyq5z2WJrkRWVd8ZRNf9fJ2j88Y3J/1P9riCHWnkvkBpMmDEtclbx
 u0PhbRtXjkLhuFN/vlNCOfqXtv2/wQY82kD/iana9oGMRVJ3qGBP5SuMc87gSOlbGLNr
 wj+NSvx1aVUeuPqwV5XHkKza1YcI8kpADZ8rxRD815jOV9uFy77gUZkYs7buwx9Ad050
 Lojg==
X-Gm-Message-State: AOJu0YxEw/ooX8ud18jT/zgyTkrFagbYkxlN8uo+tC1om/tKZEWugexP
 8OfS6UIQEkFSbyVzHq7qaNdX1VsNVzqFUgYxg/InI4WrhVGMnJ2vPnzJYrn98OqY/tLGiDk8tSV
 3sZyh4Kj8Mn66gio=
X-Received: by 2002:ac8:5a92:0:b0:41c:b5d1:e2a with SMTP id
 c18-20020ac85a92000000b0041cb5d10e2amr16070021qtc.25.1698739068405; 
 Tue, 31 Oct 2023 00:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyVRwUNxysVllOg5HHQaTeUh0k/cEOeu3JR1cCmXnWBsRzy3pVqakQiBXOIxtdrK1pVbDCTg==
X-Received: by 2002:ac8:5a92:0:b0:41c:b5d1:e2a with SMTP id
 c18-20020ac85a92000000b0041cb5d10e2amr16070011qtc.25.1698739068078; 
 Tue, 31 Oct 2023 00:57:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 h19-20020ac87453000000b0041aff9339a2sm299874qtr.22.2023.10.31.00.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 00:57:47 -0700 (PDT)
Message-ID: <130d7bdd-e827-443b-ac9a-38268e720bc0@redhat.com>
Date: Tue, 31 Oct 2023 08:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/37] vfio: Introduce base object for VFIOContainer
 and targetted interface
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
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-7-zhenzhong.duan@intel.com>
 <77cb4375-beb8-4d6e-ba9f-304d357e7e67@redhat.com>
 <SJ0PR11MB6744416314994A2AAA69D2B092A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744416314994A2AAA69D2B092A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On 10/30/23 03:40, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, October 27, 2023 10:03 PM
>> Subject: Re: [PATCH v3 06/37] vfio: Introduce base object for VFIOContainer and
>> targetted interface
>>
>> On 10/26/23 12:30, Zhenzhong Duan wrote:
>>> Introduce a dumb VFIOContainer base object and its targetted interface.
>>
>> targeted
> 
> Will fix.
> 
>>
>>
>>> This is willingly not a QOM object because we don't want it to be
>>> visible from the user interface.  The VFIOContainer will be smoothly
>>> populated in subsequent patches as well as interfaces.
>>>
>>> No fucntional change intended.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h         |  8 +---
>>>    include/hw/vfio/vfio-container-base.h | 64 +++++++++++++++++++++++++++
>>>    2 files changed, 66 insertions(+), 6 deletions(-)
>>>    create mode 100644 include/hw/vfio/vfio-container-base.h
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index b9c7a7e588..d8f293cb57 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -30,6 +30,7 @@
>>>    #include <linux/vfio.h>
>>>    #endif
>>>    #include "sysemu/sysemu.h"
>>> +#include "hw/vfio/vfio-container-base.h"
>>>
>>>    #define VFIO_MSG_PREFIX "vfio %s: "
>>>
>>> @@ -81,6 +82,7 @@ typedef struct VFIOAddressSpace {
>>>    struct VFIOGroup;
>>>
>>>    typedef struct VFIOContainer {
>>> +    VFIOContainerBase bcontainer;
>>>        VFIOAddressSpace *space;
>>>        int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>        MemoryListener listener;
>>> @@ -201,12 +203,6 @@ typedef struct VFIODisplay {
>>>        } dmabuf;
>>>    } VFIODisplay;
>>>
>>> -typedef struct {
>>> -    unsigned long *bitmap;
>>> -    hwaddr size;
>>> -    hwaddr pages;
>>> -} VFIOBitmap;
>>> -
>>>    VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>>>    void vfio_put_address_space(VFIOAddressSpace *space);
>>>    bool vfio_devices_all_running_and_saving(VFIOContainer *container);
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> new file mode 100644
>>> index 0000000000..5becbd51a7
>>> --- /dev/null
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -0,0 +1,64 @@
>>> +/*
>>> + * VFIO BASE CONTAINER
>>> + *
>>> + * Copyright (C) 2023 Intel Corporation.
>>> + * Copyright Red Hat, Inc. 2023
>>> + *
>>> + * Authors: Yi Liu <yi.l.liu@intel.com>
>>> + *          Eric Auger <eric.auger@redhat.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> +
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> +
>>> + * You should have received a copy of the GNU General Public License along
>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>
>> This should be enough :
>>
>>    SPDX-License-Identifier: GPL-2.0-or-later
> 
> Will do.
> 
>>
>>> + */
>>> +
>>> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
>>> +#define HW_VFIO_VFIO_BASE_CONTAINER_H
>>
>> HW_VFIO_VFIO_CONTAINER_BASE_H
>>
>>> +
>>> +#include "exec/memory.h"
>>> +#ifndef CONFIG_USER_ONLY
>>> +#include "exec/hwaddr.h"
>>> +#endif
>>
>> including "exec/memory.h" should be enough.
> 
> Will do.
> 
>>
>>
>>> +
>>> +typedef struct VFIODevice VFIODevice;
>>> +typedef struct VFIOIOMMUOps VFIOIOMMUOps;
>>> +
>>> +typedef struct {
>>> +    unsigned long *bitmap;
>>> +    hwaddr size;
>>> +    hwaddr pages;
>>> +} VFIOBitmap;
>>> +
>>> +/*
>>> + * This is the base object for vfio container backends
>>> + */
>>> +typedef struct VFIOContainerBase {
>>> +    const VFIOIOMMUOps *ops;
>>> +} VFIOContainerBase;
>>> +
>>> +struct VFIOIOMMUOps {
>>> +    /* basic feature */
>>> +    int (*dma_map)(VFIOContainerBase *bcontainer,
>>> +                   hwaddr iova, ram_addr_t size,
>>> +                   void *vaddr, bool readonly);
>>> +    int (*dma_unmap)(VFIOContainerBase *bcontainer,
>>> +                     hwaddr iova, ram_addr_t size,
>>> +                     IOMMUTLBEntry *iotlb);
>>
>> Could the VFIOContainerBase *parameter be const ?
> 
> Yes, VFIOContainerBase is not changed by dma_unmap and other
> functions dma_unmap calls. I tried and found making it const here
> would impact all functions it called with same parameter be const
> in following patches which looks unrelated to the patch itself
> to avoid compile error.
> 
> E.g. below functions are impacted,
> vfio_devices_all_running_and_mig_active
> vfio_devices_all_device_dirty_tracking
> vfio_devices_query_dirty_bitmap
> vfio_container_query_dirty_bitmap
> vfio_legacy_query_dirty_bitmap>
> To make following patches cleaner to review, I would like to keep
> current code except you or others have a strong opinion.
> Another choice I can think of is to add const to all impact functions
> in a separate patch.

It would be good to have, for later.

On a related topic, I find the code difficult to read because it is
complex, of course, and dealing with a thick layer of software constructs
but also because it lacks a consistent naming scheme in the different
submodules. For instance, iommufd.c has various routine prefixes for
local routines. This is quite confusing. Same for :

   hw/vfio/common.c
   hw/vfio/helpers.c
   hw/vfio/container.c
   hw/vfio/container-base.c

This is not necessarily introduced by the changes of this series.
Something to improve for sure though.

Thanks,

C.


> 
>>
>>> +    int (*attach_device)(char *name, VFIODevice *vbasedev,
>>
>> cont char *name  ?
> 
> Yes, will fix.
> 
> Thanks
> Zhenzhong
> 
>>
>> The rest looks good to me.
>>
>> Thanks
>>
>> C.
>>
>>
>>> +                         AddressSpace *as, Error **errp);
>>> +    void (*detach_device)(VFIODevice *vbasedev);
>>> +    /* migration feature */
>>> +    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
>>> +    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap
>> *vbmap,
>>> +                              hwaddr iova, hwaddr size);
>>> +};
>>> +#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088677CD5FB
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1Xu-0006U0-HT; Wed, 18 Oct 2023 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qt1Xt-0006Nq-6x
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qt1Xr-00081k-7P
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697616286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+L48ny0SGnZYU6oZm0ujNlE9NbmrMU+iPsIok1fm0vw=;
 b=QAQj1Ys+f2f6/Pbbgp1QFE8y5goqBQ29NetKHzlAjZC9ZcKObvTy6P7lfXm88CWG+RcPc2
 WZ9IZLKFEUoCSYV1FB/MmLnFq5bpNT5bwrTze5UmT7MqFxfPz38Sph6dBCzreUr03hKVF9
 f1Gt5M478n3e1/oHEcQE1lSHl1HzlE0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-4HmGfWgAPcODF6RDTN67QA-1; Wed, 18 Oct 2023 04:04:34 -0400
X-MC-Unique: 4HmGfWgAPcODF6RDTN67QA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7788fa5f1b0so109420785a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697616273; x=1698221073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+L48ny0SGnZYU6oZm0ujNlE9NbmrMU+iPsIok1fm0vw=;
 b=IUAXZZRXbEHdwO8Sar+/52D5S3DhkUoOADu+srNfe9Xgz2eUop6n6RjQ1ltDzWOsL5
 kka5RMd3aU/D3cxd3mui21E9gKrdgdEvnVXs1kGeCS9mhkrWW/hHI/tnZtG0cApiOt89
 rJqSKH+tZCgzhaiViYD5vqS6LJMN42c6ozo89ltFNU1WQGjWN9KCDxsUroJvzv0HAPnt
 AcT+T71rC/YxODL+IBcWJHpe7WojXxg+kSMwM1S4CDcAr74bBjpL2/OSWgIh92xsbE+G
 f0pC5U5FU3MaciF4L1+zr8tGVCDwAwH1RAMzlKPAvjpQRomL6T/Bq5UW6ieEPhtSVj/a
 WXJA==
X-Gm-Message-State: AOJu0YxJ4s3gp6TetLwLlAbn2FIaum3fsyPEScwDjbTiDJSweidbK5TV
 H4XitKp0eKQwcBMOn3fiVGCylvYlZqIhaZUewG3/V/9rLgxB5x5jkJZzb+lUf9c3hztVOyl6JsK
 8jBlQKEmQVaYL84o=
X-Received: by 2002:a05:620a:4692:b0:777:4519:4d80 with SMTP id
 bq18-20020a05620a469200b0077745194d80mr5236446qkb.0.1697616273809; 
 Wed, 18 Oct 2023 01:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEPkO2s7j06T04U1L4/zkpHGEnVXSL6MLOf5cyEOLf0iVQrq0E015fNhWDht7GanqKLXpmDQ==
X-Received: by 2002:a05:620a:4692:b0:777:4519:4d80 with SMTP id
 bq18-20020a05620a469200b0077745194d80mr5236427qkb.0.1697616273553; 
 Wed, 18 Oct 2023 01:04:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05620a451000b0077423f849c3sm1300465qkp.24.2023.10.18.01.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 01:04:33 -0700 (PDT)
Message-ID: <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
Date: Wed, 18 Oct 2023 10:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
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
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
 <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/18/23 04:41, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, October 17, 2023 11:51 PM
>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer and
>> targetted interface
>>
>> On 10/16/23 10:31, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Introduce a dumb VFIOContainer base object and its targetted interface.
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
>>>    include/hw/vfio/vfio-common.h         |  8 +--
>>>    include/hw/vfio/vfio-container-base.h | 82 +++++++++++++++++++++++++++
>>>    2 files changed, 84 insertions(+), 6 deletions(-)
>>>    create mode 100644 include/hw/vfio/vfio-container-base.h
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 34648e518e..9651cf921c 100644
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
>>>    typedef struct VFIOLegacyContainer {
>>> +    VFIOContainer bcontainer;
>>
>> That's the parent class, right ?
> 
> Right.
> 
>>
>>>        VFIOAddressSpace *space;
>>>        int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>        MemoryListener listener;
>>> @@ -200,12 +202,6 @@ typedef struct VFIODisplay {
>>>        } dmabuf;
>>>    } VFIODisplay;
>>>
>>> -typedef struct {
>>> -    unsigned long *bitmap;
>>> -    hwaddr size;
>>> -    hwaddr pages;
>>> -} VFIOBitmap;
>>> -
>>>    void vfio_host_win_add(VFIOLegacyContainer *container,
>>>                           hwaddr min_iova, hwaddr max_iova,
>>>                           uint64_t iova_pgsizes);
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> new file mode 100644
>>> index 0000000000..afc8543d22
>>> --- /dev/null
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -0,0 +1,82 @@
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
>>> + */
>>> +
>>> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
>>> +#define HW_VFIO_VFIO_BASE_CONTAINER_H
>>> +
>>> +#include "exec/memory.h"
>>> +#ifndef CONFIG_USER_ONLY
>>> +#include "exec/hwaddr.h"
>>> +#endif
>>> +
>>> +typedef struct VFIOContainer VFIOContainer;
>>> +typedef struct VFIODevice VFIODevice;
>>> +typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
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
>>> +struct VFIOContainer {
>>> +    VFIOIOMMUBackendOpsClass *ops;
>>
>> This is unexpected.
>>
>> I thought that an abstract QOM model for VFIOContainer was going
>> to be introduced with a VFIOContainerClass with the ops below
>> (VFIOIOMMUBackendOpsClass).
>>
>> Then, we would call :
>>
>>     VFIOContainerClass *vcc = VFIO_CONTAINER_GET_CLASS(container);
>>
>> to get the specific implementation for the current container.
>>
>> I don't understand the VFIOIOMMUBackendOpsClass pointer and
>> TYPE_VFIO_IOMMU_BACKEND_OPS. It seems redundant.
> 
> The original implementation was abstract QOM model. But it wasn't accepted,
> see https://lore.kernel.org/all/YmuFv2s5TPuw7K%2Fu@yekko/ for details.

I see the idea was challenged, not rejected. I need to dig in further and this
will take time.

Thanks,

C.



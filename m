Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9179840E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWqm-0005VR-G1; Fri, 08 Sep 2023 04:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeWqk-0005VC-FL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeWqh-0000y4-Oy
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694161698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYfgp4t8mI4cWgvxiYQlIMipvu1fpQbVfsIumSKmyoc=;
 b=czpqlP5gTtQMb9dfhHJ4BueKlVnjOj3L2CZ61zHQpYYI7KjdU/sVExgzxmoV/90HEbB7Zy
 2w+hfkH/eXI6X/B1Ejoe6GQxkEp7D7gCpBaHhRxScrZjEo3bJB89bqJ3VnT8KyS0GcnCRb
 JJ04ibqxFVOWzW86U4gV3Dqx94d2bQ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-zPjOTWfwPBufGVZq8FdmJQ-1; Fri, 08 Sep 2023 04:28:16 -0400
X-MC-Unique: zPjOTWfwPBufGVZq8FdmJQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f49c34d1fso1256964f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694161695; x=1694766495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYfgp4t8mI4cWgvxiYQlIMipvu1fpQbVfsIumSKmyoc=;
 b=bXXjJop5ONxb6CvKder73raGbin8hbqaIwJEORhyBUdDy1JQpq8Fh8IjA+Ajj/Jgc0
 bt6st6d5qTPqIwJLEPhi8nt1JeUBn6bmb8JA7EVWr+0TFt0OqKR3dBkjwFfnfjJkX7Yp
 mnn+SOaOcLABKua166sKhXyRuA3idb+72KSoQ95RiQlf8NFHi7Zz156IgxFRhaCGmtVv
 BCp96xbY9QQWMXEgHk/hx7dlILOSe3pSCYfY7tm0QA9Wqc4ShiPONhbvjbVTqEFy4RCY
 PHX6fXh6rRLOHPKnXf909fnccuG9a4m9bZcA+c452FG36YXiOg6L2/EA/t78vhydw1/0
 zS9g==
X-Gm-Message-State: AOJu0YxwY1krP3D6PxnkhQX1GYleRT8ICPT+XNxqrsMab5aUeCp90+q/
 bj7HeZXoRjZSxqOM8Q/zr3GOtjiL6w5rAV8AzYz3NBeVeKJux/RIGcT1fuRbmbGZx42yV5GOFpf
 D6sfINTSwZMfm8ABkBAvhLHM=
X-Received: by 2002:a5d:4ccf:0:b0:318:8b5:4159 with SMTP id
 c15-20020a5d4ccf000000b0031808b54159mr1520639wrt.24.1694161695334; 
 Fri, 08 Sep 2023 01:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZp9of314YRGmDSn4ximH0c4TxnyJrqLJ7NujBmlj56tZ2LoHuBOFDZlPx2BkU/hXZg3U1sA==
X-Received: by 2002:a5d:4ccf:0:b0:318:8b5:4159 with SMTP id
 c15-20020a5d4ccf000000b0031808b54159mr1520625wrt.24.1694161694893; 
 Fri, 08 Sep 2023 01:28:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a7bc01a000000b003feeb082a9fsm1384846wmb.3.2023.09.08.01.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 01:28:14 -0700 (PDT)
Message-ID: <519bd11b-3dcb-65fe-eed8-2138e4a81944@redhat.com>
Date: Fri, 8 Sep 2023 10:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] vfio/common: Separate vfio-pci ranges
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20230908071438.86136-1-clg@redhat.com>
 <77ff66f4-ef7e-119e-40b3-d7352918166c@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <77ff66f4-ef7e-119e-40b3-d7352918166c@oracle.com>
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

On 9/8/23 10:16, Joao Martins wrote:
> 
> 
> On 08/09/2023 08:14, Cédric Le Goater wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
>> QEMU includes in the 64-bit range the RAM regions at the lower part
>> and vfio-pci device RAM regions which are at the top of the address
>> space. This range contains a large gap and the size can be bigger than
>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
>>
>> To avoid such large ranges, introduce a new PCI range covering the
>> vfio-pci device RAM regions, this only if the addresses are above 4GB
>> to avoid breaking potential SeaBIOS guests.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> [ clg: - wrote commit log
>>         - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c     | 51 +++++++++++++++++++++++++++++++++++++++-----
>>   hw/vfio/trace-events |  2 +-
>>   2 files changed, 47 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 237101d03844273f653d98b6d053a1ae9c05a247..a5548e3bebf999e6d9cef08bdaf1fbc3b437e5eb 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -27,6 +27,7 @@
>>   
>>   #include "hw/vfio/vfio-common.h"
>>   #include "hw/vfio/vfio.h"
>> +#include "hw/vfio/pci.h"
>>   #include "exec/address-spaces.h"
>>   #include "exec/memory.h"
>>   #include "exec/ram_addr.h"
>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>>       hwaddr max32;
>>       hwaddr min64;
>>       hwaddr max64;
>> +    hwaddr minpci;
>> +    hwaddr maxpci;
> 
> Considering this is about pci64 hole relocation, I wondered post-reading your
> feedback, that maybe we should rename {min,max}pci to {min,max}pci64 (...)

yes.

> 
>>   } VFIODirtyRanges;
>>   
>>   typedef struct VFIODirtyRangesListener {
>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>>       MemoryListener listener;
>>   } VFIODirtyRangesListener;
>>   
>> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>> +                                     VFIOContainer *container)
>> +{
>> +    VFIOPCIDevice *pcidev;
>> +    VFIODevice *vbasedev;
>> +    VFIOGroup *group;
>> +    Object *owner;
>> +
>> +    owner = memory_region_owner(section->mr);
>> +
>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>> +                continue;
>> +            }
>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +            if (OBJECT(pcidev) == owner) {
>> +                return true;
>> +            }
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   static void vfio_dirty_tracking_update(MemoryListener *listener,
>>                                          MemoryRegionSection *section)
>>   {
>> @@ -1434,9 +1462,14 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>>        * would be an IOVATree but that has a much bigger runtime overhead and
>>        * unnecessary complexity.
>>        */
>> -    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
>> -    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
>> -
>> +    if (vfio_section_is_vfio_pci(section, dirty->container) &&
>> +        iova >= UINT32_MAX) {
>> +        min = &range->minpci;
>> +        max = &range->maxpci;
> 
> (...) specially considering this check of making sure we skip the pci-hole32 (as
> that one is fixed)

yep. That check above might deserve a comment also.

Could you resend please ?

Thanks,

C.


> 
>> +    } else {
>> +        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
>> +        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
>> +    }
>>       if (*min > iova) {
>>           *min = iova;
>>       }
>> @@ -1461,6 +1494,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>>       memset(&dirty, 0, sizeof(dirty));
>>       dirty.ranges.min32 = UINT32_MAX;
>>       dirty.ranges.min64 = UINT64_MAX;
>> +    dirty.ranges.minpci = UINT64_MAX;
>>       dirty.listener = vfio_dirty_tracking_listener;
>>       dirty.container = container;
>>   
>> @@ -1531,7 +1565,8 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>>        * DMA logging uAPI guarantees to support at least a number of ranges that
>>        * fits into a single host kernel base page.
>>        */
>> -    control->num_ranges = !!tracking->max32 + !!tracking->max64;
>> +    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
>> +        !!tracking->maxpci;
>>       ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
>>                           control->num_ranges);
>>       if (!ranges) {
>> @@ -1550,11 +1585,17 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>>       if (tracking->max64) {
>>           ranges->iova = tracking->min64;
>>           ranges->length = (tracking->max64 - tracking->min64) + 1;
>> +        ranges++;
>> +    }
>> +    if (tracking->maxpci) {
>> +        ranges->iova = tracking->minpci;
>> +        ranges->length = (tracking->maxpci - tracking->minpci) + 1;
>>       }
>>   
>>       trace_vfio_device_dirty_tracking_start(control->num_ranges,
>>                                              tracking->min32, tracking->max32,
>> -                                           tracking->min64, tracking->max64);
>> +                                           tracking->min64, tracking->max64,
>> +                                           tracking->minpci, tracking->maxpci);
>>   
>>       return feature;
>>   }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index ce61b10827b6a1203a5fe1a87a76d96f25c11345..ab52c6bb7f0c11e51fefef231c108d0c9381547e 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_wi
>>   vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>>   vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
>>   vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
>> -vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
>> +vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci:[0x%"PRIx64" - 0x%"PRIx64"]"
>>   vfio_disconnect_container(int fd) "close container->fd=%d"
>>   vfio_put_group(int fd) "close group->fd=%d"
>>   vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E979A3B2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeg-0000FI-Un; Mon, 11 Sep 2023 02:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qfaef-0000Ev-5N
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qfaea-0004Sm-Sv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694414651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2xqD0YIxOK+GZhQ9wNIZZRwEnvyTP21tpDSn0gAwLE=;
 b=M4duKq27lNDuuZ16EVRINrcPmRQ9oiXzulIRBCdtobU9rZnGn5ZVI4vvfP02qNrK8OTSxI
 pJoX9v6hwEVzuNP9LYe6DJgl44sJPQ9RkgecEvGnFHl/IW4PSLcjh0SXLsgIlb/43zzTE5
 Mq1o7J+M1sQfWxkIDREf21ObiYp5Ark=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-g5FC_Wj9M--uvvXBmy2qUg-1; Mon, 11 Sep 2023 02:44:10 -0400
X-MC-Unique: g5FC_Wj9M--uvvXBmy2qUg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-770ef0da402so282366885a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414649; x=1695019449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2xqD0YIxOK+GZhQ9wNIZZRwEnvyTP21tpDSn0gAwLE=;
 b=Wa++0RNC9rspMG6U8BsSrSjn9u8tmVkJPm6C71e2EFLgzQI9HTUz6hhhLGcQsu6nfO
 HtiHIrpZdorl3+laW8dPlhoT8RjRXhjD1Es9j7DXWrJH6lXpZOBksK05AIQXci3LrcX8
 PaRInHSkB5e2XG10KBgzg8vgOHstNkfeSdCHd7c2DbfqOWJKFWsngxwH67JsEw6IwFPH
 ZloNEvj4fn2PycA+PkbDRpHUBOt636vQqu6K53Oe9jLFPWkSkXy0AmNvkZf/QXxO3ljg
 fz5LjSW0EFaWfaKrpk4E71tx650XPMXpwjRdpEHahYPQHQLk4RRus22jPo6WHJOOo51f
 AxYw==
X-Gm-Message-State: AOJu0YznAyk/4pb2OiMceFFbAXajR0yM0hOD6IFu684EfM5zoMcyYbSx
 jneUzRHjJq2oK3Ev/xsneJ2hKHxkVwXhrDdEVf610sRhT7XLpO6U/wSaUIevlMkvKFelRigf7/Q
 2ypaXykFFSQHEyhc=
X-Received: by 2002:a05:620a:c08:b0:76f:382:b551 with SMTP id
 l8-20020a05620a0c0800b0076f0382b551mr8031308qki.35.1694414649618; 
 Sun, 10 Sep 2023 23:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvVBUqNbYJhZtzePqRDZOzdvKlgXYJsVtjLBzRMMBa3uSUiVuULPuOKTv54LqFzIlkH4++kw==
X-Received: by 2002:a05:620a:c08:b0:76f:382:b551 with SMTP id
 l8-20020a05620a0c0800b0076f0382b551mr8031298qki.35.1694414649370; 
 Sun, 10 Sep 2023 23:44:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a05620a133200b0076e672f535asm2315952qkj.57.2023.09.10.23.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Sep 2023 23:44:09 -0700 (PDT)
Message-ID: <82ab4a43-2bc8-aa4c-6743-0951fbb91357@redhat.com>
Date: Mon, 11 Sep 2023 08:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230908092944.47589-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/8/23 11:29, Joao Martins wrote:
> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
> QEMU includes in the 64-bit range the RAM regions at the lower part
> and vfio-pci device RAM regions which are at the top of the address
> space. This range contains a large gap and the size can be bigger than
> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
> 
> To avoid such large ranges, introduce a new PCI range covering the
> vfio-pci device RAM regions, this only if the addresses are above 4GB
> to avoid breaking potential SeaBIOS guests.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> [ clg: - wrote commit log
>         - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> v2:
> * s/minpci/minpci64/
> * s/maxpci/maxpci64/
> * Expand comment to cover the pci-hole64 and why we don't do special
>    handling of pci-hole32.

This is a valuable fix for the latest OVMF enabling dynamic MMIO
window. Applied to vfio-next.

Thanks,

C.


> ---
>   hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-------
>   hw/vfio/trace-events |  2 +-
>   2 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 237101d03844..134649226d43 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -27,6 +27,7 @@
>   
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/vfio/vfio.h"
> +#include "hw/vfio/pci.h"
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
>   #include "exec/ram_addr.h"
> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>       hwaddr max32;
>       hwaddr min64;
>       hwaddr max64;
> +    hwaddr minpci64;
> +    hwaddr maxpci64;
>   } VFIODirtyRanges;
>   
>   typedef struct VFIODirtyRangesListener {
> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>       MemoryListener listener;
>   } VFIODirtyRangesListener;
>   
> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
> +                                     VFIOContainer *container)
> +{
> +    VFIOPCIDevice *pcidev;
> +    VFIODevice *vbasedev;
> +    VFIOGroup *group;
> +    Object *owner;
> +
> +    owner = memory_region_owner(section->mr);
> +
> +    QLIST_FOREACH(group, &container->group_list, container_next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +                continue;
> +            }
> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +            if (OBJECT(pcidev) == owner) {
> +                return true;
> +            }
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static void vfio_dirty_tracking_update(MemoryListener *listener,
>                                          MemoryRegionSection *section)
>   {
> @@ -1424,19 +1452,32 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>       }
>   
>       /*
> -     * The address space passed to the dirty tracker is reduced to two ranges:
> -     * one for 32-bit DMA ranges, and another one for 64-bit DMA ranges.
> +     * The address space passed to the dirty tracker is reduced to three ranges:
> +     * one for 32-bit DMA ranges, one for 64-bit DMA ranges and one for the
> +     * PCI 64-bit hole.
> +     *
>        * The underlying reports of dirty will query a sub-interval of each of
>        * these ranges.
>        *
> -     * The purpose of the dual range handling is to handle known cases of big
> -     * holes in the address space, like the x86 AMD 1T hole. The alternative
> -     * would be an IOVATree but that has a much bigger runtime overhead and
> -     * unnecessary complexity.
> +     * The purpose of the three range handling is to handle known cases of big
> +     * holes in the address space, like the x86 AMD 1T hole, and firmware (like
> +     * OVMF) which may relocate the pci-hole64 to the end of the address space.
> +     * The latter would otherwise generate large ranges for tracking, stressing
> +     * the limits of supported hardware. The pci-hole32 will always be below 4G
> +     * (overlapping or not) so it doesn't need special handling and is part of
> +     * the 32-bit range.
> +     *
> +     * The alternative would be an IOVATree but that has a much bigger runtime
> +     * overhead and unnecessary complexity.
>        */
> -    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
> -    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
> -
> +    if (vfio_section_is_vfio_pci(section, dirty->container) &&
> +        iova >= UINT32_MAX) {
> +        min = &range->minpci64;
> +        max = &range->maxpci64;
> +    } else {
> +        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
> +        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
> +    }
>       if (*min > iova) {
>           *min = iova;
>       }
> @@ -1461,6 +1502,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>       memset(&dirty, 0, sizeof(dirty));
>       dirty.ranges.min32 = UINT32_MAX;
>       dirty.ranges.min64 = UINT64_MAX;
> +    dirty.ranges.minpci64 = UINT64_MAX;
>       dirty.listener = vfio_dirty_tracking_listener;
>       dirty.container = container;
>   
> @@ -1531,7 +1573,8 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>        * DMA logging uAPI guarantees to support at least a number of ranges that
>        * fits into a single host kernel base page.
>        */
> -    control->num_ranges = !!tracking->max32 + !!tracking->max64;
> +    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
> +        !!tracking->maxpci64;
>       ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
>                           control->num_ranges);
>       if (!ranges) {
> @@ -1550,11 +1593,17 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>       if (tracking->max64) {
>           ranges->iova = tracking->min64;
>           ranges->length = (tracking->max64 - tracking->min64) + 1;
> +        ranges++;
> +    }
> +    if (tracking->maxpci64) {
> +        ranges->iova = tracking->minpci64;
> +        ranges->length = (tracking->maxpci64 - tracking->minpci64) + 1;
>       }
>   
>       trace_vfio_device_dirty_tracking_start(control->num_ranges,
>                                              tracking->min32, tracking->max32,
> -                                           tracking->min64, tracking->max64);
> +                                           tracking->min64, tracking->max64,
> +                                           tracking->minpci64, tracking->maxpci64);
>   
>       return feature;
>   }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ce61b10827b6..cc7c21365c92 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_wi
>   vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>   vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
>   vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
> -vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
> +vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>   vfio_disconnect_container(int fd) "close container->fd=%d"
>   vfio_put_group(int fd) "close group->fd=%d"
>   vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"



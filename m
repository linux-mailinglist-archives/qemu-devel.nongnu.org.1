Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85879843F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX1J-00008k-SD; Fri, 08 Sep 2023 04:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeX1H-0008TR-8R
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeX1E-00034Q-Qv
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694162351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dM0yYa+bcgSn4a2a0swQbiAjBsvqppBqzZvCFc0paDY=;
 b=fATX9EhMeg/fA2Y+Nak1cLN0QwbIYjkiBt22fwGavVoWzOacTl7skJz/y+YwIbCVxh1XSR
 by8ZiB9ucHPoVm1qVPxht5Kj1/xOL8BJoQNS15NO4eBfhDTAUF0Yk8fqXgnykmX34Wk8PI
 lJ+dV477za2cO1nDmiHrSrm5yoaud9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-AEaA9WghO76ugF41hbtO3w-1; Fri, 08 Sep 2023 04:39:10 -0400
X-MC-Unique: AEaA9WghO76ugF41hbtO3w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aea5cf0f5so1256028f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162349; x=1694767149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dM0yYa+bcgSn4a2a0swQbiAjBsvqppBqzZvCFc0paDY=;
 b=QQZPUFsaTZC3WV8JiXIiphNd1lm+DkYo/2P2d27yZonBQiP5Z2hHYSYTuVEBUJtawk
 K8yqb7ffsFswZPFzI6EuoiI73VtykESRgCCViLW0xQiZL4weZJ1xaKqbAPhU1U+hj5ST
 zKDQZJbQjttd0dnWQaPo3Ms1zzFGWf3vhXZ4V9LzKTM6CUGQwvQf7ihKOnV60ruZ8LWK
 dYW7HIf5obCXZqcjnvRkW+WALxVvPqf/UeAs+cNtjNZyhM8QXiDn9B8UWhVLHOu/x1s9
 tln3vgdW/Jv26ZUvK+xCj/H6hmQ/LvAnTeT2jaw04cYmH7f0AsiVsRUFcDBVFaSAJPxT
 hOsA==
X-Gm-Message-State: AOJu0Yzu1YDiJIzpx/rSJLTNcYMoojCcKVzRilxHmGD4vABcsYQyi/hg
 n3fAZta3fsbSHdK6Ix1Ia6EW84TdYkqTeZAgAoqi0cBzkuwpIRZO64fCBmG913ajfBG8Bjk5OJW
 DFjGVHjTzgotTHEU=
X-Received: by 2002:adf:ef11:0:b0:31a:e5e8:1d8e with SMTP id
 e17-20020adfef11000000b0031ae5e81d8emr1356680wro.5.1694162349409; 
 Fri, 08 Sep 2023 01:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERoIt5AGw/pgU/X0Ni9W1pn0JRMfTpkFTUbtTQp9oz74IfQ+zwWRwYt4GuOWs3G785c3cT7g==
X-Received: by 2002:adf:ef11:0:b0:31a:e5e8:1d8e with SMTP id
 e17-20020adfef11000000b0031ae5e81d8emr1356662wro.5.1694162348980; 
 Fri, 08 Sep 2023 01:39:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 p15-20020adff20f000000b003143c9beeaesm1477884wro.44.2023.09.08.01.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 01:39:08 -0700 (PDT)
Message-ID: <eeb858f8-be7a-9778-98dd-b5c472b56203@redhat.com>
Date: Fri, 8 Sep 2023 10:39:07 +0200
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
 <519bd11b-3dcb-65fe-eed8-2138e4a81944@redhat.com>
 <002da1e6-929e-3681-eb3c-1fea30c7adc0@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <002da1e6-929e-3681-eb3c-1fea30c7adc0@oracle.com>
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

On 9/8/23 10:35, Joao Martins wrote:
> On 08/09/2023 09:28, Cédric Le Goater wrote:
>> On 9/8/23 10:16, Joao Martins wrote:
>>> On 08/09/2023 08:14, Cédric Le Goater wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>
>>>> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
>>>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
>>>> QEMU includes in the 64-bit range the RAM regions at the lower part
>>>> and vfio-pci device RAM regions which are at the top of the address
>>>> space. This range contains a large gap and the size can be bigger than
>>>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
>>>>
>>>> To avoid such large ranges, introduce a new PCI range covering the
>>>> vfio-pci device RAM regions, this only if the addresses are above 4GB
>>>> to avoid breaking potential SeaBIOS guests.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> [ clg: - wrote commit log
>>>>          - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>    hw/vfio/common.c     | 51 +++++++++++++++++++++++++++++++++++++++-----
>>>>    hw/vfio/trace-events |  2 +-
>>>>    2 files changed, 47 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index
>>>> 237101d03844273f653d98b6d053a1ae9c05a247..a5548e3bebf999e6d9cef08bdaf1fbc3b437e5eb 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -27,6 +27,7 @@
>>>>      #include "hw/vfio/vfio-common.h"
>>>>    #include "hw/vfio/vfio.h"
>>>> +#include "hw/vfio/pci.h"
>>>>    #include "exec/address-spaces.h"
>>>>    #include "exec/memory.h"
>>>>    #include "exec/ram_addr.h"
>>>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>>>>        hwaddr max32;
>>>>        hwaddr min64;
>>>>        hwaddr max64;
>>>> +    hwaddr minpci;
>>>> +    hwaddr maxpci;
>>>
>>> Considering this is about pci64 hole relocation, I wondered post-reading your
>>> feedback, that maybe we should rename {min,max}pci to {min,max}pci64 (...)
>>
>> yes.
>>
>>>
>>>>    } VFIODirtyRanges;
>>>>      typedef struct VFIODirtyRangesListener {
>>>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>>>>        MemoryListener listener;
>>>>    } VFIODirtyRangesListener;
>>>>    +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>>>> +                                     VFIOContainer *container)
>>>> +{
>>>> +    VFIOPCIDevice *pcidev;
>>>> +    VFIODevice *vbasedev;
>>>> +    VFIOGroup *group;
>>>> +    Object *owner;
>>>> +
>>>> +    owner = memory_region_owner(section->mr);
>>>> +
>>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>>>> +                continue;
>>>> +            }
>>>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>>> +            if (OBJECT(pcidev) == owner) {
>>>> +                return true;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return false;
>>>> +}
>>>> +
>>>>    static void vfio_dirty_tracking_update(MemoryListener *listener,
>>>>                                           MemoryRegionSection *section)
>>>>    {
>>>> @@ -1434,9 +1462,14 @@ static void vfio_dirty_tracking_update(MemoryListener
>>>> *listener,
>>>>         * would be an IOVATree but that has a much bigger runtime overhead and
>>>>         * unnecessary complexity.
>>>>         */
>>>> -    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
>>>> -    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
>>>> -
>>>> +    if (vfio_section_is_vfio_pci(section, dirty->container) &&
>>>> +        iova >= UINT32_MAX) {
>>>> +        min = &range->minpci;
>>>> +        max = &range->maxpci;
>>>
>>> (...) specially considering this check of making sure we skip the pci-hole32 (as
>>> that one is fixed)
>>
>> yep. That check above might deserve a comment also.
>>
>> Could you resend please ?
>>
> 
> yes. This is on top of your vfio-8.2 branch right?

yes. Just reset the HEAD, I will merge the new version.

C.



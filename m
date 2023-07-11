Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E274E92C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 10:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ8nc-0006zq-Q3; Tue, 11 Jul 2023 04:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJ8na-0006yz-Si
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJ8nX-00023R-SF
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689064357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOsR8F7D2x9MShGzHoJo8Dflai3fFY0qx4C7Qy7a7/c=;
 b=YkOqH2Tj8fzckV1ugVfZVoCSem5nCghgb/Ax+m332mW0HDEiUnCKqlWjoZeZpSWN/eOQnl
 cL+KaHwT50llFfSFKw5djeW01lDhq3RGk/vNq+dmyKY1L4fu/ghblw49pPnUhfryBJlxa/
 s5pTVE9TOoJXIEHpJ0j308L83kjgEig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-6WhRRX_PNWasRLZePfJZ4A-1; Tue, 11 Jul 2023 04:32:34 -0400
X-MC-Unique: 6WhRRX_PNWasRLZePfJZ4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31596170243so1760415f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 01:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689064353; x=1691656353;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOsR8F7D2x9MShGzHoJo8Dflai3fFY0qx4C7Qy7a7/c=;
 b=knTyL43AbkxhMu8zNTCtXSYZ3nGpyzL/VZkVWT4MnR2zQdmdijmmHMTKqEH9gIAEA/
 669HDID2GYN1R6ojmsOj/q5eA4uBW7ckfpcLNxhrg5dK87SG0yTvFva/8q5snygxc2is
 23Hl+zhqa5GJL1p17ijN4/P5O6DvTdxSjzdSSQUhH/h/jojpPcI4jKicKs31Z6h5NfdS
 03q6SpKK2w/koZjJaV7zyNPidsTegVqEGZe76mqGMuB6OjOs4Z/gjKeuvOvWakyD320x
 GTJq2K3Gbl1qD++vwX+6cF/7ufqpJsn1pFJuTdICBnhvveM0Ttd7q4Qm4beafkpu53l9
 5XXQ==
X-Gm-Message-State: ABy/qLZoENepeoDotYiRI5vRgGN4m4mpH5JX88kr8LbN5DpH3qP2zP5E
 vWDNpGj4CJdhc5j/XSsmFqlCL3jxYifSggNqTWnhOoydGDZgW8Cg560D4cjMUKFiUDQ1/gR2/op
 m6ypP3o/4YlNzChZmuMq3KZA=
X-Received: by 2002:a5d:4d8e:0:b0:314:3e77:f210 with SMTP id
 b14-20020a5d4d8e000000b003143e77f210mr14128485wru.59.1689064353284; 
 Tue, 11 Jul 2023 01:32:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHYMA9AcuYQnRM2w+1RN4AUUVPmMVPqJs3BDU5zzp2UrtsyHyOXh5saGvxP8RcY230V6ltaQ==
X-Received: by 2002:a5d:4d8e:0:b0:314:3e77:f210 with SMTP id
 b14-20020a5d4d8e000000b003143e77f210mr14128466wru.59.1689064352839; 
 Tue, 11 Jul 2023 01:32:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d?
 (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de.
 [2003:cb:c745:4000:13ad:ed64:37e6:115d])
 by smtp.gmail.com with ESMTPSA id
 a4-20020adfeec4000000b0030c4d8930b1sm1595824wrp.91.2023.07.11.01.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 01:32:32 -0700 (PDT)
Message-ID: <b9351bf7-cabd-784c-bebc-a18a9b3f4bc1@redhat.com>
Date: Tue, 11 Jul 2023 10:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
 <20230710100714.228867-4-david@redhat.com>
 <20230710173933-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 3/7] arm/virt: Use virtio-md-pci (un)plug functions
In-Reply-To: <20230710173933-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10.07.23 23:40, Michael S. Tsirkin wrote:
> On Mon, Jul 10, 2023 at 12:07:10PM +0200, David Hildenbrand wrote:
>> Let's use our new helper functions. Note that virtio-pmem-pci is not
>> enabled for arm and, therefore, not compiled in.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/arm/virt.c | 81 ++++++++-------------------------------------------
>>   1 file changed, 12 insertions(+), 69 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 8a4c663735..4ae1996d37 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -73,11 +73,10 @@
>>   #include "hw/arm/smmuv3.h"
>>   #include "hw/acpi/acpi.h"
>>   #include "target/arm/internals.h"
>> -#include "hw/mem/memory-device.h"
>>   #include "hw/mem/pc-dimm.h"
>>   #include "hw/mem/nvdimm.h"
>>   #include "hw/acpi/generic_event_device.h"
>> -#include "hw/virtio/virtio-mem-pci.h"
>> +#include "hw/virtio/virtio-md-pci.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/char/pl011.h"
>>   #include "qemu/guest-random.h"
>> @@ -2740,64 +2739,6 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>>                            dev, &error_abort);
>>   }
>>   
>> -static void virt_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
>> -                                        DeviceState *dev, Error **errp)
>> -{
>> -    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>> -    Error *local_err = NULL;
>> -
>> -    if (!hotplug_dev2 && dev->hotplugged) {
>> -        /*
>> -         * Without a bus hotplug handler, we cannot control the plug/unplug
>> -         * order. We should never reach this point when hotplugging on ARM.
>> -         * However, it's nice to add a safety net, similar to what we have
>> -         * on x86.
>> -         */
>> -        error_setg(errp, "hotplug of virtio based memory devices not supported"
>> -                   " on this bus.");
>> -        return;
>> -    }
>> -    /*
>> -     * First, see if we can plug this memory device at all. If that
>> -     * succeeds, branch of to the actual hotplug handler.
>> -     */
>> -    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
>> -                           &local_err);
>> -    if (!local_err && hotplug_dev2) {
>> -        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
>> -    }
>> -    error_propagate(errp, local_err);
>> -}
>> -
>> -static void virt_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
>> -                                    DeviceState *dev, Error **errp)
>> -{
>> -    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>> -    Error *local_err = NULL;
>> -
>> -    /*
>> -     * Plug the memory device first and then branch off to the actual
>> -     * hotplug handler. If that one fails, we can easily undo the memory
>> -     * device bits.
>> -     */
>> -    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
>> -    if (hotplug_dev2) {
>> -        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
>> -        if (local_err) {
>> -            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
>> -        }
>> -    }
>> -    error_propagate(errp, local_err);
>> -}
>> -
>> -static void virt_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
>> -                                              DeviceState *dev, Error **errp)
>> -{
>> -    /* We don't support hot unplug of virtio based memory devices */
>> -    error_setg(errp, "virtio based memory devices cannot be unplugged.");
>> -}
>> -
>> -
>>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>                                               DeviceState *dev, Error **errp)
>>   {
>> @@ -2805,8 +2746,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>   
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>           virt_memory_pre_plug(hotplug_dev, dev, errp);
>> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>> -        virt_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>> +        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>>           hwaddr db_start = 0, db_end = 0;
>>           char *resv_prop_str;
>> @@ -2855,12 +2796,11 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>                                        SYS_BUS_DEVICE(dev));
>>           }
>>       }
>> +
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>           virt_memory_plug(hotplug_dev, dev, errp);
>> -    }
>> -
>> -    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>> -        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>> +        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>>       }
>>   
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> 
> 
> How is this supposed to link if virtio-md is disabled at compile time?
> 

Good point.

The old code unconditionally enabled MEM_DEVICE, so we never required 
subs for that.

We either need stubs or have to wrap this in #ifdef.

Stubs sound cleaner.

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C84637B1036
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 03:05:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlfRZ-0003Vl-SQ; Wed, 27 Sep 2023 21:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfRX-0003VG-TS
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfRW-0000mr-8d
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695863029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VljtfhAY9I3PsuiP8Db42I9M0WaDXHXX8rt5liSX3io=;
 b=PH1+EsuTrYNaxZ0V3Y36p6LUX+Zu85M27qRjRaf4wtpqcj1+sTtxr3ITgE7Rm5xPoPdYdj
 gWKuKqyU2DStKCKKB6r8KEr6KQ9Ccwctd8R2PxDWTqx+g1j5i40e94oT3H24qfl4AaD7Xx
 FsIg2rYHFMB2T6OlNqXUa3XmuuKUhIs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-6ajGS3pdM4eLA4uUmb602w-1; Wed, 27 Sep 2023 21:03:47 -0400
X-MC-Unique: 6ajGS3pdM4eLA4uUmb602w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-57dce07c62aso14004465a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 18:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695863026; x=1696467826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VljtfhAY9I3PsuiP8Db42I9M0WaDXHXX8rt5liSX3io=;
 b=fD0PIoCjXuJKZtZvJaU0XOsWxjMAPU+NreewMRJw7oVO8u3UgTCn05RynEpLtoGWjt
 AidPOLoUDEXMANtH5Ev8iyCCAly3R8Do1f+GwMEt8UxB1qMDjpSqQ+5tAKV0UmdbKwDf
 gElS5TAZHAdF8Kk3on69dBGwRXBhGiMxcxnQDwHQN2Qw5xxZSHlu3CLpelIGs1FwnIN7
 YAW4HO1yQYIYVSTL9EY4ijJ8dzE/1D/VtbCbkMHSLwGHnUXEnpbvB86ow9Qr72xB4Jmx
 ozHW6Lk19O4vE4Xh/UFCbcOlI74FWLDI/xC2UFHzBsS77onlEZl4etsYbRljxQ1eA8Q3
 Ar0w==
X-Gm-Message-State: AOJu0YxedEs2+WTDOJs0nF29NOM7QASolUqvVDou2thG8lgO3gVH6IgE
 pmDZ6gQ95COL2D/8nMY8+7TEYIKaaAbwg5xIi+CV7D6R6lxQYrQOLBqK/dqG6pze6ZLdMkZAldA
 js+Ea3omm0ADruiE=
X-Received: by 2002:a05:6a20:9191:b0:15c:d925:aaaf with SMTP id
 v17-20020a056a20919100b0015cd925aaafmr3710170pzd.5.1695863026407; 
 Wed, 27 Sep 2023 18:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrXrvKAZv6ndXGZlUBawetHAxt14+dRH0elj0870RwsiUQ12Ow6N6cJEirFLcoAw+aqimFsA==
X-Received: by 2002:a05:6a20:9191:b0:15c:d925:aaaf with SMTP id
 v17-20020a056a20919100b0015cd925aaafmr3710136pzd.5.1695863026085; 
 Wed, 27 Sep 2023 18:03:46 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 jc1-20020a17090325c100b001b8a3e2c241sm6738688plb.14.2023.09.27.18.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 18:03:45 -0700 (PDT)
Message-ID: <1e526a50-7001-a15b-79cb-e223048b52ce@redhat.com>
Date: Thu, 28 Sep 2023 11:03:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 14/37] arm/virt: Add cpu hotplug events to GED
 during creation
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-15-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-15-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
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

Hi Salil,

On 9/26/23 20:04, Salil Mehta wrote:
> Add CPU Hotplug event to the set of supported ged-events during the creation of
> GED device during VM init. Also initialize the memory map for CPU Hotplug
              ^^^^^^^^^^^^^^
              it can be dropped.
> control device used in event exchanges between Qemu/VMM and the guest.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c         | 5 ++++-
>   include/hw/arm/virt.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 

The changes look good to me:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 070c36054e..5c8a0672dc 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -76,6 +76,7 @@
>   #include "hw/mem/pc-dimm.h"
>   #include "hw/mem/nvdimm.h"
>   #include "hw/acpi/generic_event_device.h"
> +#include "hw/acpi/cpu_hotplug.h"
>   #include "hw/virtio/virtio-md-pci.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/char/pl011.h"
> @@ -155,6 +156,7 @@ static const MemMapEntry base_memmap[] = {
>       [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>       [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>       [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> +    [VIRT_CPUHP_ACPI] =         { 0x090c0000, ACPI_CPU_HOTPLUG_REG_LEN},
>       [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>       /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>       [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -640,7 +642,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>       DeviceState *dev;
>       MachineState *ms = MACHINE(vms);
>       int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_CPU_HOTPLUG_EVT;
>   
>       if (ms->ram_slots) {
>           event |= ACPI_GED_MEM_HOTPLUG_EVT;
> @@ -655,6 +657,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>   
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, vms->memmap[VIRT_CPUHP_ACPI].base);
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index fc0469c33f..09a0b2d4f0 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -85,6 +85,7 @@ enum {
>       VIRT_PCDIMM_ACPI,
>       VIRT_ACPI_GED,
>       VIRT_NVDIMM_ACPI,
> +    VIRT_CPUHP_ACPI,
>       VIRT_PVTIME,
>       VIRT_LOWMEMMAP_LAST,
>   };

Thanks,
Gavin



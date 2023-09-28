Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0517B102F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 02:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlfL7-0000vy-OB; Wed, 27 Sep 2023 20:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfL5-0000vn-Oy
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfL3-000700-HR
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695862628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gbrsl00JxY9Mm0XVtA3ZtJCnbtkROL6hKRpyD9Lw29c=;
 b=TflqxsJ5vv/Hqc2v8/gZhImLnRHbnQdSj4L0KYap4GMI8SxSCKRb9YnL1zfmqpIr8L7w5T
 ep9Qq839j5L0cqyUNf3I6qQ/VZ7IAgfP4m04ULWUk9HdKoLi79HoyGTRJKKMbjC7wNyd5T
 E6ivBm4mVmdLf02gRti2tqVdUMb6xG8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-S6ySQ3tBMfm0oh8Cco36Jg-1; Wed, 27 Sep 2023 20:57:06 -0400
X-MC-Unique: S6ySQ3tBMfm0oh8Cco36Jg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-57b6cd1a530so21575257eaf.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695862626; x=1696467426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gbrsl00JxY9Mm0XVtA3ZtJCnbtkROL6hKRpyD9Lw29c=;
 b=MxGRMz++2+aK/dnyGK6cT1+i5DO6hpaaOM3i0PxQ1YA7PqrdNgA5HOvxgLrnBLJ1OB
 ypBsDOCWkBoMSFHuuPnfBC1+RRVDqgGMyJVoZNbE2xLIGx3pjfgUr12kJ2BAbW2M6QA6
 Xe7sbeE1eo0a4/ux8VYjMtkGdyH6t190AEl9nF98fQwZ+fRUD5B5OEyFarhuBPW3I9NT
 PFAjMWc75REsq/QkfQFLYWRaPKkURTL6ErFJNiQvwH75KVTi+Egpwh6+Ym66tnp4C2mH
 vba5NY7mhc1IN0aJuE2viv747uwCE+GoRQDSyA+6dccjL3uwFBdQY8yGxBrXpnJC3VGF
 rtag==
X-Gm-Message-State: AOJu0YxpumwxAZfdz1sdtXYC42/0cTBkaps9oqQkpiTrsthydsNk6JYC
 3ReeiFVUzE4fY+Zj2kMld29CHxcM9GoGAkvCIWoZ1eSXf1FbPstyZaGaA7IHjC3hNdm3gdCvMMK
 wTRLQLeNRmIqxxD0=
X-Received: by 2002:a05:6358:2484:b0:143:3179:1a67 with SMTP id
 m4-20020a056358248400b0014331791a67mr3786564rwc.29.1695862625886; 
 Wed, 27 Sep 2023 17:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOgD+m/JQin421qMlawtfb5KwAkugCCvJOtn8bDZXYqu7vk8EZxGiweQyOmesGGxJnsUKotg==
X-Received: by 2002:a05:6358:2484:b0:143:3179:1a67 with SMTP id
 m4-20020a056358248400b0014331791a67mr3786537rwc.29.1695862625493; 
 Wed, 27 Sep 2023 17:57:05 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 b25-20020aa78719000000b00690cd981652sm12328863pfo.61.2023.09.27.17.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 17:57:04 -0700 (PDT)
Message-ID: <f3db9fe9-2fbb-003e-3da4-26c401d09c1f@redhat.com>
Date: Thu, 28 Sep 2023 10:56:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 13/37] hw/acpi: Init GED framework with cpu hotplug
 events
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
 <20230926100436.28284-14-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-14-salil.mehta@huawei.com>
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

Hi Salil,

On 9/26/23 20:04, Salil Mehta wrote:
> ACPI GED(as described in the ACPI 6.2 spec) can be used to generate ACPI events
> when OSPM/guest receives an interrupt listed in the _CRS object of GED. OSPM
> then maps or demultiplexes the event by evaluating _EVT method.
> 
> This change adds the support of cpu hotplug event initialization in the
> existing GED framework.
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/generic_event_device.c         | 8 ++++++++
>   include/hw/acpi/generic_event_device.h | 5 +++++
>   2 files changed, 13 insertions(+)
> 

It looks a bit strange you're co-developing the patch with yourself.
It seems all patches follow this particular pattern. I could be changed
to:

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

The code changes look good to me with the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index a3d31631fe..d2fa1d0e4a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] = {
>       ACPI_GED_MEM_HOTPLUG_EVT,
>       ACPI_GED_PWR_DOWN_EVT,
>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>   };
>   

Can we move ACPI_GED_CPU_HOTPLUG_EVT ahead of ACPI_GED_MEM_HOTPLUG_EVT?

>   /*
> @@ -400,6 +401,13 @@ static void acpi_ged_initfn(Object *obj)
>       memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                             TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>       sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    s->cpuhp.device = OBJECT(s);
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>   }
>   
>   static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d831bbd889..d0a5a43abf 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>   #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/acpi/cpu_hotplug.h"
>   #include "hw/acpi/memory_hotplug.h"
>   #include "hw/acpi/ghes.h"
>   #include "qom/object.h"
> @@ -97,6 +98,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>   #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>   

#define ACPI_GED_CPU_HOTPLUG_EVT  0x1
#define ACPI_GED_MEM_HOTPLUG_EVT  0x2
   :

If the adjustment is friendly to live migration.

>   typedef struct GEDState {
>       MemoryRegion evt;
> @@ -108,6 +110,9 @@ struct AcpiGedState {
>       SysBusDevice parent_obj;
>       MemHotplugState memhp_state;
>       MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
> +    AcpiCpuHotplug cpuhp;
>       GEDState ged_state;
>       uint32_t ged_event_bitmap;
>       qemu_irq irq;

Thanks,
Gavin



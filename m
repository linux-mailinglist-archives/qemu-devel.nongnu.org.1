Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60287D9AD5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwNVj-0005kO-Jf; Fri, 27 Oct 2023 10:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwNVg-0005jm-6a
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwNVe-0008B6-61
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698415699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTN7KSSZRiqxZF+BOn09UPcbaYB9WIihV9g9+3NAX/s=;
 b=JrxNAbwjW/MiaVK5j/l62fodJS0wIjmW9EjTe5FCjyE0EhDb4HpqdTqp/1qKW573QyVOKC
 RbVuz8yw3UX14w9cvfOlkdK+C2tjbd66EcMHPNas+Wtom/DEhL/kpva3Oob6iMZMUV4zjo
 EAGekxUxbrqwEu5B0ZvD29p8axyDwzg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-G9fXGG4SOPGEWznBv7J7qA-1; Fri, 27 Oct 2023 10:08:18 -0400
X-MC-Unique: G9fXGG4SOPGEWznBv7J7qA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54045f31f49so1582520a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698415697; x=1699020497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTN7KSSZRiqxZF+BOn09UPcbaYB9WIihV9g9+3NAX/s=;
 b=ignytM5b+6Oc444Srml2hEgHbjiCGKmSNn5vgcwVpEaamPXJA7wSX0oJxOcFp25CsO
 nUtIhMBUVtr9h0CdYdUuAVw+OeYS4XbS+PRAamyt28UxYkguf3ket7yOpt/S/zWOskkl
 vc3pDxyAckpE3kcVDw9yTV9XW2UXnZvN7P6xHfAgzCSNJaQh2ns1s84qORCq5dYHc8Hs
 2Wu3FKYVWcRF8nBA/Jed5zO4DvS1NijlcT+9b/IZtLXCH3RYVMZIifyOol3I4BDSl5sj
 JMKsSAXcuZ/MrA9CHso1kdty14oYN0KIs6oj9vWTvlC/+psF+bMfhC1Lkppz8sqsbVzs
 ZwAw==
X-Gm-Message-State: AOJu0Yx16trmUeH3kcg7mw0AXNGg1Agzfum6fuZIoJtX6JBuWiL5W3FE
 Kizyi+8xD5+iFlIti0UUanAhYZ+Ma70B2srapSsAm5dF93swVC0JXYeYxx+7kyTnZbC9uZnuClG
 op+aAL+3V1VYjZAs=
X-Received: by 2002:a05:6402:40c5:b0:53d:983c:2672 with SMTP id
 z5-20020a05640240c500b0053d983c2672mr2831781edb.38.1698415697268; 
 Fri, 27 Oct 2023 07:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9wPTk7qBhl0A81Dq8fzUM2rXak77Gffp1y2m3UU7jbZs3FlNDOlFDmw7XR+9h4bD1tTBLw==
X-Received: by 2002:a05:6402:40c5:b0:53d:983c:2672 with SMTP id
 z5-20020a05640240c500b0053d983c2672mr2831724edb.38.1698415696923; 
 Fri, 27 Oct 2023 07:08:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 s20-20020a056402165400b0053e37d13f4fsm1273490edx.52.2023.10.27.07.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:08:16 -0700 (PDT)
Date: Fri, 27 Oct 2023 16:08:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V6 4/9] hw/acpi: Init GED framework with CPU hotplug events
Message-ID: <20231027160814.3f47ff70@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231013105129.25648-5-salil.mehta@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-5-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 13 Oct 2023 11:51:24 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> ACPI GED(as described in the ACPI 6.2 spec) can be used to generate ACPI events
> when OSPM/guest receives an interrupt listed in the _CRS object of GED. OSPM
> then maps or demultiplexes the event by evaluating _EVT method.
> 
> This change adds the support of CPU hotplug event initialization in the
> existing GED framework.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  hw/acpi/generic_event_device.c         | 8 ++++++++
>  include/hw/acpi/generic_event_device.h | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index a3d31631fe..d2fa1d0e4a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>  };
>  
>  /*
> @@ -400,6 +401,13 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    s->cpuhp.device = OBJECT(s);
ain't OBJECT(s) == OBJECT(dev)m


> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);

we really should refactor GED to initfn/realizefn pattern.
then at create_acpi_ged() one would enable cpu_hotplug event
and later realizefs would call cpu_hotplug_hw_init() if event is enabled.

>  }
>  
>  static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ba84ce0214..a803ea818e 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>  #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>  
>  #include "hw/sysbus.h"
> +#include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/ghes.h"
>  #include "qom/object.h"
> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -106,6 +108,9 @@ struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
>      MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
> +    AcpiCpuHotplug cpuhp;

how about merging CPUHotplugState and AcpiCpuHotplug
and isolating AcpiCpuHotplug::sts to x86 legacy hotplug code only?

then you won't have to pull in 2 states (one of which includes
GPE specific array that's not applicable to GED)

>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE37AEC20
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6o2-0001UU-Vh; Tue, 26 Sep 2023 08:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6ne-0001Rn-UG
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6nO-0006Sz-Ti
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695729846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lq/f1ds1EKDK/nyj6A0JXervdAuzwKQFXzu3xKZMfu4=;
 b=TF5K3XcuVHviMCIWu9HSICPxnW3JfiJNSCdx85/9MzULH87lB1gPaIFWwGVQbTD75rHO3U
 sH6vBhF9tbhaV9Ae5cs8mJ6CAnzydGP9uVavkByihF1MUqJBRhTEWoqpCuOA5QZ3SSVHp0
 s8BdOLNAm9q8uhxTH1m7ic+Tq5spes0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-gKz8loRGPGeAMtiUx3_wBQ-1; Tue, 26 Sep 2023 08:04:04 -0400
X-MC-Unique: gKz8loRGPGeAMtiUx3_wBQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a348facbbso727551566b.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695729843; x=1696334643;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lq/f1ds1EKDK/nyj6A0JXervdAuzwKQFXzu3xKZMfu4=;
 b=s0Fypfgxsi078LyPjBO1e9FpYQn68J2OuPV64/vjfhO9GP8wWV8gYva5bAPPcjH7T3
 jSf8fR6Z1AiHQkt6IN1G3MpwL5xidHell5FwvO7HUXdECO3tr5dgpj68Ds9VNXRxgho/
 w7KIFwR+tnfQ7JFqy5cVsoyk0HKc1meNhIcnXiF6rwYdyM8PUAhbfsBDg1vC/woxnrhv
 KsMaf0EfFdpan4q2HIAWmKIEUJ5gJ20G9kz4lXkLAFVG7UkpCY7Yj3aWIxWF4aJUVPRP
 DG5TE2G0CdWh8a4hBbxiFsle8h3u9I9xgRUn3vvLmYOfkkv5UMTA1UEGefT6/5v7zC2v
 4kTQ==
X-Gm-Message-State: AOJu0YxAeUZXPBgVOo3APfGO79dgEtj5pgVg3EOUgxCTDDPrM3c2Zgw0
 MKdUMyc2C9RJyUMlIi6O9qh8Rwt+N4tC8FDJ7VjfDfSRmZ+v9QF6/tKhiG8F6WiTJTawGwto1SA
 nfpjAmKcyNOYLZQk=
X-Received: by 2002:a17:906:31c1:b0:99c:e38d:e484 with SMTP id
 f1-20020a17090631c100b0099ce38de484mr8243319ejf.6.1695729843253; 
 Tue, 26 Sep 2023 05:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1FMtAT5NOxk0R10M5f5wyXo3v5oqWpVWgoxbYU+jkj6gkqfI90d5XHiEil22f6FMlc6piww==
X-Received: by 2002:a17:906:31c1:b0:99c:e38d:e484 with SMTP id
 f1-20020a17090631c100b0099ce38de484mr8243293ejf.6.1695729842902; 
 Tue, 26 Sep 2023 05:04:02 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 o9-20020a1709062e8900b009ae587ce133sm7652403eji.188.2023.09.26.05.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:04:02 -0700 (PDT)
Date: Tue, 26 Sep 2023 08:03:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Salil Mehta <salil.mehta@opnsrc.net>,
 Salil Mehta <salil.mehta@huawei.com>, Bernhard Beschow <shentey@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 1/7] Update ACPI GED framework to support vcpu
 hot-(un)plug
Message-ID: <20230926080028-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <14ee117df13b08403032eb07843b91e1861228d9.1695697701.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14ee117df13b08403032eb07843b91e1861228d9.1695697701.git.lixianglai@loongson.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 26, 2023 at 05:54:26PM +0800, xianglai li wrote:
> ACPI GED shall be used to convey to the guest kernel about any cpu hot-(un)plug
> events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
> to support CPU hot-(un)plug state and events.
> 
> Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> Cc: "Bernhard Beschow" <shentey@gmail.com>
> Cc: "Salil Mehta" <salil.mehta@huawei.com>
> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>

Same question as I sent on Salil Mehta's patchset.
Is this based on this patchset:
https://lore.kernel.org/qemu-devel/20200613213629.21984-11-salil.mehta@huawei.com/
?

If yes then it looks like you dropped Keqian Zhu.

And the rules for Co-developed-by are:

Co-developed-by: states that the patch was co-created by multiple developers;
it is used to give attribution to co-authors (in addition to the author
attributed by the From: tag) when several people work on a single patch.  Since
Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
followed by a Signed-off-by: of the associated co-author.  Standard sign-off
procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
chronological history of the patch insofar as possible, regardless of whether
the author is attributed via From: or Co-developed-by:.  Notably, the last
Signed-off-by: must always be that of the developer submitting the patch.


but it looks like Keqian Zhu did not sign off on his original patch so
you need to go and get his sign off.



> ---
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++++
>  hw/acpi/cpu.c                          |  7 ------
>  hw/acpi/generic_event_device.c         | 33 ++++++++++++++++++++++++++
>  include/hw/acpi/cpu_hotplug.h          | 10 ++++++++
>  include/hw/acpi/generic_event_device.h |  5 ++++
>  5 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..2aec90d968 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -24,6 +24,12 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>      return;
>  }
>  
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>                        CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
>  {
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 011d2c6c2d..5bad983928 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -7,13 +7,6 @@
>  #include "trace.h"
>  #include "sysemu/numa.h"
>  
> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
> -#define ACPI_CPU_SELECTOR_OFFSET_WR 0
> -#define ACPI_CPU_FLAGS_OFFSET_RW 4
> -#define ACPI_CPU_CMD_OFFSET_WR 5
> -#define ACPI_CPU_CMD_DATA_OFFSET_RW 8
> -#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
> -
>  #define OVMF_CPUHP_SMI_CMD 4
>  
>  enum {
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index a3d31631fe..c5a70957b4 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/cpu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
> @@ -25,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>  };
>  
>  /*
> @@ -117,6 +119,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name("\\_SB.NVDR"),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> +                                             ACPI_CPU_SCAN_METHOD));
> +                break;
>              default:
>                  /*
>                   * Please make sure all the events in ged_supported_events[]
> @@ -234,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>          } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -248,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                         !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -261,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -272,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>      AcpiGedState *s = ACPI_GED(adev);
>  
>      acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>  }
>  
>  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> @@ -286,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_PWR_DOWN_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -318,6 +333,16 @@ static const VMStateDescription vmstate_memhp_state = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_cpuhp_state = {
> +    .name = "acpi-ged/cpuhp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_ged_state = {
>      .name = "acpi-ged-state",
>      .version_id = 1,
> @@ -366,6 +391,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>      },
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_memhp_state,
> +        &vmstate_cpuhp_state,
>          &vmstate_ghes_state,
>          NULL
>      }
> @@ -400,6 +426,13 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    s->cpuhp.device = OBJECT(s);
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>  }
>  
>  static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 3b932abbbb..afee1ab996 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -19,6 +19,16 @@
>  #include "hw/hotplug.h"
>  #include "hw/acpi/cpu.h"
>  
> +#define ACPI_CPU_HOTPLUG_REG_LEN 12
> +#define ACPI_CPU_SELECTOR_OFFSET_WR 0
> +#define ACPI_CPU_FLAGS_OFFSET_RW 4
> +#define ACPI_CPU_CMD_OFFSET_WR 5
> +#define ACPI_CPU_CMD_DATA_OFFSET_RW 8
> +#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
> +
> +#define ACPI_CPU_SCAN_METHOD "CSCN"
> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
> +
>  typedef struct AcpiCpuHotplug {
>      Object *device;
>      MemoryRegion io;
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
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;
> -- 
> 2.39.1



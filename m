Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37077766D9A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 14:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPLvN-00084y-RR; Fri, 28 Jul 2023 07:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPLvD-0007xV-7F
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPLv3-0003HW-JI
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690544763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6c8GnojgukmfKNwTGw1r9pQIJek+LzmheAs9UdwvOA=;
 b=f9CtiJp+sKwW/YRjvNYPo1MZS0vTavzc8Uwz3rDLaRQY4kRadygNM484eoEYYEjSQHCfKN
 MUVSp2HpxPHTYT55HS0AH2bpkvgJsiYqZC/bHTo36PJXy7Hnv16ynANb/DR5x4f621386P
 wEyQy6zUuvuIyYUBHpGV8/CXRQKx3fs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-rjO8bxhgMpqI4QCz6RBWug-1; Fri, 28 Jul 2023 07:46:01 -0400
X-MC-Unique: rjO8bxhgMpqI4QCz6RBWug-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcfdaaa52so121876566b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 04:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690544760; x=1691149560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6c8GnojgukmfKNwTGw1r9pQIJek+LzmheAs9UdwvOA=;
 b=Drm8UKOcD8sRZYDAwrs2qjuqGCjpdIAYdta54TceP/NZGrbx7/daqvfq9bXSV+VTeO
 8aoCfghP3yeNCQ1HuG/YsByXBr4yVDGfzhkXchDw9/iumm6kOFyhMHzQKZB03e0tVdwz
 j57kg6uT/4FQ3YuAuGEfAvdRXLxa5RncGRPTq1HlqKHlNY7AxiGHbBHHIN88x6IQe3Ll
 Y1akMlpqRxPofi8WJCiKJS+Oqf6xG4HWroQRxytRv8B/mLZMPZKmBonCJaArMsusDsXv
 9ygISMABc1r+5qmd2HMHBIYj9Yjzi1quOhQIoQ4Y5bOktA9/ZAWdBONLqAt5CNaYbBq/
 pMVA==
X-Gm-Message-State: ABy/qLZVtX4hvpPjjDzqBB+2GXEUCafii0pLs42oSQjYPTslsZuSVLwR
 WMMTCNPGk5FQDpzBVWcWWj/QcYwR/dOAZRh8Z3vX1RYgM6mY9F391TsVY6F9n82KKa0CHxZoBRF
 N3VurBZBRtAdLrpk=
X-Received: by 2002:a17:906:3010:b0:99b:7f52:ccd5 with SMTP id
 16-20020a170906301000b0099b7f52ccd5mr1829518ejz.10.1690544760419; 
 Fri, 28 Jul 2023 04:46:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnoXXdSFNNWLl4z3XUIzQUgCzymckUNd86DAg2zROvWRvjsgD6p5W6Ke8tS7wbbbDBtiyYQQ==
X-Received: by 2002:a17:906:3010:b0:99b:7f52:ccd5 with SMTP id
 16-20020a170906301000b0099b7f52ccd5mr1829493ejz.10.1690544760063; 
 Fri, 28 Jul 2023 04:46:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 lj24-20020a170906f9d800b0099bca8b9a31sm1959543ejb.100.2023.07.28.04.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 04:45:59 -0700 (PDT)
Date: Fri, 28 Jul 2023 13:45:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song
 Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 1/8] Update ACPI GED framework to support vcpu hot-(un)plug
Message-ID: <20230728134558.5638d66e@imammedo.users.ipa.redhat.com>
In-Reply-To: <4c972421e4a7ad2d7413dd91473c3ae3dc7b6a3c.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <4c972421e4a7ad2d7413dd91473c3ae3dc7b6a3c.1689837093.git.lixianglai@loongson.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 20 Jul 2023 15:15:06 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> ACPI GED shall be used to convey to the guest kernel about any cpu hot-(u=
n)plug
> events. Therefore, existing ACPI GED framework inside QEMU needs to be en=
hanced
> to support CPU hot-(un)plug state and events.

skimmed through, it looks good to me

see nit below

> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++++
>  hw/acpi/cpu.c                          |  7 ------
>  hw/acpi/generic_event_device.c         | 33 ++++++++++++++++++++++++++
>  include/hw/acpi/cpu_hotplug.h          | 10 ++++++++
>  include/hw/acpi/generic_event_device.h |  6 +++++
>  5 files changed, 55 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-s=
tub.c
> index 3fc4b14c26..2aec90d968 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -24,6 +24,12 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACP=
IOSTInfoList ***list)
>      return;
>  }
> =20
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>                        CPUHotplugState *cpu_st, DeviceState *dev, Error *=
*errp)
>  {
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 19c154d78f..6897c8789a 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -6,13 +6,6 @@
>  #include "trace.h"
>  #include "sysemu/numa.h"
> =20
> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
> -#define ACPI_CPU_SELECTOR_OFFSET_WR 0
> -#define ACPI_CPU_FLAGS_OFFSET_RW 4
> -#define ACPI_CPU_CMD_OFFSET_WR 5
> -#define ACPI_CPU_CMD_DATA_OFFSET_RW 8
> -#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
> -
>  #define OVMF_CPUHP_SMI_CMD 4
> =20
>  enum {
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_devic=
e.c
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
> @@ -25,6 +26,7 @@ static const uint32_t ged_supported_events[] =3D {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>  };
> =20
>  /*
> @@ -117,6 +119,10 @@ void build_ged_aml(Aml *table, const char *name, Hot=
plugHandler *hotplug_dev,
>                             aml_notify(aml_name("\\_SB.NVDR"),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> +                                             ACPI_CPU_SCAN_METHOD));
> +                break;
>              default:
>                  /*
>                   * Please make sure all the events in ged_supported_even=
ts[]
> @@ -234,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *h=
otplug_dev,
>          } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported devi=
ce"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -248,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
>      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                         !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))=
) {
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev,=
 errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, er=
rp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported de=
vice"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -261,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplu=
g_dev,
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -272,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, =
ACPIOSTInfoList ***list)
>      AcpiGedState *s =3D ACPI_GED(adev);
> =20
>      acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>  }
> =20
>  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits =
ev)
> @@ -286,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, A=
cpiEventStatusBits ev)
>          sel =3D ACPI_GED_PWR_DOWN_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel =3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel =3D ACPI_GED_CPU_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -318,6 +333,16 @@ static const VMStateDescription vmstate_memhp_state =
=3D {
>      }
>  };
> =20
> +static const VMStateDescription vmstate_cpuhp_state =3D {
> +    .name =3D "acpi-ged/cpuhp",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_ged_state =3D {
>      .name =3D "acpi-ged-state",
>      .version_id =3D 1,
> @@ -366,6 +391,7 @@ static const VMStateDescription vmstate_acpi_ged =3D {
>      },
>      .subsections =3D (const VMStateDescription * []) {
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
> +    s->cpuhp.device =3D OBJECT(s);
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp containe=
r",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>  }
> =20
>  static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 3b932abbbb..afee1ab996 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -19,6 +19,16 @@
>  #include "hw/hotplug.h"
>  #include "hw/acpi/cpu.h"
> =20
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
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/gen=
eric_event_device.h
> index d831bbd889..2923bd9d82 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>  #define HW_ACPI_GENERIC_EVENT_DEVICE_H
> =20
>  #include "hw/sysbus.h"
> +#include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/ghes.h"
>  #include "qom/object.h"
> @@ -70,6 +71,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> =20
>  #define TYPE_ACPI_GED_X86 "acpi-ged-x86"

> +#define TYPE_ACPI_GED_LOONGARCH "acpi-ged-loongarch"
where is it used?
If it's for later patches, it should be in the patch that
will actually use it=20

> =20
>  #define ACPI_GED_EVT_SEL_OFFSET    0x0
>  #define ACPI_GED_EVT_SEL_LEN       0x4
> @@ -97,6 +99,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> =20
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -108,6 +111,9 @@ struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
>      MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
> +    AcpiCpuHotplug cpuhp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;



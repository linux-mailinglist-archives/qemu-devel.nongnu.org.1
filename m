Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6629576AA8C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 10:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQkQT-0000tL-JT; Tue, 01 Aug 2023 04:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qQkQR-0000t4-5M
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 04:08:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qQkQM-0008O9-0w
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 04:08:14 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxFvFivchk4_gNAA--.32920S3;
 Tue, 01 Aug 2023 16:08:02 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ8xhvchkd7hDAA--.4801S3; 
 Tue, 01 Aug 2023 16:08:01 +0800 (CST)
Subject: Re: [PATCH 1/8] Update ACPI GED framework to support vcpu hot-(un)plug
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <4c972421e4a7ad2d7413dd91473c3ae3dc7b6a3c.1689837093.git.lixianglai@loongson.cn>
 <20230728134558.5638d66e@imammedo.users.ipa.redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <2938d2cc-c18f-f66f-46af-8a159a317d53@loongson.cn>
Date: Tue, 1 Aug 2023 16:08:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230728134558.5638d66e@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxJ8xhvchkd7hDAA--.4801S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3JF48Cw15Xw48Gr4xWrW3urX_yoWDGr1fpF
 yqvFWakrWDJr47Ca1Sqr9xta4DGw48CrWxKrWvyrnFy3WUWw13tF10gF45KFyrJFZ5Wa1U
 A3Wqqr9Yvw4SqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
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

Hi, Igor Mammedov :

On 7/28/23 7:45 PM, Igor Mammedov wrote:
> On Thu, 20 Jul 2023 15:15:06 +0800
> xianglai li <lixianglai@loongson.cn> wrote:
>
>> ACPI GED shall be used to convey to the guest kernel about any cpu hot-(un)plug
>> events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
>> to support CPU hot-(un)plug state and events.
> skimmed through, it looks good to me
>
> see nit below
>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Ani Sinha <anisinha@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Yanan Wang <wangyanan55@huawei.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++++
>>   hw/acpi/cpu.c                          |  7 ------
>>   hw/acpi/generic_event_device.c         | 33 ++++++++++++++++++++++++++
>>   include/hw/acpi/cpu_hotplug.h          | 10 ++++++++
>>   include/hw/acpi/generic_event_device.h |  6 +++++
>>   5 files changed, 55 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
>> index 3fc4b14c26..2aec90d968 100644
>> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
>> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
>> @@ -24,6 +24,12 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>>       return;
>>   }
>>   
>> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>> +                         CPUHotplugState *state, hwaddr base_addr)
>> +{
>> +    return;
>> +}
>> +
>>   void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>>                         CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
>>   {
>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>> index 19c154d78f..6897c8789a 100644
>> --- a/hw/acpi/cpu.c
>> +++ b/hw/acpi/cpu.c
>> @@ -6,13 +6,6 @@
>>   #include "trace.h"
>>   #include "sysemu/numa.h"
>>   
>> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
>> -#define ACPI_CPU_SELECTOR_OFFSET_WR 0
>> -#define ACPI_CPU_FLAGS_OFFSET_RW 4
>> -#define ACPI_CPU_CMD_OFFSET_WR 5
>> -#define ACPI_CPU_CMD_DATA_OFFSET_RW 8
>> -#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
>> -
>>   #define OVMF_CPUHP_SMI_CMD 4
>>   
>>   enum {
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index a3d31631fe..c5a70957b4 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -12,6 +12,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "hw/acpi/acpi.h"
>> +#include "hw/acpi/cpu.h"
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "hw/irq.h"
>>   #include "hw/mem/pc-dimm.h"
>> @@ -25,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>>       ACPI_GED_MEM_HOTPLUG_EVT,
>>       ACPI_GED_PWR_DOWN_EVT,
>>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
>> +    ACPI_GED_CPU_HOTPLUG_EVT,
>>   };
>>   
>>   /*
>> @@ -117,6 +119,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>>                              aml_notify(aml_name("\\_SB.NVDR"),
>>                                         aml_int(0x80)));
>>                   break;
>> +            case ACPI_GED_CPU_HOTPLUG_EVT:
>> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
>> +                                             ACPI_CPU_SCAN_METHOD));
>> +                break;
>>               default:
>>                   /*
>>                    * Please make sure all the events in ged_supported_events[]
>> @@ -234,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>>           } else {
>>               acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>>           }
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>>       } else {
>>           error_setg(errp, "virt: device plug request for unsupported device"
>>                      " type: %s", object_get_typename(OBJECT(dev)));
>> @@ -248,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>>       if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>>                          !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>>           acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>>       } else {
>>           error_setg(errp, "acpi: device unplug request for unsupported device"
>>                      " type: %s", object_get_typename(OBJECT(dev)));
>> @@ -261,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>>   
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>           acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>>       } else {
>>           error_setg(errp, "acpi: device unplug for unsupported device"
>>                      " type: %s", object_get_typename(OBJECT(dev)));
>> @@ -272,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>>       AcpiGedState *s = ACPI_GED(adev);
>>   
>>       acpi_memory_ospm_status(&s->memhp_state, list);
>> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>>   }
>>   
>>   static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>> @@ -286,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>>           sel = ACPI_GED_PWR_DOWN_EVT;
>>       } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>>       } else {
>>           /* Unknown event. Return without generating interrupt. */
>>           warn_report("GED: Unsupported event %d. No irq injected", ev);
>> @@ -318,6 +333,16 @@ static const VMStateDescription vmstate_memhp_state = {
>>       }
>>   };
>>   
>> +static const VMStateDescription vmstate_cpuhp_state = {
>> +    .name = "acpi-ged/cpuhp",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static const VMStateDescription vmstate_ged_state = {
>>       .name = "acpi-ged-state",
>>       .version_id = 1,
>> @@ -366,6 +391,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>>       },
>>       .subsections = (const VMStateDescription * []) {
>>           &vmstate_memhp_state,
>> +        &vmstate_cpuhp_state,
>>           &vmstate_ghes_state,
>>           NULL
>>       }
>> @@ -400,6 +426,13 @@ static void acpi_ged_initfn(Object *obj)
>>       memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>>                             TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>>       sysbus_init_mmio(sbd, &ged_st->regs);
>> +
>> +    s->cpuhp.device = OBJECT(s);
>> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
>> +                       ACPI_CPU_HOTPLUG_REG_LEN);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
>> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>> +                        &s->cpuhp_state, 0);
>>   }
>>   
>>   static void acpi_ged_class_init(ObjectClass *class, void *data)
>> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
>> index 3b932abbbb..afee1ab996 100644
>> --- a/include/hw/acpi/cpu_hotplug.h
>> +++ b/include/hw/acpi/cpu_hotplug.h
>> @@ -19,6 +19,16 @@
>>   #include "hw/hotplug.h"
>>   #include "hw/acpi/cpu.h"
>>   
>> +#define ACPI_CPU_HOTPLUG_REG_LEN 12
>> +#define ACPI_CPU_SELECTOR_OFFSET_WR 0
>> +#define ACPI_CPU_FLAGS_OFFSET_RW 4
>> +#define ACPI_CPU_CMD_OFFSET_WR 5
>> +#define ACPI_CPU_CMD_DATA_OFFSET_RW 8
>> +#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
>> +
>> +#define ACPI_CPU_SCAN_METHOD "CSCN"
>> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
>> +
>>   typedef struct AcpiCpuHotplug {
>>       Object *device;
>>       MemoryRegion io;
>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>> index d831bbd889..2923bd9d82 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -60,6 +60,7 @@
>>   #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>>   
>>   #include "hw/sysbus.h"
>> +#include "hw/acpi/cpu_hotplug.h"
>>   #include "hw/acpi/memory_hotplug.h"
>>   #include "hw/acpi/ghes.h"
>>   #include "qom/object.h"
>> @@ -70,6 +71,7 @@
>>   OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   
>>   #define TYPE_ACPI_GED_X86 "acpi-ged-x86"
>> +#define TYPE_ACPI_GED_LOONGARCH "acpi-ged-loongarch"
> where is it used?
> If it's for later patches, it should be in the patch that
> will actually use it

Yes, it will be used in a later patch,

and I will modify its location in the next patch release.

>
>>   
>>   #define ACPI_GED_EVT_SEL_OFFSET    0x0
>>   #define ACPI_GED_EVT_SEL_LEN       0x4
>> @@ -97,6 +99,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>>   
>>   typedef struct GEDState {
>>       MemoryRegion evt;
>> @@ -108,6 +111,9 @@ struct AcpiGedState {
>>       SysBusDevice parent_obj;
>>       MemHotplugState memhp_state;
>>       MemoryRegion container_memhp;
>> +    CPUHotplugState cpuhp_state;
>> +    MemoryRegion container_cpuhp;
>> +    AcpiCpuHotplug cpuhp;
>>       GEDState ged_state;
>>       uint32_t ged_event_bitmap;
>>       qemu_irq irq;

Thanks.

xianglai



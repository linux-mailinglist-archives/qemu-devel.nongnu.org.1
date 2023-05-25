Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB5710C2B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2A8i-0008Dh-AM; Thu, 25 May 2023 08:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q2A8f-0008Cc-IS; Thu, 25 May 2023 08:32:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1q2A8c-0005ZP-Ky; Thu, 25 May 2023 08:32:17 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8CxZ_FIVW9kmv0AAA--.2598S3;
 Thu, 25 May 2023 20:32:08 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx671GVW9klHh3AA--.539S3; 
 Thu, 25 May 2023 20:32:06 +0800 (CST)
Subject: Re: [PATCH v1 2/3] memory-device: Factor out device memory
 initialization into memory_devices_init()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230523185144.533592-1-david@redhat.com>
 <20230523185144.533592-3-david@redhat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <fd275a97-aac9-706c-004e-afdd2ac833f8@loongson.cn>
Date: Thu, 25 May 2023 20:32:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230523185144.533592-3-david@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx671GVW9klHh3AA--.539S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr45Aw1xWF1UXF4UGw4rKrg_yoWfGF4UpF
 yxAF95Gr1YgrnxGwn7ur1DWa48Gw10k3WrWFyxCrWv9Fn7Wr98Crykt3y8t3y8A39IqF15
 XFyDJF1xX3WYq3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
 e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
 6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
 026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
 0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
 vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
 6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/5/24 ÉÏÎç2:51, David Hildenbrand Ð´µÀ:
> Let's factor the common setup out, to prepare for further changes.
>
> On arm64, we'll add the subregion to system RAM now earlier -- which
> shouldn't matter, because the system RAM memory region should already be
> alive at that point.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/arm/virt.c                  |  9 +--------
>   hw/i386/pc.c                   | 17 ++++++-----------
>   hw/loongarch/virt.c            | 14 ++++----------
>   hw/mem/memory-device.c         | 20 ++++++++++++++++++++
>   hw/ppc/spapr.c                 | 15 ++++++---------
>   include/hw/mem/memory-device.h |  2 ++
>   6 files changed, 39 insertions(+), 38 deletions(-)
For LoongArch

Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b99ae18501..284f45d998 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1816,10 +1816,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>       virt_set_high_memmap(vms, base, pa_bits);
>   
>       if (device_memory_size > 0) {
> -        ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
> -        ms->device_memory->base = device_memory_base;
> -        memory_region_init(&ms->device_memory->mr, OBJECT(vms),
> -                           "device-memory", device_memory_size);
> +        memory_devices_init(ms, device_memory_base, device_memory_size);
>       }
>   }
>   
> @@ -2260,10 +2257,6 @@ static void machvirt_init(MachineState *machine)
>   
>       memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
>                                   machine->ram);
> -    if (machine->device_memory) {
> -        memory_region_add_subregion(sysmem, machine->device_memory->base,
> -                                    &machine->device_memory->mr);
> -    }
>   
>       virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
>   
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb62c994fa..9d215df92e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1039,13 +1039,11 @@ void pc_memory_init(PCMachineState *pcms,
>           exit(EXIT_FAILURE);
>       }
>   
> -    /* always allocate the device memory information */
> -    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
> -
>       /* initialize device memory address space */
>       if (pcmc->has_reserved_memory &&
>           (machine->ram_size < machine->maxram_size)) {
>           ram_addr_t device_mem_size;
> +        hwaddr device_mem_base;
>   
>           if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>               error_report("unsupported amount of memory slots: %"PRIu64,
> @@ -1060,19 +1058,16 @@ void pc_memory_init(PCMachineState *pcms,
>               exit(EXIT_FAILURE);
>           }
>   
> -        pc_get_device_memory_range(pcms, &machine->device_memory->base, &device_mem_size);
> +        pc_get_device_memory_range(pcms, &device_mem_base, &device_mem_size);
>   
> -        if ((machine->device_memory->base + device_mem_size) <
> -            device_mem_size) {
> +        if (device_mem_base + device_mem_size < device_mem_size) {
>               error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
>                            machine->maxram_size);
>               exit(EXIT_FAILURE);
>           }
> -
> -        memory_region_init(&machine->device_memory->mr, OBJECT(pcms),
> -                           "device-memory", device_mem_size);
> -        memory_region_add_subregion(system_memory, machine->device_memory->base,
> -                                    &machine->device_memory->mr);
> +        memory_devices_init(machine, device_mem_base, device_mem_size);
> +    } else {
> +        memory_devices_init(machine, 0, 0);
>       }
>   
>       if (pcms->cxl_devices_state.is_enabled) {
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 2b7588e32a..2ccc90feb4 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -45,7 +45,7 @@
>   #include "sysemu/block-backend.h"
>   #include "hw/block/flash.h"
>   #include "qemu/error-report.h"
> -
> +#include "hw/mem/memory-device.h"
>   
>   static void virt_flash_create(LoongArchMachineState *lams)
>   {
> @@ -804,8 +804,8 @@ static void loongarch_init(MachineState *machine)
>   
>       /* initialize device memory address space */
>       if (machine->ram_size < machine->maxram_size) {
> -        machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
>           ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
> +        hwaddr device_mem_base;
>   
>           if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>               error_report("unsupported amount of memory slots: %"PRIu64,
> @@ -820,14 +820,8 @@ static void loongarch_init(MachineState *machine)
>               exit(EXIT_FAILURE);
>           }
>           /* device memory base is the top of high memory address. */
> -        machine->device_memory->base = 0x90000000 + highram_size;
> -        machine->device_memory->base =
> -            ROUND_UP(machine->device_memory->base, 1 * GiB);
> -
> -        memory_region_init(&machine->device_memory->mr, OBJECT(lams),
> -                           "device-memory", device_mem_size);
> -        memory_region_add_subregion(address_space_mem, machine->device_memory->base,
> -                                    &machine->device_memory->mr);
> +        device_mem_base = ROUND_UP(0x90000000 + highram_size, 1 * GiB);
> +        memory_devices_init(machine, device_mem_base, device_mem_size);
>       }
>   
>       /* Add isa io region */
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 6c025b02c1..d99ceb621a 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -17,6 +17,7 @@
>   #include "qemu/range.h"
>   #include "hw/virtio/vhost.h"
>   #include "sysemu/kvm.h"
> +#include "exec/address-spaces.h"
>   #include "trace.h"
>   
>   static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
> @@ -333,6 +334,25 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
>       return memory_region_size(mr);
>   }
>   
> +void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
> +{
> +    g_assert(!ms->device_memory);
> +    ms->device_memory = g_new0(DeviceMemoryState, 1);
> +    ms->device_memory->base = base;
> +
> +    /*
> +     * See memory_device_get_free_addr(): An empty device memory region
> +     * means "this machine supports memory devices, but they are not enabled".
> +     */
> +    if (size > 0) {
> +        memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
> +                           size);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    ms->device_memory->base,
> +                                    &ms->device_memory->mr);
> +    }
> +}
> +
>   static const TypeInfo memory_device_info = {
>       .name          = TYPE_MEMORY_DEVICE,
>       .parent        = TYPE_INTERFACE,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1baea16c96..d66dc00ea5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2866,12 +2866,11 @@ static void spapr_machine_init(MachineState *machine)
>       /* map RAM */
>       memory_region_add_subregion(sysmem, 0, machine->ram);
>   
> -    /* always allocate the device memory information */
> -    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
> -
>       /* initialize hotplug memory address space */
>       if (machine->ram_size < machine->maxram_size) {
>           ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
> +        hwaddr device_mem_base;
> +
>           /*
>            * Limit the number of hotpluggable memory slots to half the number
>            * slots that KVM supports, leaving the other half for PCI and other
> @@ -2890,12 +2889,10 @@ static void spapr_machine_init(MachineState *machine)
>               exit(1);
>           }
>   
> -        machine->device_memory->base = ROUND_UP(machine->ram_size,
> -                                                SPAPR_DEVICE_MEM_ALIGN);
> -        memory_region_init(&machine->device_memory->mr, OBJECT(spapr),
> -                           "device-memory", device_mem_size);
> -        memory_region_add_subregion(sysmem, machine->device_memory->base,
> -                                    &machine->device_memory->mr);
> +        device_mem_base = ROUND_UP(machine->ram_size, SPAPR_DEVICE_MEM_ALIGN);
> +        memory_devices_init(machine, device_mem_base, device_mem_size);
> +    } else {
> +        memory_devices_init(machine, 0, 0);
>       }
>   
>       if (smc->dr_lmb_enabled) {
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index 48d2611fc5..6e8a10e2f5 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -16,6 +16,7 @@
>   #include "hw/qdev-core.h"
>   #include "qapi/qapi-types-machine.h"
>   #include "qom/object.h"
> +#include "exec/hwaddr.h"
>   
>   #define TYPE_MEMORY_DEVICE "memory-device"
>   
> @@ -113,5 +114,6 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
>   void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
>   uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
>                                          Error **errp);
> +void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
>   
>   #endif



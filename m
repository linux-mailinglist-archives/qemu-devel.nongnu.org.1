Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7F7B1067
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 03:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlfxs-00057F-B6; Wed, 27 Sep 2023 21:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qlfxp-000571-8V
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:37:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qlfxl-0003cN-Kx
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:37:13 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxJvG72BRl7qAtAA--.21978S3;
 Thu, 28 Sep 2023 09:36:59 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxT92z2BRlo98UAA--.2301S2; 
 Thu, 28 Sep 2023 09:36:53 +0800 (CST)
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
 <54482e7486564d68926ded075ebe8c6f@huawei.com>
 <55beb69e-0adf-1bea-89ef-ebc4dabed673@loongson.cn>
 <20230927111651-mutt-send-email-mst@kernel.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <8fd972ff-bdbf-1ddd-073e-eabf5a565311@loongson.cn>
Date: Thu, 28 Sep 2023 09:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230927111651-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxT92z2BRlo98UAA--.2301S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJrW7tF1Duw15Xw4xtFyUXFc_yoW8Jw4fCo
 WFyr17Zw4rtr1UJF1DA3sxJ3W7tw1kKr45AryUKw15CF45t3WUAr1UJry8JFW3JF1UCrW7
 JFyUJ342kF9rX3W3l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUO07kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
 xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
 I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UU
 UUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Hi Michael S. Tsirkin:
> On Tue, Sep 26, 2023 at 08:49:27PM +0800, lixianglai wrote:
>> Hi Salil Mehta via  And Michael S. Tsirkin:
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Tuesday, September 26, 2023 12:54 PM
>>>> To: Salil Mehta <salil.mehta@huawei.com>
>>>> Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
>>>> Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan
>>>> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
>>>> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
>>>> Bonzini <pbonzini@redhat.com>; Richard Henderson
>>>> <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
>>>> Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
>>>> <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
>>>> Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
>>>> Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
>>>> Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
>>>>
>>>> On Tue, Sep 26, 2023 at 11:45:19AM +0000, Salil Mehta wrote:
>>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>>> Sent: Tuesday, September 26, 2023 12:12 PM
>>>>>> To: Salil Mehta <salil.mehta@huawei.com>
>>>>>> Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org;
>>>> Bernhard
>>>>>> Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>;
>>>> Xiaojuan
>>>>>> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
>>>>>> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
>>>>>> Bonzini <pbonzini@redhat.com>; Richard Henderson
>>>>>> <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
>>>>>> Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
>>>>>> <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
>>>>>> Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
>>>>>> Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
>>>>>> Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
>>>>>>
>>>>>> On Tue, Sep 26, 2023 at 10:49:08AM +0000, Salil Mehta wrote:
>>>>>>> Hi Xianglai,
>>>>>>> FYI. RFC V2 is out and you can now drop the arch agnostic patches
>>>> from
>>>>>>> your patch-set. Please check the details in the cover letter which
>>>> one
>>>>>>> you need to pick and rebase from:
>>>>>>>
>>>>>>> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
>>>>>> salil.mehta@huawei.com/T/#t
>>>>>>> I am planning to float the architecture agnostic patch-set within
>>>> this
>>>>>>> week which will have same patches and in same order as mentioned in
>>>>>>> the cover letter. This will untie the development across different
>>>>>>> architectures.
>>>>>>>
>>>>>>> Many thanks
>>>>>>> Salil.
>>>>>> However, please get authorship info right. This claims patch has been
>>>>>> codeveloped by Bernhard Beschow, xianglai li and yourself.
>>>>>> Your patch claims a completely different list of authors
>>>>> Yes, because those are the people who have developed the patches.
>>>>>
>>>>>> with yourself being the only common author.
>>>>>> Not nice.
>>>>> I have already replied in the other thread. This patch has been
>>>>> taken from the ARM patch-set sent in the year 2020.
>>>>>
>>>>> I am not sure who is the other author and how he has contributed.
>>>>>
>>>>> Co-developed-by usually points at main authors.
>>>>>
>>>> If you are not sure then find out please.
>>> We really have not collaborated on anything as part of
>>> this entire development of virtual CPU hotplug since the
>>> year 2020?
>>>
>>> I would leave it to Xianglai to answer about the person.
>>>
>> I did not participate in the hot swap of arm virtualized cpu.
>>
>> I just referred to the patch sent by Salil Mehta to the community.
>>
>> Since his patch has not been integrated into qemu's code repository,
>>
>> I referred to Salil Mehta's patch to ensure that my code could run.
>>
>> I added Co-developed-by in order to show respect for the achievements of his
>> labor,
>>
>> which is all my fault. I wrongly used Co-developed-by, and I apologize for
>> that.
>>
>> I will delete the first two patches until the unrelated patches in Salil
>> Mehta's architecture are combined,
>>
>> and then submit my own patch.
>>
>>
>> Thanks,
>>
>> Xianglai.
> I see. The correct way is to simply keep the original author.
> I don't know what you used to apply the patch but e.g. git am
> will do exactly that for you.
> Add your own S.O.B at the bottom and you are all set.


Oh, I see.

Thank you very much,

Xianglai.


>
>>>> And to help you stop guessing at the rules:
>>>>
>>>> Documentation/process/submitting-patches.rst
>>>>
>>>> 	Co-developed-by: states that the patch was co-created by multiple
>>>> developers;
>>>> 	it is used to give attribution to co-authors (in addition to the
>>>> author
>>>> 	attributed by the From: tag) when several people work on a single
>>>> patch.  Since
>>>> 	Co-developed-by: denotes authorship, every Co-developed-by: must be
>>>> immediately
>>>> 	followed by a Signed-off-by: of the associated co-author.  Standard
>>>> sign-off
>>>> 	procedure applies, i.e. the ordering of Signed-off-by: tags should
>>>> reflect the
>>>> 	chronological history of the patch insofar as possible, regardless of
>>>> whether
>>>> 	the author is attributed via From: or Co-developed-by:.  Notably, the
>>>> last
>>>> 	Signed-off-by: must always be that of the developer submitting the
>>>> patch.
>>> Sure, ARM patch-set follows exactly above rules.
>>>
>>>
>>>
>>>>>>>> From: xianglai li <lixianglai@loongson.cn>
>>>>>>>> Sent: Tuesday, September 26, 2023 10:54 AM
>>>>>>>> To: qemu-devel@nongnu.org
>>>>>>>> Cc: Bernhard Beschow <shentey@gmail.com>; Salil Mehta
>>>>>>>> <salil.mehta@opnsrc.net>; Salil Mehta <salil.mehta@huawei.com>;
>>>>>> Xiaojuan
>>>>>>>> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>;
>>>>>> Michael S.
>>>>>>>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani
>>>>>> Sinha
>>>>>>>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>>>>>>>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>>>>>>>> <eduardo@habkost.net>; Marcel Apfelbaum
>>>> <marcel.apfelbaum@gmail.com>;
>>>>>>>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>>>>>>>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>;
>>>>>> Peter
>>>>>>>> Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bibo
>>>> Mao
>>>>>>>> <maobibo@loongson.cn>
>>>>>>>> Subject: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
>>>>>>>>
>>>>>>>> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch
>>>>>>>> is based on PCI and is IO port based and hence existing cpus AML
>>>> code
>>>>>>>> assumes _CRS objects would evaluate to a system resource which
>>>>>> describes
>>>>>>>> IO Port address.
>>>>>>>> But on Loongarch arch CPUs control device(\\_SB.PRES) register
>>>>>> interface
>>>>>>>> is memory-mapped hence _CRS object should evaluate to system
>>>> resource
>>>>>>>> which describes memory-mapped base address.
>>>>>>>>
>>>>>>>> This cpus AML code change updates the existing interface of the
>>>> build
>>>>>> cpus
>>>>>>>> AML
>>>>>>>> function to accept both IO/MEMORY type regions and update the _CRS
>>>>>> object
>>>>>>>> correspondingly.
>>>>>>>>
>>>>>>>> Co-authored-by: "Bernhard Beschow" <shentey@gmail.com>
>>>>>>>> Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
>>>>>>>> Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
>>>>>>>> Cc: "Bernhard Beschow" <shentey@gmail.com>
>>>>>>>> Cc: "Salil Mehta" <salil.mehta@huawei.com>
>>>>>>>> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
>>>>>>>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>>>>>>>> Cc: Song Gao <gaosong@loongson.cn>
>>>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>>>>>> Cc: Ani Sinha <anisinha@redhat.com>
>>>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>>>>>>> Cc: Eduardo Habkost <eduardo@habkost.net>
>>>>>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>>>>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>>>>>>>> Cc: Yanan Wang <wangyanan55@huawei.com>
>>>>>>>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>>>>>>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>>>>>>>> ---
>>>>>>>>    hw/acpi/cpu.c         | 20 +++++++++++++++-----
>>>>>>>>    hw/i386/acpi-build.c  |  3 ++-
>>>>>>>>    include/hw/acpi/cpu.h |  5 +++--
>>>>>>>>    3 files changed, 20 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>>>>>>>> index 5bad983928..0afa04832e 100644
>>>>>>>> --- a/hw/acpi/cpu.c
>>>>>>>> +++ b/hw/acpi/cpu.c
>>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>>    #include "qapi/qapi-events-acpi.h"
>>>>>>>>    #include "trace.h"
>>>>>>>>    #include "sysemu/numa.h"
>>>>>>>> +#include "hw/acpi/cpu_hotplug.h"
>>>>>>>>
>>>>>>>>    #define OVMF_CPUHP_SMI_CMD 4
>>>>>>>>
>>>>>>>> @@ -332,9 +333,10 @@ const VMStateDescription vmstate_cpu_hotplug =
>>>> {
>>>>>>>>    #define CPU_FW_EJECT_EVENT "CEJF"
>>>>>>>>
>>>>>>>>    void build_cpus_aml(Aml *table, MachineState *machine,
>>>>>> CPUHotplugFeatures
>>>>>>>> opts,
>>>>>>>> -                    build_madt_cpu_fn build_madt_cpu, hwaddr
>>>> io_base,
>>>>>>>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr
>>>>>> mmap_io_base,
>>>>>>>>                        const char *res_root,
>>>>>>>> -                    const char *event_handler_method)
>>>>>>>> +                    const char *event_handler_method,
>>>>>>>> +                    AmlRegionSpace rs)
>>>>>>>>    {
>>>>>>>>        Aml *ifctx;
>>>>>>>>        Aml *field;
>>>>>>>> @@ -359,14 +361,22 @@ void build_cpus_aml(Aml *table, MachineState
>>>>>>>> *machine, CPUHotplugFeatures opts,
>>>>>>>>            aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>>>>>>>>
>>>>>>>>            crs = aml_resource_template();
>>>>>>>> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
>>>>>>>> +        if (rs == AML_SYSTEM_IO) {
>>>>>>>> +            aml_append(crs, aml_io(AML_DECODE16, mmap_io_base,
>>>>>>>> mmap_io_base, 1,
>>>>>>>>                                   ACPI_CPU_HOTPLUG_REG_LEN));
>>>>>>>> +        } else {
>>>>>>>> +            aml_append(crs, aml_memory32_fixed(mmap_io_base,
>>>>>>>> +                               ACPI_CPU_HOTPLUG_REG_LEN,
>>>>>> AML_READ_WRITE));
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>>            aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
>>>>>>>>
>>>>>>>> +        g_assert(rs == AML_SYSTEM_IO || rs == AML_SYSTEM_MEMORY);
>>>>>>>>            /* declare CPU hotplug MMIO region with related access
>>>> fields
>>>>>> */
>>>>>>>>            aml_append(cpu_ctrl_dev,
>>>>>>>> -            aml_operation_region("PRST", AML_SYSTEM_IO,
>>>>>> aml_int(io_base),
>>>>>>>> -                                 ACPI_CPU_HOTPLUG_REG_LEN));
>>>>>>>> +            aml_operation_region("PRST", rs,
>>>>>>>> +                                         aml_int(mmap_io_base),
>>>>>>>> +
>>>> ACPI_CPU_HOTPLUG_REG_LEN));
>>>>>>>>            field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
>>>>>>>>                              AML_WRITE_AS_ZEROS);
>>>>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>>>>>> index 863a939210..7016205d15 100644
>>>>>>>> --- a/hw/i386/acpi-build.c
>>>>>>>> +++ b/hw/i386/acpi-build.c
>>>>>>>> @@ -1550,7 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker
>>>>>> *linker,
>>>>>>>>                .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>>>>>>>>            };
>>>>>>>>            build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
>>>>>>>> -                       pm->cpu_hp_io_base, "\\_SB.PCI0",
>>>>>> "\\_GPE._E02");
>>>>>>>> +                       pm->cpu_hp_io_base, "\\_SB.PCI0",
>>>>>> "\\_GPE._E02",
>>>>>>>> +                       AML_SYSTEM_IO);
>>>>>>>>        }
>>>>>>>>
>>>>>>>>        if (pcms->memhp_io_base && nr_mem) {
>>>>>>>> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
>>>>>>>> index bc901660fb..601f644e57 100644
>>>>>>>> --- a/include/hw/acpi/cpu.h
>>>>>>>> +++ b/include/hw/acpi/cpu.h
>>>>>>>> @@ -60,9 +60,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const
>>>>>>>> CPUArchIdList *apic_ids,
>>>>>>>>                                      GArray *entry, bool
>>>> force_enabled);
>>>>>>>>    void build_cpus_aml(Aml *table, MachineState *machine,
>>>>>> CPUHotplugFeatures
>>>>>>>> opts,
>>>>>>>> -                    build_madt_cpu_fn build_madt_cpu, hwaddr
>>>> io_base,
>>>>>>>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr
>>>>>> mmap_io_base,
>>>>>>>>                        const char *res_root,
>>>>>>>> -                    const char *event_handler_method);
>>>>>>>> +                    const char *event_handler_method,
>>>>>>>> +                    AmlRegionSpace rs);
>>>>>>>>
>>>>>>>>    void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList
>>>>>>>> ***list);
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.39.1
>>>>>>>>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D35AF1105
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 12:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuGv-00057T-AB; Wed, 02 Jul 2025 06:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uWuGs-000576-PX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:00:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uWuGq-000106-7w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:00:54 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxquBRA2VoSCIhAQ--.31500S3;
 Wed, 02 Jul 2025 18:00:49 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxVOROA2Vo848GAA--.37516S3;
 Wed, 02 Jul 2025 18:00:48 +0800 (CST)
Subject: Re: [PATCH v3 2/9] hw/loongarch: add virt feature avecintc support
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-3-gaosong@loongson.cn>
 <ab746c92-492b-fb47-c5f4-df04da478a85@loongson.cn>
 <3bf9c6c4-60f4-a405-a779-bb297f03dcc7@loongson.cn>
 <491df489-fa1b-fd07-7a85-3cc86175d85c@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8dfde1d8-021f-bf5a-7bd8-f634043b8880@loongson.cn>
Date: Wed, 2 Jul 2025 18:03:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <491df489-fa1b-fd07-7a85-3cc86175d85c@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxVOROA2Vo848GAA--.37516S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4DJr1xurWktw1rZFWfXrc_yoWfAF45pr
 1kJFWUAry5Jrn5Xr12gr1UXr98tr1Ut3WDXr48XFy8Jr4DJr1Ygr1UXr1qgF1DAr4kJr18
 Xr18JrnxZF17XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07j0sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2025/7/2 下午5:46, Bibo Mao 写道:
>
>
> On 2025/7/2 下午3:10, gaosong wrote:
>> 在 2025/7/2 上午10:03, Bibo Mao 写道:
>>>
>>>
>>> On 2025/6/27 上午11:01, Song Gao wrote:
>>>> LoongArchVirtMachinState adds avecintc features, and
>>>> it use to check whether virt machine support advance interrupt 
>>>> controller
>>>> and default set avecintc = ON_OFF_AUTO_ON.
>>>> LoongArchVirtMachineState adds misc_feature and misc_status for
>>>> misc fetures and status. and set default avec feture bit.
>>>>
>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>> ---
>>>>   hw/loongarch/virt.c         | 43 
>>>> +++++++++++++++++++++++++++++++++----
>>>>   include/hw/loongarch/virt.h | 15 +++++++++++++
>>>>   2 files changed, 54 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>>> index 6a169d4824..426eaaef84 100644
>>>> --- a/hw/loongarch/virt.c
>>>> +++ b/hw/loongarch/virt.c
>>>> @@ -47,6 +47,28 @@
>>>>   #include "hw/virtio/virtio-iommu.h"
>>>>   #include "qemu/error-report.h"
>>>>   +static void virt_get_avecintc(Object *obj, Visitor *v, const 
>>>> char *name,
>>>> +                             void *opaque, Error **errp)
>>>> +{
>>>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>>>> +    OnOffAuto avecintc = lvms->avecintc;
>>>> +
>>>> +    visit_type_OnOffAuto(v, name, &avecintc, errp);
>>>> +
>>>> +}
>>>> +static void virt_set_avecintc(Object *obj, Visitor *v, const char 
>>>> *name,
>>>> +                              void *opaque, Error **errp)
>>>> +{
>>>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>>>> +
>>>> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>>>> +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
>>>> +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
>>>> +    }
>>>> +
>>>> +    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
>>> It is a little strange that firstly check variable and then set it, 
>>> I think that visit_type_OnOffAuto() should be before
>>>  +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>>>  +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
>>>  +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
>>>  +    }
>>>
>>>> +}
>>>> +
>>>>   static void virt_get_veiointc(Object *obj, Visitor *v, const char 
>>>> *name,
>>>>                                 void *opaque, Error **errp)
>>>>   {
>>>> @@ -539,6 +561,10 @@ static MemTxResult virt_iocsr_misc_write(void 
>>>> *opaque, hwaddr addr,
>>>>               return MEMTX_OK;
>>>>           }
>>>>   +        if (val & BIT(IOCSRM_AVEC_EN)) {
>>>> +            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
>>>> +        }
>>>> +
>>>>           features = address_space_ldl(&lvms->as_iocsr,
>>>>                                        EXTIOI_VIRT_BASE + 
>>>> EXTIOI_VIRT_CONFIG,
>>>>                                        attrs, NULL);
>>>> @@ -574,8 +600,9 @@ static MemTxResult virt_iocsr_misc_read(void 
>>>> *opaque, hwaddr addr,
>>>>           break;
>>>>       case FEATURE_REG:
>>>>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | 
>>>> BIT(IOCSRF_CSRIPI);
>>>> -        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
>>>> -        ret |= BIT(IOCSRF_AVEC);
>>>> +        if (virt_is_avecintc_enabled(lvms)) {
>>>> +            ret |= BIT(IOCSRF_AVEC);
>>>> +        }
>>>>           if (kvm_enabled()) {
>>>>               ret |= BIT(IOCSRF_VM);
>>>>           }
>>>> @@ -605,8 +632,10 @@ static MemTxResult virt_iocsr_misc_read(void 
>>>> *opaque, hwaddr addr,
>>>>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>>>>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>>>>           }
>>>> -        /* enable avec default */
>>>> -        ret |= BIT_ULL(IOCSRM_AVEC_EN);
>>>> +        if (virt_is_avecintc_enabled(lvms) &&
>>>> +            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
>>>> +            ret |= BIT_ULL(IOCSRM_AVEC_EN);
>>>> +        }
>>>>           break;
>>>>       default:
>>>>           g_assert_not_reached();
>>>> @@ -850,6 +879,8 @@ static void virt_initfn(Object *obj)
>>>>       if (tcg_enabled()) {
>>>>           lvms->veiointc = ON_OFF_AUTO_OFF;
>>>>       }
>>>> +    lvms->misc_feature = BIT(IOCSRF_AVEC);
>>>> +    lvms->avecintc = ON_OFF_AUTO_ON;
>>>>       lvms->acpi = ON_OFF_AUTO_AUTO;
>>>>       lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>>>>       lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>>>> @@ -1242,6 +1273,10 @@ static void virt_class_init(ObjectClass *oc, 
>>>> const void *data)
>>>>           NULL, NULL);
>>>>       object_class_property_set_description(oc, "v-eiointc",
>>>>                               "Enable Virt Extend I/O Interrupt 
>>>> Controller.");
>>>> +    object_class_property_add(oc, "avecintc", "OnOffAuto",
>>>> +        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
>>>> +    object_class_property_set_description(oc, "avecintc",
>>>> +                            "Enable Advance Interrupt Controller.");
>>> It is only can be added in TCG mode, in kvm mode avec should not be 
>>> supported now.
>>>> machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>>>       machine_class_allow_dynamic_sysbus_dev(mc, 
>>>> TYPE_UEFI_VARS_SYSBUS);
>>>>   #ifdef CONFIG_TPM
>>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>>> index cc6656619d..44504e5501 100644
>>>> --- a/include/hw/loongarch/virt.h
>>>> +++ b/include/hw/loongarch/virt.h
>>>> @@ -70,6 +70,7 @@ struct LoongArchVirtMachineState {
>>>>       Notifier     powerdown_notifier;
>>>>       OnOffAuto    acpi;
>>>>       OnOffAuto    veiointc;
>>>> +    OnOffAuto    avecintc;
>>>>       char         *oem_id;
>>>>       char         *oem_table_id;
>>>>       DeviceState  *acpi_ged;
>>>> @@ -85,6 +86,8 @@ struct LoongArchVirtMachineState {
>>>>       DeviceState *extioi;
>>>>       struct memmap_entry *memmap_table;
>>>>       unsigned int memmap_entries;
>>>> +    uint64_t misc_feature;
>>>> +    uint64_t misc_status;
>>>>   };
>>>>     #define TYPE_LOONGARCH_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
>>>> @@ -92,6 +95,18 @@ 
>>>> OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, 
>>>> LOONGARCH_VIRT_MACHINE)
>>>>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>>>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>>>>   +static inline bool 
>>>> virt_is_avecintc_enabled(LoongArchVirtMachineState *lvms)
>>>> +{
>>>> +    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>>>> +        return false;
>>>> +    }
>>> Is it enough to only check variable misc_feature? checking avecintc 
>>> seems unnecessary duplicated.
>>>
>>   Someone may  disable avecintc with command  'avecintc = off'.
> +static void virt_set_avecintc(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +
> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
> +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
> +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
> +    }
> With avecintc = off option, misc_feature will be cleared with 
> IOCSRF_AVEC also.
>
you 're right , check  misc_feature is enough.

thanks.
Song Gao
> Regards
> Bibo Mao
>>
>> Thanks.
>> Song Gao.
>>> Regards
>>> Bibo Mao
>>>> +    return true;
>>>> +}
>>>> +
>>>>   static inline bool 
>>>> virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>>>   {
>>>>       if (lvms->veiointc == ON_OFF_AUTO_OFF) {
>>>>



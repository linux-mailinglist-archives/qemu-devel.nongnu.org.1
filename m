Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB67AFF685
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Jul 2025 03:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZgVt-0007kv-AT; Wed, 09 Jul 2025 21:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZgVp-0007jk-SC
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 21:55:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZgVm-0004fq-JP
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 21:55:49 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxPOKdHW9oOu8lAQ--.39717S3;
 Thu, 10 Jul 2025 09:55:41 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8KbHW9o8OQQAA--.43300S3;
 Thu, 10 Jul 2025 09:55:41 +0800 (CST)
Subject: Re: [PATCH v4 02/11] hw/loongarch: add virt feature avecintc support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250703092650.2598059-1-gaosong@loongson.cn>
 <20250703092650.2598059-3-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <fbb5e9d8-3d10-76cd-33ce-cb824e677133@loongson.cn>
Date: Thu, 10 Jul 2025 09:54:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250703092650.2598059-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8KbHW9o8OQQAA--.43300S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4rCF43AFykXF1rKw13KFX_yoW7JF48pa
 yrCFZ5uF1UXr4Ig3sxt3Z8uFn8Ars3Ka4YgrsxurW0kF1DWr1UuryqywsxtFWkA3ykZFy0
 v3Z5Kr47uFsrZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.691,
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



On 2025/7/3 下午5:26, Song Gao wrote:
> LoongArchVirtMachinState add avecintc features, and
> it use to check whether virt machine support advance interrupt controller
> and default set avecintc = ON_OFF_AUTO_ON.
> LoongArchVirtMachineState add misc_feature and misc_status for
> misc fetures and status. and set default avec feture bit.

Spell checker tool suggest it as follows:
"Avecintc feature is added in LoongArchVirtMachinState, and it is used 
to check whether virt machine supports the advanced interrupt controller 
and by default set avecintc with ON_OFF_AUTO_ON. 
LoongArchVirtMachineState adds misc_feature and misc_status for misc 
features and status. and set the default avec feature bit."

> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/loongarch/virt.h | 13 +++++++++++++
>   2 files changed, 43 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b15ada2078..112cf9a9db 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -47,6 +47,27 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "qemu/error-report.h"
>   
> +static void virt_get_avecintc(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +    OnOffAuto avecintc = lvms->avecintc;
> +
> +    visit_type_OnOffAuto(v, name, &avecintc, errp);
> +
> +}
> +static void virt_set_avecintc(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +
> +    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
> +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
> +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
> +    }
> +}
> +
>   static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>   {
> @@ -846,6 +867,9 @@ static void virt_initfn(Object *obj)
>       if (tcg_enabled()) {
>           lvms->veiointc = ON_OFF_AUTO_OFF;
>       }
> +
> +    lvms->misc_feature = BIT(IOCSRF_AVEC);
> +    lvms->avecintc = ON_OFF_AUTO_ON;
>       lvms->acpi = ON_OFF_AUTO_AUTO;
>       lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>       lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
> @@ -1238,6 +1262,12 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>           NULL, NULL);
>       object_class_property_set_description(oc, "v-eiointc",
>                               "Enable Virt Extend I/O Interrupt Controller.");
> +#ifdef CONFIG_TCG
It should be (tcg_enabled()), CONFIG_TCG and CONFIG_KVM is enabled by 
default.

> +    object_class_property_add(oc, "avecintc", "OnOffAuto",
> +        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
> +    object_class_property_set_description(oc, "avecintc",
> +                            "Enable Advance Interrupt Controller.");
> +#endif
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>   #ifdef CONFIG_TPM
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 7120b46714..9e5b32292b 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -23,6 +23,7 @@
>   #define IOCSRF_DVFSV1           7
>   #define IOCSRF_GMOD             9
>   #define IOCSRF_VM               11
> +#define IOCSRF_AVEC             15
>   
>   #define VERSION_REG             0x0
>   #define FEATURE_REG             0x8
> @@ -31,6 +32,7 @@
>   #define MISC_FUNC_REG           0x420
>   #define IOCSRM_EXTIOI_EN        48
>   #define IOCSRM_EXTIOI_INT_ENCODE 49
> +#define IOCSRM_AVEC_EN          51
>   
>   #define LOONGARCH_MAX_CPUS      256
>   
> @@ -69,6 +71,7 @@ struct LoongArchVirtMachineState {
>       Notifier     powerdown_notifier;
>       OnOffAuto    acpi;
>       OnOffAuto    veiointc;
> +    OnOffAuto    avecintc;
>       char         *oem_id;
>       char         *oem_table_id;
>       DeviceState  *acpi_ged;
> @@ -84,6 +87,8 @@ struct LoongArchVirtMachineState {
>       DeviceState *extioi;
>       struct memmap_entry *memmap_table;
>       unsigned int memmap_entries;
> +    uint64_t misc_feature;
> +    uint64_t misc_status;
>   };
>   
>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
> @@ -91,6 +96,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>   
> +static inline bool virt_is_avecintc_enabled(LoongArchVirtMachineState *lvms)
> +{
> +    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
> +        return false;
> +    }
There had better be one empty line, however it is up to you since I am 
not good at coding style.

Regards
Bibo Mao
> +    return true;
> +}
> +
>   static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>   {
>       if (lvms->veiointc == ON_OFF_AUTO_OFF) {
> 



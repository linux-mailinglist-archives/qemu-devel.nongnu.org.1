Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E23773A1A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLeS-0006mk-0M; Tue, 08 Aug 2023 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qTLeP-0006mJ-30
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:17:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qTLeL-0006Q2-Pc
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:17:24 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8CxrutLMtJkE9gSAA--.39075S3;
 Tue, 08 Aug 2023 20:17:15 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPCNKMtJka_dOAA--.49703S3; 
 Tue, 08 Aug 2023 20:17:15 +0800 (CST)
Subject: Re: [PATCH 6/8] Add support of *unrealize* for loongarch cpu
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
 <3c03a7e5c3a3e93adb50b852264a02790221865e.1689837093.git.lixianglai@loongson.cn>
 <20230728152328.37420bee@imammedo.users.ipa.redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <889edcee-7642-b0b7-6309-0a3c349ead15@loongson.cn>
Date: Tue, 8 Aug 2023 20:17:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230728152328.37420bee@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxPCNKMtJka_dOAA--.49703S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF1DGFWrJw15uw15Jw4rtFc_yoWrZw4fpF
 ZrZF4YyF4UJrZrA3sIqas8uF98Xr4xGFyIva13tr10kw4qqrnrXw10krWDuF1Uu3y09F40
 vrnYk3WrWF48JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

Hi Igor Mammedov:


On 7/28/23 9:23 PM, Igor Mammedov wrote:
> On Thu, 20 Jul 2023 15:15:11 +0800
> xianglai li <lixianglai@loongson.cn> wrote:
>
>> 1.Add the Unrealize function to the Loongarch CPU for cpu hot-(un)plug
>> 2.Add CPU topology-related properties to the Loongarch CPU for cpu hot-(un)plug
>>
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
>>   target/loongarch/cpu.c | 33 +++++++++++++++++++++++++++++++++
>>   target/loongarch/cpu.h |  1 +
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index ad93ecac92..97c577820f 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -18,6 +18,7 @@
>>   #include "cpu-csr.h"
>>   #include "sysemu/reset.h"
>>   #include "tcg/tcg.h"
>> +#include "hw/qdev-properties.h"
>>   
>>   const char * const regnames[32] = {
>>       "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
>> @@ -540,6 +541,24 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>       lacc->parent_realize(dev, errp);
>>   }
>>   
>> +static void loongarch_cpu_unrealizefn(DeviceState *dev)
>> +{
>> +    LoongArchCPUClass *mcc = LOONGARCH_CPU_GET_CLASS(dev);
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    CPUState *cs = CPU(dev);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    CPULoongArchState *env = &cpu->env;
>> +
>> +    cpu_remove_sync(CPU(dev));
>> +    cpu_address_space_destroy(cs, 0);
>> +    address_space_destroy(&env->address_space_iocsr);
>> +    memory_region_del_subregion(&env->system_iocsr, &env->iocsr_mem);
>> +#endif
>> +
>> +    mcc->parent_unrealize(dev);
>> +}
>> +
>>   #ifndef CONFIG_USER_ONLY
>>   static void loongarch_qemu_write(void *opaque, hwaddr addr,
>>                                    uint64_t val, unsigned size)
>> @@ -697,6 +716,15 @@ static gchar *loongarch_gdb_arch_name(CPUState *cs)
>>       return g_strdup("loongarch64");
>>   }
>>   
>
>> +static Property loongarch_cpu_properties[] = {
>> +    DEFINE_PROP_INT32("socket-id", LoongArchCPU, socket_id, 0),
>> +    DEFINE_PROP_INT32("core-id", LoongArchCPU, core_id, 0),
>> +    DEFINE_PROP_INT32("thread-id", LoongArchCPU, thread_id, 0),
>> +    DEFINE_PROP_INT32("node-id", LoongArchCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>> +
>> +    DEFINE_PROP_END_OF_LIST()
>> +};
> this should be a part of topo patches


Ok, I'll move it to the topo patch.


Thanks,

xianglai

>> +
>>   static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>>   {
>>       LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
>> @@ -704,8 +732,12 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(c);
>>       ResettableClass *rc = RESETTABLE_CLASS(c);
>>   
>> +    device_class_set_props(dc, loongarch_cpu_properties);
>>       device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
>>                                       &lacc->parent_realize);
>> +    device_class_set_parent_unrealize(dc, loongarch_cpu_unrealizefn,
>> +                                  &lacc->parent_unrealize);
>> +
>>       resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
>>                                          &lacc->parent_phases);
>>   
>> @@ -730,6 +762,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>>   #ifdef CONFIG_TCG
>>       cc->tcg_ops = &loongarch_tcg_ops;
>>   #endif
>> +    dc->user_creatable = true;
>>   }
>>   
>>   #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index f4439c245f..32feee4fe6 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -397,6 +397,7 @@ struct LoongArchCPUClass {
>>       /*< public >*/
>>   
>>       DeviceRealize parent_realize;
>> +    DeviceUnrealize parent_unrealize;
>>       ResettablePhases parent_phases;
>>   };
>>   



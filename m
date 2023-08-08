Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A27737A5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTDIt-0001PM-2A; Mon, 07 Aug 2023 23:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qTDIp-0001PB-0z
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:22:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qTDIl-0003Kf-1o
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:22:33 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dxg_DstNFkuoMSAA--.41552S3;
 Tue, 08 Aug 2023 11:22:20 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ8zrtNFkjUhOAA--.26750S3; 
 Tue, 08 Aug 2023 11:22:19 +0800 (CST)
Subject: Re: [PATCH 4/8] Introduce the CPU address space destruction function
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
 <cf141dbe0b7d2d0837c02e452889f5669c78444d.1689837093.git.lixianglai@loongson.cn>
 <20230728141324.5cbe61fb@imammedo.users.ipa.redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <80b64054-ff8a-caae-ce20-9743aef93fc1@loongson.cn>
Date: Tue, 8 Aug 2023 11:22:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230728141324.5cbe61fb@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxJ8zrtNFkjUhOAA--.26750S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF18WFyxWF4DGFyfAFWDtrc_yoWrWrW5pa
 4DAa1Fka1jyrW7Aw4fXa9FgFy7XFWkGF47Ww43JF9Ykrn8Ww1xAr1jka15CFy7Ar1kWF12
 vFWDWF4fu3W7XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
 UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

The first four patches are written with reference to the patch in the public

modification section of Arm's CPU Hotplug, and the Arm CPU HotPlug-related

patches will be merged into the community in the near future, so the 
first four

patches will be discarded and rebase based on the latest code.


Thanks,

xianglai.


On 7/28/23 8:13 PM, Igor Mammedov wrote:
> On Thu, 20 Jul 2023 15:15:09 +0800
> xianglai li <lixianglai@loongson.cn> wrote:
>
>> Introduce new functions to destroy CPU address space resources
> s/functions/function/
>
>> for cpu hot-(un)plug.
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
>>   include/exec/cpu-common.h |  8 ++++++++
>>   include/hw/core/cpu.h     |  1 +
>>   softmmu/physmem.c         | 24 ++++++++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 87dc9a752c..27cd4d32b1 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
>>    */
>>   void cpu_address_space_init(CPUState *cpu, int asidx,
>>                               const char *prefix, MemoryRegion *mr);
>> +/**
>> + * cpu_address_space_destroy:
>> + * @cpu: CPU for which address space needs to be destroyed
>> + * @asidx: integer index of this address space
>> + *
>> + * Note that with KVM only one address space is supported.
>> + */
>> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>>   
>>   void cpu_physical_memory_rw(hwaddr addr, void *buf,
>>                               hwaddr len, bool is_write);
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index fdcbe87352..d6d68dac12 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -366,6 +366,7 @@ struct CPUState {
>>       QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>>   
>>       CPUAddressSpace *cpu_ases;
>> +    int cpu_ases_ref_count;
> perhaps renaming it to num_ases would be better
>
>>       int num_ases;
> and this one can be named num__ases_[total|max]
>
>
>>       AddressSpace *as;
>>       MemoryRegion *memory;
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 3df73542e1..f4545b4508 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -762,6 +762,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>>   
>>       if (!cpu->cpu_ases) {
>>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
>> +        cpu->cpu_ases_ref_count = cpu->num_ases;
>>       }
>>   
>>       newas = &cpu->cpu_ases[asidx];
>> @@ -775,6 +776,29 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>>       }
>>   }
>>   
>> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
>                                                   ^^^ should it be uintX_t ?
>
>> +{
>> +    CPUAddressSpace *cpuas;
>> +
>> +    assert(asidx < cpu->num_ases);
>> +    assert(asidx == 0 || !kvm_enabled());
>> +    assert(cpu->cpu_ases);
>> +
>> +    cpuas = &cpu->cpu_ases[asidx];
>> +    if (tcg_enabled()) {
>> +        memory_listener_unregister(&cpuas->tcg_as_listener);
>> +    }
>> +
>> +    address_space_destroy(cpuas->as);
>> +
>> +    cpu->cpu_ases_ref_count--;
>> +    if (cpu->cpu_ases_ref_count == 0) {
>> +        g_free(cpu->cpu_ases);
>> +        cpu->cpu_ases = NULL;
>> +    }
>> +
>> +}
>> +
>>   AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>>   {
>>       /* Return the AddressSpace corresponding to the specified index */



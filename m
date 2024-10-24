Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709B9AE466
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Oct 2024 14:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3wcO-0005ob-MG; Thu, 24 Oct 2024 08:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t3wcJ-0005oG-QK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:07:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t3wcG-0004KX-D8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:07:03 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxDeNXOBpnY7EKAA--.24378S3;
 Thu, 24 Oct 2024 20:06:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxveBUOBpnkIMPAA--.19840S3;
 Thu, 24 Oct 2024 20:06:47 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Use physical cpu id about CSR CPUID for
 sysemu
From: maobibo <maobibo@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20241022124247.873232-1-maobibo@loongson.cn>
 <51c9f589-5ceb-42c0-8d02-b1a838141f55@linaro.org>
 <a78458fa-af28-302a-3d75-7628bccf94a2@loongson.cn>
Message-ID: <f6e1069c-effc-d37d-3e52-62ebe9250a38@loongson.cn>
Date: Thu, 24 Oct 2024 20:06:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a78458fa-af28-302a-3d75-7628bccf94a2@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxveBUOBpnkIMPAA--.19840S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4DKFWxGF4UZrykXryDCFX_yoW7XF1fpr
 92kFWYyFW5CrykA342gas8WFyDXr1Ig3Z7X3WrKFy8AwsxXr1jgrW0qryqgF9rAw4rJr4j
 qr1Fy3W3ZF47JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2024/10/23 上午9:22, maobibo wrote:
> 
> 
> On 2024/10/23 上午2:54, Richard Henderson wrote:
>> On 10/22/24 05:42, Bibo Mao wrote:
>>> For user tcg, there is no physical cpu id provided and logic cpuid
>>> is used. For system emulation, physical cpu id is provided, initial
>>> value of register CSR CPUID can be set from physical cpu id.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   hw/intc/loongarch_ipi.c           | 3 ++-
>>>   target/loongarch/cpu.c            | 7 ++++++-
>>>   target/loongarch/tcg/csr_helper.c | 4 ----
>>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> Since cpu_index is arbitrary and assigned by hw/loongarch/virt.c 
>> anyway, why do these two values differ?  Surely arch_id is already 
>> unique per cpu?
> arch_id comes from cpu topo and cpu_index comes from vcpu object created 
> order. There are two places where cpu_index may differ from arch_id, 
> such as command "-smp 2,maxcpus=16,sockets=4,cores=4,threads=1".
> 
> 1. If one cpu is hot-added with command "device_add 
> la464-loongarch-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu-4". The 
> value of cpu_index is 2, however its arch_id is 4.
> 
> 2. The other condition is not decided now how to generate arch_id, for
> the command "-smp 2,maxcpus=36,sockets=6,cores=6,threads=1". It is not 
> decided what it max number about one socket, it may be 6, also it may be 
> 8 which is component of 2.
After second thought, cpu_index can be set again by machines, it can be 
cpuslot index of possible_cpus coming from possible_cpu_arch_ids(). For 
the general arch_id calculation method:
    archid = socket_id * ms->smp.threads * ms->smp.cores  +
             core_id * ms->smp.threads + thread_id
Then arch_id will be the same with cpu_index.

Generic arch_id calculation method is enough, will modify it in furture 
if HW platform defines separate method.

Will refresh the patch in next round.

Regards
Bibo Mao
> 
> arch_id comes from cpu topo, it should be unique per cpu.
> 
> Regards
> Bibo Mao
> 
>>
>>
>> r~
>>
>>
>>>
>>> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
>>> index 2ae1a42c46..78b6fce81b 100644
>>> --- a/hw/intc/loongarch_ipi.c
>>> +++ b/hw/intc/loongarch_ipi.c
>>> @@ -42,7 +42,8 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t 
>>> arch_id)
>>>       CPUArchId *archid;
>>>       archid = find_cpu_by_archid(machine, arch_id);
>>> -    if (archid) {
>>> +    /* For offlined cpus, archid->cpu may be NULL */
>>> +    if (archid && archid->cpu) {
>>>           return CPU(archid->cpu);
>>>       }
>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index 7212fb5f8f..d4659e8d45 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -510,8 +510,10 @@ static void loongarch_max_initfn(Object *obj)
>>>   static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>>>   {
>>>       CPUState *cs = CPU(obj);
>>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>>>       LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
>>>       CPULoongArchState *env = cpu_env(cs);
>>> +    int n;
>>>       if (lacc->parent_phases.hold) {
>>>           lacc->parent_phases.hold(obj, type);
>>> @@ -522,7 +524,6 @@ static void loongarch_cpu_reset_hold(Object *obj, 
>>> ResetType type)
>>>   #endif
>>>       env->fcsr0 = 0x0;
>>> -    int n;
>>>       /* Set csr registers value after reset, see the manual 6.4. */
>>>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
>>>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
>>> @@ -543,7 +544,11 @@ static void loongarch_cpu_reset_hold(Object 
>>> *obj, ResetType type)
>>>       env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>>>       env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, 
>>> RBITS, 0);
>>> +#ifndef CONFIG_USER_ONLY
>>> +    env->CSR_CPUID = cpu->phy_id;
>>> +#else
>>>       env->CSR_CPUID = cs->cpu_index;
>>> +#endif
>>>       env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
>>>       env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>>>       env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, 
>>> ISTLBR, 0);
>>> diff --git a/target/loongarch/tcg/csr_helper.c 
>>> b/target/loongarch/tcg/csr_helper.c
>>> index 15f94caefa..2aeca2343d 100644
>>> --- a/target/loongarch/tcg/csr_helper.c
>>> +++ b/target/loongarch/tcg/csr_helper.c
>>> @@ -37,10 +37,6 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>>>   target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>>>   {
>>> -    LoongArchCPU *lac = env_archcpu(env);
>>> -
>>> -    env->CSR_CPUID = CPU(lac)->cpu_index;
>>> -
>>>       return env->CSR_CPUID;
>>>   }
>>>
>>> base-commit: cc5adbbd50d81555b8eb73602ec16fde40b55be4
> 



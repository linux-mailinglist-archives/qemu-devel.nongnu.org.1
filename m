Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE68800751
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:41:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r900f-0001Jp-Dc; Fri, 01 Dec 2023 04:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1r900Q-0001HE-VQ; Fri, 01 Dec 2023 04:40:19 -0500
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1r900O-0004qr-RS; Fri, 01 Dec 2023 04:40:18 -0500
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id D6BD46080030;
 Fri,  1 Dec 2023 10:40:05 +0100 (CET)
Message-ID: <614c035f-8382-40c9-b2ab-d20a9dc5570e@csgraf.de>
Date: Fri, 1 Dec 2023 10:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/10] hvf: Add Apple Silicon support
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Peter Collingbourne <pcc@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-arm <qemu-arm@nongnu.org>, Frank Yang <lfy@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20210916155404.86958-1-agraf@csgraf.de>
 <20210916155404.86958-5-agraf@csgraf.de>
 <0ae7ffb0-a0af-4afc-ad29-384daff52484@linaro.org>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <0ae7ffb0-a0af-4afc-ad29-384daff52484@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 30.11.23 15:17, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 16/9/21 17:53, Alexander Graf wrote:
>> With Apple Silicon available to the masses, it's a good time to add 
>> support
>> for driving its virtualization extensions from QEMU.
>>
>> This patch adds all necessary architecture specific code to get basic 
>> VMs
>> working, including save/restore.
>>
>> Known limitations:
>>
>>    - WFI handling is missing (follows in later patch)
>>    - No watchpoint/breakpoint support
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
>> Reviewed-by: Sergio Lopez <slp@redhat.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
>
>> ---
>>   MAINTAINERS                 |   5 +
>>   accel/hvf/hvf-accel-ops.c   |   9 +
>>   include/sysemu/hvf_int.h    |  10 +-
>>   meson.build                 |   1 +
>>   target/arm/hvf/hvf.c        | 794 ++++++++++++++++++++++++++++++++++++
>>   target/arm/hvf/trace-events |  10 +
>>   target/i386/hvf/hvf.c       |   5 +
>>   7 files changed, 833 insertions(+), 1 deletion(-)
>>   create mode 100644 target/arm/hvf/hvf.c
>>   create mode 100644 target/arm/hvf/trace-events
>
>
>> +int hvf_arch_init_vcpu(CPUState *cpu)
>> +{
>> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>> +    CPUARMState *env = &arm_cpu->env;
>> +    uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_match);
>> +    uint32_t sregs_cnt = 0;
>> +    uint64_t pfr;
>> +    hv_return_t ret;
>> +    int i;
>> +
>> +    env->aarch64 = 1;
>> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
>> +
>> +    /* Allocate enough space for our sysreg sync */
>> +    arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
>> +                                     sregs_match_len);
>> +    arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
>> +                                    sregs_match_len);
>> +    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
>> + arm_cpu->cpreg_vmstate_indexes,
>> +                                             sregs_match_len);
>> +    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
>> + arm_cpu->cpreg_vmstate_values,
>> +                                            sregs_match_len);
>> +
>> +    memset(arm_cpu->cpreg_values, 0, sregs_match_len * 
>> sizeof(uint64_t));
>> +
>> +    /* Populate cp list for all known sysregs */
>> +    for (i = 0; i < sregs_match_len; i++) {
>> +        const ARMCPRegInfo *ri;
>> +        uint32_t key = hvf_sreg_match[i].key;
>> +
>> +        ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>> +        if (ri) {
>> +            assert(!(ri->type & ARM_CP_NO_RAW));
>> +            hvf_sreg_match[i].cp_idx = sregs_cnt;
>> +            arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
>
> So this hash ...:
>
>     /*
>      * Convert a truncated 32 bit hashtable key into the full
>      * 64 bit KVM register ID.
>      */
>     static uint64_t cpreg_to_kvm_id(uint32_t cpregid)
>     {
>         uint64_t kvmid;
>
>         if (cpregid & CP_REG_AA64_MASK) {
>             kvmid = cpregid & ~CP_REG_AA64_MASK;
>             kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM64;
>         } else {
>             kvmid = cpregid & ~(1 << 15);
>             if (cpregid & (1 << 15)) {
>                 kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM;
>             } else {
>                 kvmid |= CP_REG_SIZE_U32 | CP_REG_ARM;
>             }
>         }
>         return kvmid;
>     }
>
> ... just happens to work the same way for HVF?


It never feeds into HVF - we only use these values as unique identifiers 
inside QEMU, no? See write_cpustate_to_list() and 
write_list_to_cpustate() for reference.


Alex




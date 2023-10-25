Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DBE7D613E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWc2-0002XM-2Q; Wed, 25 Oct 2023 01:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWby-0002X3-Dv
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:39:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWbv-000330-7Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:39:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso401599b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698212358; x=1698817158;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8rYM2WiTRbDYk76bxcz7rnq6UKkRpO6XjAS9cCtbg8=;
 b=dPxnHhEX/kd11RJycYuM+0CdKgQ8plwNiBxwlo5rPMv89oqjgyOJp6cyWui7dGvhOv
 BST0LxSP1x446j6tBSRCXvKbrW70qNNuOkeYVFMXzA5QzJebV+RyiNiDxmnZL/vZDCZS
 kLVtlML9qrPjRIxsslR42tGqEukrppPojZzAjh4XRS2WDycG8uVK72jTzHXFWBER6TDy
 aLJJM0nvRSdpdbc17iCQVpgM7oQVqoF+5nDxC/vJ1DOnrdGwJFxnYu5/3lMC0nR3BoAB
 fRqTJjdypL0RleCq4PfBXChMUjqRJNHLWCE8ucGQhanVQXfUuXGy5ZmSPs62mOKJumH1
 VObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698212358; x=1698817158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8rYM2WiTRbDYk76bxcz7rnq6UKkRpO6XjAS9cCtbg8=;
 b=k4atmZp8CElQovJsnMFcIC4MRT02Kq7M+u3uTHhEPgWDCNW/X7E2kfAvq8Ef5/k/H3
 zKv0NIGP/Gm5P3AvqoornZRPbIsHop4dvvh3UnJD/wUte2boENoWGVfVrjx1VmSSA5Tp
 TPuE0FlOlqK0LRhVCAzSGeRzOLvz4k2x1wyj4GkYmONPnRFY4YJU+CqQmrVprhlldp8m
 p0uDO3a3NO9jz+f6/l/Un91X/EX7BtsTWpDu8CsCPO/T29UM6EqbxMbJ9nZrNaeMy911
 e07Vh9S1NB0jbxQwdJzKlO7iAcNQiQET1Mu3Amyj8Miqp09Swn99rtNbqss45DBQPVYG
 2c6g==
X-Gm-Message-State: AOJu0YwCjZEWQbT806cn51YYqT2pa5vo1ZFdlfLGhJq1PqjVbLrhIy6p
 TRbeo3ZoWtUnk2q/MkLuJ9ABuQ==
X-Google-Smtp-Source: AGHT+IEFmqDDQkJn3nsODDsy/fhQgQSqSvm6RqEsVU1T5U16/SDS/42jvVfJcW2qwJTNI+vmX6TPlw==
X-Received: by 2002:a05:6a00:428e:b0:690:9a5a:e34e with SMTP id
 bx14-20020a056a00428e00b006909a5ae34emr22791249pfb.12.1698212357601; 
 Tue, 24 Oct 2023 22:39:17 -0700 (PDT)
Received: from [157.82.204.207] ([157.82.204.207])
 by smtp.gmail.com with ESMTPSA id
 x14-20020aa7940e000000b006b90f1706f1sm8569106pfo.134.2023.10.24.22.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:39:17 -0700 (PDT)
Message-ID: <6be58bb7-55c9-4126-80a7-985a928c2371@daynix.com>
Date: Wed, 25 Oct 2023 14:39:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/18] plugins: Use different helpers when reading
 registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-17-akihiko.odaki@daynix.com>
 <87h6mg0x9g.fsf@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87h6mg0x9g.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/25 1:48, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> This avoids optimizations incompatible when reading registers.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   accel/tcg/plugin-helpers.h |  3 ++-
>>   include/exec/plugin-gen.h  |  4 ++--
>>   include/hw/core/cpu.h      |  4 ++--
>>   include/qemu/plugin.h      |  3 +++
>>   plugins/plugin.h           |  5 +++--
>>   accel/tcg/plugin-gen.c     | 41 ++++++++++++++++++++++++++++----------
>>   accel/tcg/translator.c     |  2 +-
>>   plugins/api.c              | 14 +++++++++++--
>>   plugins/core.c             | 28 ++++++++++++++++----------
>>   9 files changed, 72 insertions(+), 32 deletions(-)
>>
>> diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
>> index 8e685e0654..11796436f3 100644
>> --- a/accel/tcg/plugin-helpers.h
>> +++ b/accel/tcg/plugin-helpers.h
>> @@ -1,4 +1,5 @@
> <snip>
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -437,7 +437,7 @@ struct qemu_work_item;
>>    * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
>>    *                        to @trace_dstate).
>>    * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
>> - * @plugin_mask: Plugin event bitmap. Modified only via async work.
>> + * @plugin_flags: Plugin flags. Modified only via async work.
>>    * @ignore_memory_transaction_failures: Cached copy of the MachineState
>>    *    flag of the same name: allows the board to suppress calling of the
>>    *    CPU do_transaction_failed hook function.
>> @@ -529,7 +529,7 @@ struct CPUState {
>>       /* Use by accel-block: CPU is executing an ioctl() */
>>       QemuLockCnt in_ioctl_lock;
>>   
>> -    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
>> +    unsigned long plugin_flags;
> 
> Why are we dropping DECLARE_BITMAP here? It does ensure we will always
> have the right size.
> 
>>   
>>   #ifdef CONFIG_PLUGIN
>>       GArray *plugin_mem_cbs;
>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>> index 7fdc3a4849..a534b9127b 100644
>> --- a/include/qemu/plugin.h
>> +++ b/include/qemu/plugin.h
>> @@ -16,6 +16,9 @@
>>   #include "exec/memopidx.h"
>>   #include "hw/core/cpu.h"
>>   
>> +#define QEMU_PLUGIN_FLAG_TB_CB_READ QEMU_PLUGIN_EV_MAX
>> +#define QEMU_PLUGIN_FLAG_INSN_CB_READ (QEMU_PLUGIN_EV_MAX + 1)
>> +
> 
> OK this seems like bad code smell. Are we overloading what was
> plugin_mask to indicate two different things? I can see we only really
> use the flags to indicate syscalls should generate callbacks so maybe
> this could be rationlised but at least split into two patches so the
> change to original behaviour isn't mixed up with new added behaviour.

I introduced new "flag" concept in v15 to avoid the overloading.

> 
>>   /*
>>    * Option parsing/processing.
>>    * Note that we can load an arbitrary number of plugins.
>> diff --git a/plugins/plugin.h b/plugins/plugin.h
>> index 5eb2fdbc85..ba0417194f 100644
>> --- a/plugins/plugin.h
>> +++ b/plugins/plugin.h
>> @@ -16,6 +16,7 @@
>>   #include "qemu/qht.h"
>>   
>>   #define QEMU_PLUGIN_MIN_VERSION 0
>> +#define QEMU_PLUGIN_FLAG_INSIN_CB_READ QEMU_PLUGIN_EV_MAX
> 
> Double definition.

Removed in v15.

> 
>>   
>>   /* global state */
>>   struct qemu_plugin_state {
>> @@ -31,7 +32,7 @@ struct qemu_plugin_state {
>>        * but with the HT we avoid adding a field to CPUState.
>>        */
>>       GHashTable *cpu_ht;
>> -    DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
>> +    unsigned long flags;
>>       /*
>>        * @lock protects the struct as well as ctx->uninstalling.
>>        * The lock must be acquired by all API ops.
>> @@ -86,7 +87,7 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
>>   void
>>   plugin_register_dyn_cb__udata(GArray **arr,
>>                                 qemu_plugin_vcpu_udata_cb_t cb,
>> -                              enum qemu_plugin_cb_flags flags, void *udata);
>> +                              unsigned int flags, void *udata);
>>   
>>   
>>   void plugin_register_vcpu_mem_cb(GArray **arr,
>> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
>> index 78b331b251..3bddd4d3c5 100644
>> --- a/accel/tcg/plugin-gen.c
>> +++ b/accel/tcg/plugin-gen.c
>> @@ -90,7 +90,10 @@ enum plugin_gen_cb {
>>    * These helpers are stubs that get dynamically switched out for calls
>>    * direct to the plugin if they are subscribed to.
>>    */
>> -void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
>> +void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void *udata)
>> +{ }
>> +
>> +void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void *udata)
>>   { }
>>   
>>   void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
>> @@ -98,7 +101,7 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
>>                                   void *userdata)
>>   { }
>>   
>> -static void gen_empty_udata_cb(void)
>> +static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
>>   {
>>       TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
>>       TCGv_ptr udata = tcg_temp_ebb_new_ptr();
>> @@ -106,12 +109,22 @@ static void gen_empty_udata_cb(void)
>>       tcg_gen_movi_ptr(udata, 0);
>>       tcg_gen_ld_i32(cpu_index, tcg_env,
>>                      -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
>> -    gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
>> +    gen_helper(cpu_index, udata);
>>   
>>       tcg_temp_free_ptr(udata);
>>       tcg_temp_free_i32(cpu_index);
>>   }
>>   
>> +static void gen_empty_udata_cb_no_wg(void)
>> +{
>> +    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
>> +}
>> +
>> +static void gen_empty_udata_cb_no_rwg(void)
>> +{
>> +    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
>> +}
>> +
>>   /*
>>    * For now we only support addi_i64.
>>    * When we support more ops, we can generate one empty inline cb for each.
>> @@ -176,7 +189,7 @@ static void gen_wrapped(enum plugin_gen_from from,
>>       tcg_gen_plugin_cb_end();
>>   }
>>   
>> -static void plugin_gen_empty_callback(enum plugin_gen_from from)
>> +static void plugin_gen_empty_callback(CPUState *cpu, enum plugin_gen_from from)
>>   {
>>       switch (from) {
>>       case PLUGIN_GEN_AFTER_INSN:
>> @@ -190,9 +203,15 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
>>            */
>>           gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
>>                       gen_empty_mem_helper);
>> -        /* fall through */
>> +        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
>> +                    cpu->plugin_flags & BIT(QEMU_PLUGIN_FLAG_INSN_CB_READ) ?
>> +                    gen_empty_udata_cb_no_wg : gen_empty_udata_cb_no_rwg);
>> +        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
>> +        break;
>>       case PLUGIN_GEN_FROM_TB:
>> -        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
>> +        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
>> +                    cpu->plugin_flags & BIT(QEMU_PLUGIN_FLAG_TB_CB_READ) ?
>> +                    gen_empty_udata_cb_no_wg :
>> gen_empty_udata_cb_no_rwg);
> 
> What stops us from generating two empty callbacks (one no_wg one no_rwg)
> and just discarding the unused ones after the instrumentation pass?

There is nothing stopping us from doing that, but I see no reason to do 
so when we can pick one just with a ternary operator.

> 
>>           gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
>>           break;
>>       default:
>> @@ -796,7 +815,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
>>   {
>>       bool ret = false;
>>   
>> -    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_mask)) {
>> +    if (cpu->plugin_flags & BIT(QEMU_PLUGIN_EV_VCPU_TB_TRANS)) {
>>           struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
>>           int i;
>>   
>> @@ -817,7 +836,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
>>           ptb->mem_only = mem_only;
>>           ptb->mem_helper = false;
>>   
>> -        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
>> +        plugin_gen_empty_callback(cpu, PLUGIN_GEN_FROM_TB);
>>       }
>>   
>>       tcg_ctx->plugin_insn = NULL;
>> @@ -832,7 +851,7 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
>>   
>>       pinsn = qemu_plugin_tb_insn_get(ptb, db->pc_next);
>>       tcg_ctx->plugin_insn = pinsn;
>> -    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
>> +    plugin_gen_empty_callback(cpu, PLUGIN_GEN_FROM_INSN);
>>   
>>       /*
>>        * Detect page crossing to get the new host address.
>> @@ -852,9 +871,9 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
>>       }
>>   }
>>   
>> -void plugin_gen_insn_end(void)
>> +void plugin_gen_insn_end(CPUState *cpu)
>>   {
>> -    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
>> +    plugin_gen_empty_callback(cpu, PLUGIN_GEN_AFTER_INSN);
>>   }
>>   
>>   /*
>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> index 575b9812ad..bec58dd93f 100644
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -189,7 +189,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>>            * to accurately track instrumented helpers that might access memory.
>>            */
>>           if (plugin_enabled) {
>> -            plugin_gen_insn_end();
>> +            plugin_gen_insn_end(cpu);
>>           }
>>   
>>           /* Stop translation if translate_insn so indicated.  */
>> diff --git a/plugins/api.c b/plugins/api.c
>> index 5521b0ad36..326e37cb73 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -89,8 +89,13 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
>>                                             void *udata)
>>   {
>>       if (!tb->mem_only) {
>> +        bool read = flags == QEMU_PLUGIN_CB_R_REGS ||
>> +                    flags == QEMU_PLUGIN_CB_RW_REGS;
>> +
>>           plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
>> -                                      cb, flags, udata);
>> +                                      cb,
>> +                                      read ? BIT(QEMU_PLUGIN_FLAG_TB_CB_READ) : 0,
>> +                                      udata);
>>       }
>>   }
>>   
>> @@ -109,8 +114,13 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
>>                                               void *udata)
>>   {
>>       if (!insn->mem_only) {
>> +        bool read = flags == QEMU_PLUGIN_CB_R_REGS ||
>> +                    flags == QEMU_PLUGIN_CB_RW_REGS;
>> +
>>           plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
>> -                                      cb, flags, udata);
>> +                                      cb,
>> +                                      read ? BIT(QEMU_PLUGIN_FLAG_INSN_CB_READ) : 0,
>> +                                      udata);
>>       }
>>   }
>>   
>> diff --git a/plugins/core.c b/plugins/core.c
>> index fcd33a2bff..f461e84473 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -55,19 +55,19 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
>>   
>>   static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
>>   {
>> -    bitmap_copy(cpu->plugin_mask, &data.host_ulong, QEMU_PLUGIN_EV_MAX);
>> +    cpu->plugin_flags = data.host_ulong;
>>       tcg_flush_jmp_cache(cpu);
>>   }
>>   
>>   static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
>>   {
>>       CPUState *cpu = container_of(k, CPUState, cpu_index);
>> -    run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>> +    run_on_cpu_data flags = RUN_ON_CPU_HOST_ULONG(plugin.flags);
>>   
>>       if (DEVICE(cpu)->realized) {
>> -        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>> +        async_run_on_cpu(cpu, plugin_cpu_update__async, flags);
>>       } else {
>> -        plugin_cpu_update__async(cpu, mask);
>> +        plugin_cpu_update__async(cpu, flags);
>>       }
>>   }
>>   
>> @@ -83,7 +83,7 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
>>       g_free(cb);
>>       ctx->callbacks[ev] = NULL;
>>       if (QLIST_EMPTY_RCU(&plugin.cb_lists[ev])) {
>> -        clear_bit(ev, plugin.mask);
>> +        plugin.flags &= ~BIT(ev);
>>           g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
>>       }
>>   }
>> @@ -186,8 +186,8 @@ do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
>>               cb->udata = udata;
>>               ctx->callbacks[ev] = cb;
>>               QLIST_INSERT_HEAD_RCU(&plugin.cb_lists[ev], cb, entry);
>> -            if (!test_bit(ev, plugin.mask)) {
>> -                set_bit(ev, plugin.mask);
>> +            if (!(plugin.flags & BIT(ev))) {
>> +                plugin.flags |= BIT(ev);
>>                   g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked,
>>                                        NULL);
>>               }
>> @@ -296,15 +296,20 @@ void plugin_register_inline_op(GArray **arr,
>>   
>>   void plugin_register_dyn_cb__udata(GArray **arr,
>>                                      qemu_plugin_vcpu_udata_cb_t cb,
>> -                                   enum qemu_plugin_cb_flags flags,
>> +                                   unsigned int flags,
>>                                      void *udata)
>>   {
>>       struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
>>   
>>       dyn_cb->userp = udata;
>> -    /* Note flags are discarded as unused. */
>>       dyn_cb->f.vcpu_udata = cb;
>>       dyn_cb->type = PLUGIN_CB_REGULAR;
>> +
>> +    if (flags) {
>> +        QEMU_LOCK_GUARD(&plugin.lock);
>> +        plugin.flags |= flags;
>> +        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
>> +    }
>>   }
>>   
>>   void plugin_register_vcpu_mem_cb(GArray **arr,
>> @@ -357,7 +362,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
>>       struct qemu_plugin_cb *cb, *next;
>>       enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
>>   
>> -    if (!test_bit(ev, cpu->plugin_mask)) {
>> +    if (!(cpu->plugin_flags & BIT(ev))) {
>>           return;
>>       }
>>   
>> @@ -379,7 +384,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
>>       struct qemu_plugin_cb *cb, *next;
>>       enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
>>   
>> -    if (!test_bit(ev, cpu->plugin_mask)) {
>> +    if (!(cpu->plugin_flags & BIT(ev))) {
>>           return;
>>       }
>>   
>> @@ -428,6 +433,7 @@ void qemu_plugin_flush_cb(void)
>>   {
>>       qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
>>       qht_reset(&plugin.dyn_cb_arr_ht);
>> +    plugin.flags &= ~BIT(QEMU_PLUGIN_FLAG_INSIN_CB_READ);
>>   
>>       plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
>>   }
> 
> 
> I'm a bit confused about what we are trying to achieve here. I think
> split the changes and some better commentary would help.

I extracted the change to introduce "flags" into a separate patch in v15.


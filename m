Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571F7D66F6
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaI9-0001DN-Ep; Wed, 25 Oct 2023 05:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaI6-0001Ay-GM
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:35:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaI1-0002qm-4Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:35:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso39257565ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226500; x=1698831300;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bu1XWUL+OaVwo3pplvelvmawLPYlt9ZTQkJHm9zQdvw=;
 b=fW95KddeUHX75/cWRve3tXk7fBI+4U8IxS3MCDq3q0sD7ToMfxmwQgzZPcErv5Shg6
 yi5PiOUt+8uC1Yq8wPHodKzeaP92B2hlvEI55zjuEKfaAW5DDm35DbJzJZ0PsXxg1HcY
 Yx2zzJ7P8GUz1Cpg1kuAXVaI4vvw+sSVDeal/7RfYQYJvYMuJwdxMUBXexFhH37e8vLh
 pOk1p8LqjCrM3ibm1pwUltbM2b9Pm9OTs69JqCJdzAyE6xDSBa6mcZkkN/ZndV9oiwFB
 Szuhij1odvPizJLKpnAluL0JuW56szCQvx+pg7m2DLqz28/nVn96oEEmJ5r9MpNUMoij
 725w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226500; x=1698831300;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bu1XWUL+OaVwo3pplvelvmawLPYlt9ZTQkJHm9zQdvw=;
 b=vefk8ZGlYmqyo66YKoS7dVPm/sZaEEE04xEkIqCYAHon3nbVvgifnep6nRerHzYPpv
 2XmiqZTtSLWFMiLxLzTeeRXbxvaLdEULz/4mIBp+3TQrphMUWSmz4riEfCKIAUUscsRm
 575JYzLEs28Q0iSmzJELyyTOiq1YcQeIM7ATXkmMqClb/+fwsxugwqr/iLcyz6ikp+6s
 MN4Oiswibc/8wdFXqHlzzGyeFgKw4yIOcupcz0vA7xwyeqfw+c+a6GFzi1a0lonX1jR+
 0JqUvOX20bNZ0PDZJ4pjnB/ZljUW+hCeHT+DVdBa9j7eaLvyn5SRQfrDP79psGOpuYab
 9rRw==
X-Gm-Message-State: AOJu0Yz1aRiibfWb4z/1XKckW/Tu3lzSo4Pi/Y9KNfUWYzuxa1aIu9dJ
 EbLB3ZP9sOnfXbo+TrrWsgjeJg==
X-Google-Smtp-Source: AGHT+IESvCqKFN4YfCPEPKu9M3bEYUtrqJSSwQ1oBekSWCVFLdr582mwu7Tveor7mbUxfxjKrrAXgA==
X-Received: by 2002:a17:902:fb88:b0:1c7:49dd:2df with SMTP id
 lg8-20020a170902fb8800b001c749dd02dfmr10654420plb.32.1698226499799; 
 Wed, 25 Oct 2023 02:34:59 -0700 (PDT)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d50300b001b8622c1ad2sm8745204plg.130.2023.10.25.02.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:34:59 -0700 (PDT)
Message-ID: <76d7b210-0911-490a-941d-5a75cb475050@daynix.com>
Date: Wed, 25 Oct 2023 18:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/18] plugins: Use different helpers when reading
 registers
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
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
 <87h6mg0x9g.fsf@linaro.org> <6be58bb7-55c9-4126-80a7-985a928c2371@daynix.com>
In-Reply-To: <6be58bb7-55c9-4126-80a7-985a928c2371@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 2023/10/25 14:39, Akihiko Odaki wrote:
> On 2023/10/25 1:48, Alex Bennée wrote:
>>
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>
>>> This avoids optimizations incompatible when reading registers.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   accel/tcg/plugin-helpers.h |  3 ++-
>>>   include/exec/plugin-gen.h  |  4 ++--
>>>   include/hw/core/cpu.h      |  4 ++--
>>>   include/qemu/plugin.h      |  3 +++
>>>   plugins/plugin.h           |  5 +++--
>>>   accel/tcg/plugin-gen.c     | 41 ++++++++++++++++++++++++++++----------
>>>   accel/tcg/translator.c     |  2 +-
>>>   plugins/api.c              | 14 +++++++++++--
>>>   plugins/core.c             | 28 ++++++++++++++++----------
>>>   9 files changed, 72 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
>>> index 8e685e0654..11796436f3 100644
>>> --- a/accel/tcg/plugin-helpers.h
>>> +++ b/accel/tcg/plugin-helpers.h
>>> @@ -1,4 +1,5 @@
>> <snip>
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -437,7 +437,7 @@ struct qemu_work_item;
>>>    * @trace_dstate_delayed: Delayed changes to trace_dstate (includes 
>>> all changes
>>>    *                        to @trace_dstate).
>>>    * @trace_dstate: Dynamic tracing state of events for this vCPU 
>>> (bitmask).
>>> - * @plugin_mask: Plugin event bitmap. Modified only via async work.
>>> + * @plugin_flags: Plugin flags. Modified only via async work.
>>>    * @ignore_memory_transaction_failures: Cached copy of the 
>>> MachineState
>>>    *    flag of the same name: allows the board to suppress calling 
>>> of the
>>>    *    CPU do_transaction_failed hook function.
>>> @@ -529,7 +529,7 @@ struct CPUState {
>>>       /* Use by accel-block: CPU is executing an ioctl() */
>>>       QemuLockCnt in_ioctl_lock;
>>> -    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
>>> +    unsigned long plugin_flags;
>>
>> Why are we dropping DECLARE_BITMAP here? It does ensure we will always
>> have the right size.
>>
>>>   #ifdef CONFIG_PLUGIN
>>>       GArray *plugin_mem_cbs;
>>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>>> index 7fdc3a4849..a534b9127b 100644
>>> --- a/include/qemu/plugin.h
>>> +++ b/include/qemu/plugin.h
>>> @@ -16,6 +16,9 @@
>>>   #include "exec/memopidx.h"
>>>   #include "hw/core/cpu.h"
>>> +#define QEMU_PLUGIN_FLAG_TB_CB_READ QEMU_PLUGIN_EV_MAX
>>> +#define QEMU_PLUGIN_FLAG_INSN_CB_READ (QEMU_PLUGIN_EV_MAX + 1)
>>> +
>>
>> OK this seems like bad code smell. Are we overloading what was
>> plugin_mask to indicate two different things? I can see we only really
>> use the flags to indicate syscalls should generate callbacks so maybe
>> this could be rationlised but at least split into two patches so the
>> change to original behaviour isn't mixed up with new added behaviour.
> 
> I introduced new "flag" concept in v15 to avoid the overloading.
> 
>>
>>>   /*
>>>    * Option parsing/processing.
>>>    * Note that we can load an arbitrary number of plugins.
>>> diff --git a/plugins/plugin.h b/plugins/plugin.h
>>> index 5eb2fdbc85..ba0417194f 100644
>>> --- a/plugins/plugin.h
>>> +++ b/plugins/plugin.h
>>> @@ -16,6 +16,7 @@
>>>   #include "qemu/qht.h"
>>>   #define QEMU_PLUGIN_MIN_VERSION 0
>>> +#define QEMU_PLUGIN_FLAG_INSIN_CB_READ QEMU_PLUGIN_EV_MAX
>>
>> Double definition.
> 
> Removed in v15.
> 
>>
>>>   /* global state */
>>>   struct qemu_plugin_state {
>>> @@ -31,7 +32,7 @@ struct qemu_plugin_state {
>>>        * but with the HT we avoid adding a field to CPUState.
>>>        */
>>>       GHashTable *cpu_ht;
>>> -    DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
>>> +    unsigned long flags;
>>>       /*
>>>        * @lock protects the struct as well as ctx->uninstalling.
>>>        * The lock must be acquired by all API ops.
>>> @@ -86,7 +87,7 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum 
>>> qemu_plugin_event ev,
>>>   void
>>>   plugin_register_dyn_cb__udata(GArray **arr,
>>>                                 qemu_plugin_vcpu_udata_cb_t cb,
>>> -                              enum qemu_plugin_cb_flags flags, void 
>>> *udata);
>>> +                              unsigned int flags, void *udata);
>>>   void plugin_register_vcpu_mem_cb(GArray **arr,
>>> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
>>> index 78b331b251..3bddd4d3c5 100644
>>> --- a/accel/tcg/plugin-gen.c
>>> +++ b/accel/tcg/plugin-gen.c
>>> @@ -90,7 +90,10 @@ enum plugin_gen_cb {
>>>    * These helpers are stubs that get dynamically switched out for calls
>>>    * direct to the plugin if they are subscribed to.
>>>    */
>>> -void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
>>> +void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void 
>>> *udata)
>>> +{ }
>>> +
>>> +void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void 
>>> *udata)
>>>   { }
>>>   void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
>>> @@ -98,7 +101,7 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int 
>>> vcpu_index,
>>>                                   void *userdata)
>>>   { }
>>> -static void gen_empty_udata_cb(void)
>>> +static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
>>>   {
>>>       TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
>>>       TCGv_ptr udata = tcg_temp_ebb_new_ptr();
>>> @@ -106,12 +109,22 @@ static void gen_empty_udata_cb(void)
>>>       tcg_gen_movi_ptr(udata, 0);
>>>       tcg_gen_ld_i32(cpu_index, tcg_env,
>>>                      -offsetof(ArchCPU, env) + offsetof(CPUState, 
>>> cpu_index));
>>> -    gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
>>> +    gen_helper(cpu_index, udata);
>>>       tcg_temp_free_ptr(udata);
>>>       tcg_temp_free_i32(cpu_index);
>>>   }
>>> +static void gen_empty_udata_cb_no_wg(void)
>>> +{
>>> +    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
>>> +}
>>> +
>>> +static void gen_empty_udata_cb_no_rwg(void)
>>> +{
>>> +    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
>>> +}
>>> +
>>>   /*
>>>    * For now we only support addi_i64.
>>>    * When we support more ops, we can generate one empty inline cb 
>>> for each.
>>> @@ -176,7 +189,7 @@ static void gen_wrapped(enum plugin_gen_from from,
>>>       tcg_gen_plugin_cb_end();
>>>   }
>>> -static void plugin_gen_empty_callback(enum plugin_gen_from from)
>>> +static void plugin_gen_empty_callback(CPUState *cpu, enum 
>>> plugin_gen_from from)
>>>   {
>>>       switch (from) {
>>>       case PLUGIN_GEN_AFTER_INSN:
>>> @@ -190,9 +203,15 @@ static void plugin_gen_empty_callback(enum 
>>> plugin_gen_from from)
>>>            */
>>>           gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
>>>                       gen_empty_mem_helper);
>>> -        /* fall through */
>>> +        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
>>> +                    cpu->plugin_flags & 
>>> BIT(QEMU_PLUGIN_FLAG_INSN_CB_READ) ?
>>> +                    gen_empty_udata_cb_no_wg : 
>>> gen_empty_udata_cb_no_rwg);
>>> +        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
>>> +        break;
>>>       case PLUGIN_GEN_FROM_TB:
>>> -        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
>>> +        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
>>> +                    cpu->plugin_flags & 
>>> BIT(QEMU_PLUGIN_FLAG_TB_CB_READ) ?
>>> +                    gen_empty_udata_cb_no_wg :
>>> gen_empty_udata_cb_no_rwg);
>>
>> What stops us from generating two empty callbacks (one no_wg one no_rwg)
>> and just discarding the unused ones after the instrumentation pass?
> 
> There is nothing stopping us from doing that, but I see no reason to do 
> so when we can pick one just with a ternary operator.

I think I get the idea. Please check v16 and see if it does what you 
expect. It is indeed much simpler than the previous version.


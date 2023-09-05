Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB079209B
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 08:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdPu9-0005Xs-6c; Tue, 05 Sep 2023 02:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdPu6-0005Xk-Dr
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:51:14 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qdPu3-0004yh-29
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:51:14 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bca66e6c44so1835368a34.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693896669; x=1694501469;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YCm8ADC9YFhRhMheB3KZkAlUNcHZst6Uk2P1sq3Zpdc=;
 b=olFPBDUQXjloPQUhdbi1bNfy2ME//EKvV61C3/FSGOjygwqz89QnhXXSlqRqgpMKGj
 EjZQHaB7rOk0GhqfHwHrxuB3ITKiKIZLc6/tdl7djyme3ur/4HTIBN3J58ro9SQejMDm
 7k79palZo0jHY1Y+IsOw9D+4c3qCtQO/CrOXI9orL5vmeaIRIoBLGnGRV5x+/Y+7DecY
 KmfecMyjnH6PYPzsdVvpQNitldB0+OWaj3+uyDg03Ga5XYpeyegbB50T5KdPEhn/10Bk
 ca17qZOcURaUU/7prIZeaSyG3PHIR8qSl+Bug0oXTAwELuaowCXj6tPbcDOomBYKSO2e
 A6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693896669; x=1694501469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCm8ADC9YFhRhMheB3KZkAlUNcHZst6Uk2P1sq3Zpdc=;
 b=BO4wNa5O1kZVN3YVUAVO0akcJ7g249o+MzEjbQSuE8abH/cdNY/ACllYEgsd+0uajg
 giC+nrRVWTxkLj2Z6ICrmKDX73LkERmBdeOu2MClKNvZRp/zUwL1xDeYyxgnEmv8K/Pp
 moeXLgo0b3daqzRkx/kkwCrWRH079i1rFaRa8Y04JvDdMwhAzWHXFTxzL4YfLuDFZ1ZI
 Zv9RnnqBtChx94fsItSf49glEKuLof1YzM5ANkw4Da4bNXXPHxixCkWUO6o9AO+/j0i8
 Wi0Iwlt6fY+oJ7OQaZaHGOnmcixdJMvfewamV+fEx/nlw04jTmshNmLHFykH0Sn6+0MX
 pofA==
X-Gm-Message-State: AOJu0YyNC79lU9CS85vsmb/+wUwFDKmXDug4uqPpCnQ6MCvOWgqFQqEG
 YuMqYyrtYkkws7yS7L96wLIjnQ==
X-Google-Smtp-Source: AGHT+IELwxNu6utw3RjFkvPFX2y4TgNvdsAazfcV4LUuSmCmuX8GfO5szrn7P+D+j7ZihR9dmoTD3Q==
X-Received: by 2002:a05:6358:e4aa:b0:139:d5b9:87d3 with SMTP id
 by42-20020a056358e4aa00b00139d5b987d3mr14846525rwb.5.1693896668636; 
 Mon, 04 Sep 2023 23:51:08 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a17090ae51000b0025023726fc4sm10008270pjy.26.2023.09.04.23.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 23:51:08 -0700 (PDT)
Message-ID: <fadd59c2-bd09-4195-be39-78b1f48e948e@daynix.com>
Date: Tue, 5 Sep 2023 15:51:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 24/26] contrib/plugins: Allow to log registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-25-akihiko.odaki@daynix.com> <87a5u8r2a9.fsf@linaro.org>
 <6e73535a-c4cc-47d3-a658-7f25815d5c07@daynix.com> <877cp6hrpq.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <877cp6hrpq.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x331.google.com
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

On 2023/09/05 0:30, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2023/08/31 0:08, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> This demonstrates how a register can be read from a plugin.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    docs/devel/tcg-plugins.rst |  10 ++-
>>>>    contrib/plugins/execlog.c  | 140 ++++++++++++++++++++++++++++---------
>>>>    2 files changed, 117 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>>>> index 81dcd43a61..c9f8b27590 100644
>>>> --- a/docs/devel/tcg-plugins.rst
>>>> +++ b/docs/devel/tcg-plugins.rst
>>>> @@ -497,6 +497,15 @@ arguments if required::
>>>>      $ qemu-system-arm $(QEMU_ARGS) \
>>>>        -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
>>>>    +This plugin can also dump a specified register. The
>>>> specification of register
>>>> +follows `GDB standard target features <https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html>`__.
>>>> +
>>>> +Specify the name of the feature that contains the register and the name of the
>>>> +register with ``rfile`` and ``reg`` options, respectively::
>>>> +
>>>> +  $ qemu-system-arm $(QEMU_ARGS) \
>>>> +    -plugin ./contrib/plugins/libexeclog.so,rfile=org.gnu.gdb.arm.core,reg=sp -d plugin
>>>> +
>>>>    - contrib/plugins/cache.c
>>>>      Cache modelling plugin that measures the performance of a given
>>>> L1 cache
>>>> @@ -583,4 +592,3 @@ The following API is generated from the inline documentation in
>>>>    include the full kernel-doc annotations.
>>>>      .. kernel-doc:: include/qemu/qemu-plugin.h
>>>> -
>>>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>>>> index 82dc2f584e..aa05840fd0 100644
>>>> --- a/contrib/plugins/execlog.c
>>>> +++ b/contrib/plugins/execlog.c
>>>> @@ -15,27 +15,43 @@
>>>>      #include <qemu-plugin.h>
>>>>    +typedef struct CPU {
>>>> +    /* Store last executed instruction on each vCPU as a GString */
>>>> +    GString *last_exec;
>>>> +    GByteArray *reg_history[2];
>>>> +
>>>> +    int reg;
>>>> +} CPU;
>>>> +
>>>>    QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>>>    
>>> <snip>
>>>>          /* Store new instruction in cache */
>>>>        /* vcpu_mem will add memory access information to last_exec */
>>>> -    g_string_printf(s, "%u, ", cpu_index);
>>>> -    g_string_append(s, (char *)udata);
>>>> +    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
>>>> +    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
>>>> +
>>>> +    g_rw_lock_reader_unlock(&expand_array_lock);
>>>>    }
>>>>      /**
>>>> @@ -167,8 +197,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>>>                                                 QEMU_PLUGIN_MEM_RW, NULL);
>>>>                  /* Register callback on instruction */
>>>> -            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>>>> -                                                   QEMU_PLUGIN_CB_NO_REGS, output);
>>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>>> +                insn, vcpu_insn_exec,
>>>> +                rfile_name ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO_REGS,
>>>> +                output);
>>>>                  /* reset skip */
>>>>                skip = (imatches || amatches);
>>>> @@ -177,17 +209,53 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>>>        }
>>>>    }
>>>>    +static void vcpu_init(qemu_plugin_id_t id, unsigned int
>>>> vcpu_index)
>>>> +{
>>>> +    int reg = 0;
>>>> +    bool found = false;
>>>> +
>>>> +    expand_cpu(vcpu_index);
>>>> +
>>>> +    if (rfile_name) {
>>>> +        int i;
>>>> +        int j;
>>>> +        int n;
>>>> +
>>>> +        qemu_plugin_register_file_t *rfiles =
>>>> +            qemu_plugin_get_register_files(vcpu_index, &n);
>>>> +
>>>> +        for (i = 0; i < n; i++) {
>>>> +            if (g_strcmp0(rfiles[i].name, rfile_name) == 0) {
>>>> +                for (j = 0; j < rfiles[i].num_regs; j++) {
>>>> +                    if (g_strcmp0(rfiles[i].regs[j], reg_name) == 0) {
>>>> +                        reg += j;
>>>> +                        found = true;
>>>> +                        break;
>>>> +                    }
>>>> +                }
>>>> +                break;
>>>> +            }
>>>> +
>>>> +            reg += rfiles[i].num_regs;
>>>> +        }
>>>> +
>>>> +        g_free(rfiles);
>>>> +    }
>>> This makes me question the value of exposing the register file
>>> directly
>>> to the plugin. I would much rather have a lookup utility function with
>>> an optional tag. Something like:
>>>     plugin_reg_t qemu_plugin_find_register(const char *name, const
>>> char *tag);
>>> And make tag optional. I think in the general case "name" should be
>>> enough.
>>
>> I have explained the reason why I introduced register file abstraction
>> instead of adding a function to look up a register for an earlier
>> version of this series:
>>> I added a function that returns all register information instead of a
>>> function that looks up a register so that a plugin can enumerate
>>> registers. Such capability is useful for a plugin that dumps all
>>> registers or a plugin that simulates processor (such a plugin may want
>>> to warn if there are unknown registers).
> 
> Fair enough. However I think a simple search interface will also be
> useful for the more common case.

I'll add one in a future version.

> 
>> How would you define name and tag? They are something we currently do
>> not have, and I'm trying to add new types of identifiers since such
>> identifiers will be needed to be defined for different architectures
>> and require documentation and extra work to avoid name conflicts and
>> ensure interface stability.
> 
> The name would be the register name which AFAICT are unique across the
> system. If you have examples of clashes I'm curious as to what they are.

Here I'm talking about creating and maintaining a set of identifiers 
independent of GDB. I'm suggesting to reuse the identifiers GDB use 
since they are already designed so that there are no clashes.

> I'm still conflicted about baking gdb-isms into this ABI because they
> aren't as stable as they could be either. Either way we do state:
> 
>    This is a new feature for QEMU and it does allow people to develop
>    out-of-tree plugins that can be dynamically linked into a running QEMU
>    process. However the project reserves the right to change or break the
>    API should it need to do so. The best way to avoid this is to submit
>    your plugin upstream so they can be updated if/when the API changes.
> 
> So I'm not overly concerned about formalising a stable ABI for now.
> 
>>
>>>
>>>> +
>>>> +    g_rw_lock_writer_lock(&expand_array_lock);
>>>> +    cpus[vcpu_index].reg = found ? reg : -1;
>>>> +    g_rw_lock_writer_unlock(&expand_array_lock);
>>>> +}
>>>> +
>>>>    /**
>>>>     * On plugin exit, print last instruction in cache
>>>>     */
>>>>    static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>>    {
>>>>        guint i;
>>>> -    GString *s;
>>>> -    for (i = 0; i < last_exec->len; i++) {
>>>> -        s = g_ptr_array_index(last_exec, i);
>>>> -        if (s->str) {
>>>> -            qemu_plugin_outs(s->str);
>>>> +    for (i = 0; i < num_cpus; i++) {
>>>> +        if (cpus[i].last_exec->str) {
>>>> +            qemu_plugin_outs(cpus[i].last_exec->str);
>>>>                qemu_plugin_outs("\n");
>>>>            }
>>>>        }
>>>> @@ -224,9 +292,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>>         * we don't know the size before emulation.
>>>>         */
>>>>        if (info->system_emulation) {
>>>> -        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
>>>> -    } else {
>>>> -        last_exec = g_ptr_array_new();
>>>> +        cpus = g_new(CPU, info->system.max_vcpus);
>>>>        }
>>>>          for (int i = 0; i < argc; i++) {
>>>> @@ -236,13 +302,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>>                parse_insn_match(tokens[1]);
>>>>            } else if (g_strcmp0(tokens[0], "afilter") == 0) {
>>>>                parse_vaddr_match(tokens[1]);
>>>> +        } else if (g_strcmp0(tokens[0], "rfile") == 0) {
>>>> +            rfile_name = g_strdup(tokens[1]);
>>>> +        } else if (g_strcmp0(tokens[0], "reg") == 0) {
>>>> +            reg_name = g_strdup(tokens[1]);
>>> And then instead of having the rfile/reg distinction support a
>>> command
>>> line like:
>>>     qemu-aarch64 -plugin
>>> contrib/plugins/libexeclog.so,reg=sp,reg=x1,reg=sve:p1
>>> so if the user specifies a reg of the form TAG:REG we can pass that
>>> as
>>> the option tag string. It also avoids exposing all the details of gdb to
>>> plugins while still allowing the utility function to search by rname
>>> internally (even if only a substring match?),
>>
>> That implicitly assumes TAG does not contain a colon. I'm avoiding to
>> make such an implicit assumption because it is a reference for plugin
>> writers who may create out-of-tree plugins. We should retrain
>> ourselves to tell the plugin writers not to make such an assumption
>> that may not hold in the future version of QEMU.
>>
>> I consider a substring match harmful for a similar reason. There is no
>> guarantee that a future version of QEMU will not introduce a new
>> register that match with the existing substring and break interface
>> stability.
>>
>> It is not necessary that identifiers are consistent with ones GDB use.
>> What matters here is that the identifiers are documented, stable and
>> immune from conflicts.
> 
> We've a couple of cases of GDB having to issue new XML interface names
> to handle cases where the previous definition missed important bits.
> Hence my unease at exposing them to the plugin interface.

Why you had to issue new feature names when adding missing definitions? 
I expect the reasoning for changing GDB interface names should also 
apply for TCG plugins: when not changing interface names will break GDB, 
it should be also likely to break TCG plugins using the affected features.

I consider names used in GDB stable. GDB versions will break if they are 
not.

> 
> The plugin interface shouldn't (yet?) be regarded as a stable interface
> (c.f. above).
The plugin interface has been for almost 5 years. If it is not stable 
yet, when it will be? In any case, the interface stability should be 
considered as an eventual goal; otherwise the existing infrastructure 
for plugin API versioning will make no sense.


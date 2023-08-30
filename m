Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A262478E103
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbSBg-0008Qj-5R; Wed, 30 Aug 2023 16:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbSBd-0008Qb-Il
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:53:13 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbSBa-0003uM-EU
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:53:13 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-565334377d0so159953a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693428789; x=1694033589;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoXnQzFzmnUZcx3zZ72OXuhRDftMmirgovOi+VTV9sQ=;
 b=i6O8g86Ua37SHv9He61z0nmWdSraAmhpNVd/s2qntlM1UpxA5FcESkMVaR4OM+GHdQ
 EDtTI+xBCzN81kI6BiVZmKyoPiWKoP3DkYByWBq8D5sACd7guZkrV5bHf2a8B5jQwNdL
 ItyecBzURsljD6/OCDUeG7GRPX3fYaUEb01osYakamEjfCe0RfDQOQt40gC58cm0flTl
 s1BPtFkv9MB0GYLlX1i6bYW2nzgMag5NhPNnkg0zJhrR0daediGlxNK7AJijOGs0VN7Z
 HNDxXsNiAb7mLuWTlTFqLAzcffedALh7VTMn4wdyIpNwLlhaDJeByjIJQYnf8KS1xC8n
 D+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693428789; x=1694033589;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yoXnQzFzmnUZcx3zZ72OXuhRDftMmirgovOi+VTV9sQ=;
 b=LjxL78JcxPF7sdkACniGt7Q/PI6Bm9ZbhQDqDvd8UvMVgRdxFhsjgn214It4e7YUCa
 E2jkmhWrykoqJoncKA1kA868COyzsjAft0eYAHIYfEC7vqAN34aW7vSsXPeyYSnS0gLd
 0gbyz/V9VBxHBKocOzv3m1/RCEMA4IeHbe+3yGJfvfBG0Gxrjujqw+ItSCaqZh+ykaAv
 Tt96qkM15hIyl31AWIesU7PSrbjk7dSrz4kWDVEglOWxj21FUgKveevQOI3O0j9/N1rJ
 38Z5gycD863KpdA5MR7BraDYo7zLCsbrRI+eKi9I+7u8D66KjwS6IHIcbD9SarNyD6/j
 UmGg==
X-Gm-Message-State: AOJu0YwsQWc89gg2ceqFWY6zh5WitaY3EctFu/N5dzaFyzw/LJF4Ev8W
 LsNutIlsJKx0IKAbxZLc/E1AhA==
X-Google-Smtp-Source: AGHT+IGuonrsx71RPoFol7H2CGjNFKknf+HoY7j30g7Ts494ReKDso5d9kTKu+Yt4WD5Ec2pO4AtJQ==
X-Received: by 2002:a05:6a21:9989:b0:14e:62cd:136c with SMTP id
 ve9-20020a056a21998900b0014e62cd136cmr4053833pzb.10.1693428789003; 
 Wed, 30 Aug 2023 13:53:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p15-20020aa7860f000000b0068c670afe30sm1941pfn.124.2023.08.30.13.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:53:08 -0700 (PDT)
Message-ID: <6e73535a-c4cc-47d3-a658-7f25815d5c07@daynix.com>
Date: Thu, 31 Aug 2023 05:53:05 +0900
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87a5u8r2a9.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

On 2023/08/31 0:08, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> This demonstrates how a register can be read from a plugin.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   docs/devel/tcg-plugins.rst |  10 ++-
>>   contrib/plugins/execlog.c  | 140 ++++++++++++++++++++++++++++---------
>>   2 files changed, 117 insertions(+), 33 deletions(-)
>>
>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>> index 81dcd43a61..c9f8b27590 100644
>> --- a/docs/devel/tcg-plugins.rst
>> +++ b/docs/devel/tcg-plugins.rst
>> @@ -497,6 +497,15 @@ arguments if required::
>>     $ qemu-system-arm $(QEMU_ARGS) \
>>       -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
>>   
>> +This plugin can also dump a specified register. The specification of register
>> +follows `GDB standard target features <https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html>`__.
>> +
>> +Specify the name of the feature that contains the register and the name of the
>> +register with ``rfile`` and ``reg`` options, respectively::
>> +
>> +  $ qemu-system-arm $(QEMU_ARGS) \
>> +    -plugin ./contrib/plugins/libexeclog.so,rfile=org.gnu.gdb.arm.core,reg=sp -d plugin
>> +
>>   - contrib/plugins/cache.c
>>   
>>   Cache modelling plugin that measures the performance of a given L1 cache
>> @@ -583,4 +592,3 @@ The following API is generated from the inline documentation in
>>   include the full kernel-doc annotations.
>>   
>>   .. kernel-doc:: include/qemu/qemu-plugin.h
>> -
>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>> index 82dc2f584e..aa05840fd0 100644
>> --- a/contrib/plugins/execlog.c
>> +++ b/contrib/plugins/execlog.c
>> @@ -15,27 +15,43 @@
>>   
>>   #include <qemu-plugin.h>
>>   
>> +typedef struct CPU {
>> +    /* Store last executed instruction on each vCPU as a GString */
>> +    GString *last_exec;
>> +    GByteArray *reg_history[2];
>> +
>> +    int reg;
>> +} CPU;
>> +
>>   QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>   
> <snip>
>>   
>>       /* Store new instruction in cache */
>>       /* vcpu_mem will add memory access information to last_exec */
>> -    g_string_printf(s, "%u, ", cpu_index);
>> -    g_string_append(s, (char *)udata);
>> +    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
>> +    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
>> +
>> +    g_rw_lock_reader_unlock(&expand_array_lock);
>>   }
>>   
>>   /**
>> @@ -167,8 +197,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>                                                QEMU_PLUGIN_MEM_RW, NULL);
>>   
>>               /* Register callback on instruction */
>> -            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>> -                                                   QEMU_PLUGIN_CB_NO_REGS, output);
>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>> +                insn, vcpu_insn_exec,
>> +                rfile_name ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO_REGS,
>> +                output);
>>   
>>               /* reset skip */
>>               skip = (imatches || amatches);
>> @@ -177,17 +209,53 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>       }
>>   }
>>   
>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>> +{
>> +    int reg = 0;
>> +    bool found = false;
>> +
>> +    expand_cpu(vcpu_index);
>> +
>> +    if (rfile_name) {
>> +        int i;
>> +        int j;
>> +        int n;
>> +
>> +        qemu_plugin_register_file_t *rfiles =
>> +            qemu_plugin_get_register_files(vcpu_index, &n);
>> +
>> +        for (i = 0; i < n; i++) {
>> +            if (g_strcmp0(rfiles[i].name, rfile_name) == 0) {
>> +                for (j = 0; j < rfiles[i].num_regs; j++) {
>> +                    if (g_strcmp0(rfiles[i].regs[j], reg_name) == 0) {
>> +                        reg += j;
>> +                        found = true;
>> +                        break;
>> +                    }
>> +                }
>> +                break;
>> +            }
>> +
>> +            reg += rfiles[i].num_regs;
>> +        }
>> +
>> +        g_free(rfiles);
>> +    }
> 
> This makes me question the value of exposing the register file directly
> to the plugin. I would much rather have a lookup utility function with
> an optional tag. Something like:
> 
>    plugin_reg_t qemu_plugin_find_register(const char *name, const char *tag);
> 
> And make tag optional. I think in the general case "name" should be enough.

I have explained the reason why I introduced register file abstraction 
instead of adding a function to look up a register for an earlier 
version of this series:
 > I added a function that returns all register information instead of a
 > function that looks up a register so that a plugin can enumerate
 > registers. Such capability is useful for a plugin that dumps all
 > registers or a plugin that simulates processor (such a plugin may want
 > to warn if there are unknown registers).

How would you define name and tag? They are something we currently do 
not have, and I'm trying to add new types of identifiers since such 
identifiers will be needed to be defined for different architectures and 
require documentation and extra work to avoid name conflicts and ensure 
interface stability.

> 
>> +
>> +    g_rw_lock_writer_lock(&expand_array_lock);
>> +    cpus[vcpu_index].reg = found ? reg : -1;
>> +    g_rw_lock_writer_unlock(&expand_array_lock);
>> +}
>> +
>>   /**
>>    * On plugin exit, print last instruction in cache
>>    */
>>   static void plugin_exit(qemu_plugin_id_t id, void *p)
>>   {
>>       guint i;
>> -    GString *s;
>> -    for (i = 0; i < last_exec->len; i++) {
>> -        s = g_ptr_array_index(last_exec, i);
>> -        if (s->str) {
>> -            qemu_plugin_outs(s->str);
>> +    for (i = 0; i < num_cpus; i++) {
>> +        if (cpus[i].last_exec->str) {
>> +            qemu_plugin_outs(cpus[i].last_exec->str);
>>               qemu_plugin_outs("\n");
>>           }
>>       }
>> @@ -224,9 +292,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>        * we don't know the size before emulation.
>>        */
>>       if (info->system_emulation) {
>> -        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
>> -    } else {
>> -        last_exec = g_ptr_array_new();
>> +        cpus = g_new(CPU, info->system.max_vcpus);
>>       }
>>   
>>       for (int i = 0; i < argc; i++) {
>> @@ -236,13 +302,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>               parse_insn_match(tokens[1]);
>>           } else if (g_strcmp0(tokens[0], "afilter") == 0) {
>>               parse_vaddr_match(tokens[1]);
>> +        } else if (g_strcmp0(tokens[0], "rfile") == 0) {
>> +            rfile_name = g_strdup(tokens[1]);
>> +        } else if (g_strcmp0(tokens[0], "reg") == 0) {
>> +            reg_name = g_strdup(tokens[1]);
> 
> And then instead of having the rfile/reg distinction support a command
> line like:
> 
>    qemu-aarch64 -plugin contrib/plugins/libexeclog.so,reg=sp,reg=x1,reg=sve:p1
> 
> so if the user specifies a reg of the form TAG:REG we can pass that as
> the option tag string. It also avoids exposing all the details of gdb to
> plugins while still allowing the utility function to search by rname
> internally (even if only a substring match?),

That implicitly assumes TAG does not contain a colon. I'm avoiding to 
make such an implicit assumption because it is a reference for plugin 
writers who may create out-of-tree plugins. We should retrain ourselves 
to tell the plugin writers not to make such an assumption that may not 
hold in the future version of QEMU.

I consider a substring match harmful for a similar reason. There is no 
guarantee that a future version of QEMU will not introduce a new 
register that match with the existing substring and break interface 
stability.

It is not necessary that identifiers are consistent with ones GDB use. 
What matters here is that the identifiers are documented, stable and 
immune from conflicts.

> 
> 
>>           } else {
>>               fprintf(stderr, "option parsing failed: %s\n", opt);
>>               return -1;
>>           }
>>       }
>>   
>> +    if ((!rfile_name) != (!reg_name)) {
>> +        fputs("file and reg need to be set at the same time\n", stderr);
>> +        return -1;
>> +    }
>> +
>>       /* Register translation block and exit callbacks */
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
> 


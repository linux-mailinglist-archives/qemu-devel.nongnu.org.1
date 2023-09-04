Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B36791AC7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 17:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdBh3-00072f-TZ; Mon, 04 Sep 2023 11:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdBgz-00070K-93
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 11:40:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdBgt-0000CL-Ce
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 11:40:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so1398834f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693842034; x=1694446834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGcv4bK++mH9J2+u5h7HLBpjg9cwmXy4wbwI/wvZFjk=;
 b=hBMHFaPZTs6oxHmvofKVNA4AFI+Ceyai+ZaNMbVlaBOGZHoKKWw4xkwPJM243PSheC
 7Bt4Lxd2+3AxNo8uEPllJmrSa8mcwefLMkGENRzm3kdIw2CS0C4cG45hAlK+O5bMBOv0
 a50zpOZy1M3znGxX+EYUCQNW94Q4Mg8tuF/fKrriU5zmz1Be9+IR9E1WtJm4ZAdxpsC3
 43tJifJXCzlmEd7eKpZ2Ba6ZfxVUVOOxqFMq/FPRu9xwodtgh4rlBxdMY6uHWKtila5S
 1D3xTBdw48K58Hsg1G8e7O/4BTVvZ2krP/uVoRH1riN0KEZga4xZf7Wy9iuQyydXSrg7
 AKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693842034; x=1694446834;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TGcv4bK++mH9J2+u5h7HLBpjg9cwmXy4wbwI/wvZFjk=;
 b=Gdro0z/wmqghHxWqeU1BBmiBFwCUl1yiH57az8AgDKVSN1ld1M2asXZbMgbfbUXGAf
 KYx3aG45RQL6d4UmUGGrvujibTVEdhDxnPav7NtRyMjFW+2tJGcSG/4V2Eqd5UO9yIVX
 nWkIIcL3FIK7XqC2ljOWoP6jcl+0wPYRfu5J+1uQi8Crm+cJ+Dk7tz0j4MIFfQpQMvT9
 JiRpjmTJ/hcD1KJQ7imX+rx9wpgUWBBEZPE34qC4K3pDjzpf2VYqo/VlRbs7zUew8NrM
 znwYdiQw7eImN5b4encoS3h3RfrQVQY4chSDjOK11I49tHYWu7YfPw0x5o71Dbx7A7VD
 X+9g==
X-Gm-Message-State: AOJu0YwjvJs8wXRX+qktAgThj+G99ben7qXOZb2r4dvQ3RjmU6i902NR
 Ji4DpHCZGKtFeq6mIgHIFKSKng==
X-Google-Smtp-Source: AGHT+IHyPStm/pOIW2IklLc0FvGNcvHWwimIs6d+1rjNLle4hhJ2d1Eo/j5pKONUaShWqtpoU4Gljw==
X-Received: by 2002:adf:e786:0:b0:317:5722:a41b with SMTP id
 n6-20020adfe786000000b003175722a41bmr7075705wrm.7.1693842034601; 
 Mon, 04 Sep 2023 08:40:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g18-20020adfa492000000b003143cb109d5sm12234641wrb.14.2023.09.04.08.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:40:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB0601FFBB;
 Mon,  4 Sep 2023 16:40:33 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-25-akihiko.odaki@daynix.com>
 <87a5u8r2a9.fsf@linaro.org>
 <6e73535a-c4cc-47d3-a658-7f25815d5c07@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Alexandre Iooss
 <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, Richard
 Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v5 24/26] contrib/plugins: Allow to log registers
Date: Mon, 04 Sep 2023 16:30:50 +0100
In-reply-to: <6e73535a-c4cc-47d3-a658-7f25815d5c07@daynix.com>
Message-ID: <877cp6hrpq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2023/08/31 0:08, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> This demonstrates how a register can be read from a plugin.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   docs/devel/tcg-plugins.rst |  10 ++-
>>>   contrib/plugins/execlog.c  | 140 ++++++++++++++++++++++++++++---------
>>>   2 files changed, 117 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>>> index 81dcd43a61..c9f8b27590 100644
>>> --- a/docs/devel/tcg-plugins.rst
>>> +++ b/docs/devel/tcg-plugins.rst
>>> @@ -497,6 +497,15 @@ arguments if required::
>>>     $ qemu-system-arm $(QEMU_ARGS) \
>>>       -plugin ./contrib/plugins/libexeclog.so,ifilter=3Dst1w,afilter=3D=
0x40001808 -d plugin
>>>   +This plugin can also dump a specified register. The
>>> specification of register
>>> +follows `GDB standard target features <https://sourceware.org/gdb/onli=
nedocs/gdb/Standard-Target-Features.html>`__.
>>> +
>>> +Specify the name of the feature that contains the register and the nam=
e of the
>>> +register with ``rfile`` and ``reg`` options, respectively::
>>> +
>>> +  $ qemu-system-arm $(QEMU_ARGS) \
>>> +    -plugin ./contrib/plugins/libexeclog.so,rfile=3Dorg.gnu.gdb.arm.co=
re,reg=3Dsp -d plugin
>>> +
>>>   - contrib/plugins/cache.c
>>>     Cache modelling plugin that measures the performance of a given
>>> L1 cache
>>> @@ -583,4 +592,3 @@ The following API is generated from the inline docu=
mentation in
>>>   include the full kernel-doc annotations.
>>>     .. kernel-doc:: include/qemu/qemu-plugin.h
>>> -
>>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>>> index 82dc2f584e..aa05840fd0 100644
>>> --- a/contrib/plugins/execlog.c
>>> +++ b/contrib/plugins/execlog.c
>>> @@ -15,27 +15,43 @@
>>>     #include <qemu-plugin.h>
>>>   +typedef struct CPU {
>>> +    /* Store last executed instruction on each vCPU as a GString */
>>> +    GString *last_exec;
>>> +    GByteArray *reg_history[2];
>>> +
>>> +    int reg;
>>> +} CPU;
>>> +
>>>   QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>>>=20=20=20
>> <snip>
>>>         /* Store new instruction in cache */
>>>       /* vcpu_mem will add memory access information to last_exec */
>>> -    g_string_printf(s, "%u, ", cpu_index);
>>> -    g_string_append(s, (char *)udata);
>>> +    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
>>> +    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
>>> +
>>> +    g_rw_lock_reader_unlock(&expand_array_lock);
>>>   }
>>>     /**
>>> @@ -167,8 +197,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, str=
uct qemu_plugin_tb *tb)
>>>                                                QEMU_PLUGIN_MEM_RW, NULL=
);
>>>                 /* Register callback on instruction */
>>> -            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exe=
c,
>>> -                                                   QEMU_PLUGIN_CB_NO_R=
EGS, output);
>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>> +                insn, vcpu_insn_exec,
>>> +                rfile_name ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO=
_REGS,
>>> +                output);
>>>                 /* reset skip */
>>>               skip =3D (imatches || amatches);
>>> @@ -177,17 +209,53 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, st=
ruct qemu_plugin_tb *tb)
>>>       }
>>>   }
>>>   +static void vcpu_init(qemu_plugin_id_t id, unsigned int
>>> vcpu_index)
>>> +{
>>> +    int reg =3D 0;
>>> +    bool found =3D false;
>>> +
>>> +    expand_cpu(vcpu_index);
>>> +
>>> +    if (rfile_name) {
>>> +        int i;
>>> +        int j;
>>> +        int n;
>>> +
>>> +        qemu_plugin_register_file_t *rfiles =3D
>>> +            qemu_plugin_get_register_files(vcpu_index, &n);
>>> +
>>> +        for (i =3D 0; i < n; i++) {
>>> +            if (g_strcmp0(rfiles[i].name, rfile_name) =3D=3D 0) {
>>> +                for (j =3D 0; j < rfiles[i].num_regs; j++) {
>>> +                    if (g_strcmp0(rfiles[i].regs[j], reg_name) =3D=3D =
0) {
>>> +                        reg +=3D j;
>>> +                        found =3D true;
>>> +                        break;
>>> +                    }
>>> +                }
>>> +                break;
>>> +            }
>>> +
>>> +            reg +=3D rfiles[i].num_regs;
>>> +        }
>>> +
>>> +        g_free(rfiles);
>>> +    }
>> This makes me question the value of exposing the register file
>> directly
>> to the plugin. I would much rather have a lookup utility function with
>> an optional tag. Something like:
>>    plugin_reg_t qemu_plugin_find_register(const char *name, const
>> char *tag);
>> And make tag optional. I think in the general case "name" should be
>> enough.
>
> I have explained the reason why I introduced register file abstraction
> instead of adding a function to look up a register for an earlier
> version of this series:
>> I added a function that returns all register information instead of a
>> function that looks up a register so that a plugin can enumerate
>> registers. Such capability is useful for a plugin that dumps all
>> registers or a plugin that simulates processor (such a plugin may want
>> to warn if there are unknown registers).

Fair enough. However I think a simple search interface will also be
useful for the more common case.=20

> How would you define name and tag? They are something we currently do
> not have, and I'm trying to add new types of identifiers since such
> identifiers will be needed to be defined for different architectures
> and require documentation and extra work to avoid name conflicts and
> ensure interface stability.

The name would be the register name which AFAICT are unique across the
system. If you have examples of clashes I'm curious as to what they are.
I'm still conflicted about baking gdb-isms into this ABI because they
aren't as stable as they could be either. Either way we do state:

  This is a new feature for QEMU and it does allow people to develop
  out-of-tree plugins that can be dynamically linked into a running QEMU
  process. However the project reserves the right to change or break the
  API should it need to do so. The best way to avoid this is to submit
  your plugin upstream so they can be updated if/when the API changes.

So I'm not overly concerned about formalising a stable ABI for now.

>
>>=20
>>> +
>>> +    g_rw_lock_writer_lock(&expand_array_lock);
>>> +    cpus[vcpu_index].reg =3D found ? reg : -1;
>>> +    g_rw_lock_writer_unlock(&expand_array_lock);
>>> +}
>>> +
>>>   /**
>>>    * On plugin exit, print last instruction in cache
>>>    */
>>>   static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>   {
>>>       guint i;
>>> -    GString *s;
>>> -    for (i =3D 0; i < last_exec->len; i++) {
>>> -        s =3D g_ptr_array_index(last_exec, i);
>>> -        if (s->str) {
>>> -            qemu_plugin_outs(s->str);
>>> +    for (i =3D 0; i < num_cpus; i++) {
>>> +        if (cpus[i].last_exec->str) {
>>> +            qemu_plugin_outs(cpus[i].last_exec->str);
>>>               qemu_plugin_outs("\n");
>>>           }
>>>       }
>>> @@ -224,9 +292,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>>>        * we don't know the size before emulation.
>>>        */
>>>       if (info->system_emulation) {
>>> -        last_exec =3D g_ptr_array_sized_new(info->system.max_vcpus);
>>> -    } else {
>>> -        last_exec =3D g_ptr_array_new();
>>> +        cpus =3D g_new(CPU, info->system.max_vcpus);
>>>       }
>>>         for (int i =3D 0; i < argc; i++) {
>>> @@ -236,13 +302,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_p=
lugin_id_t id,
>>>               parse_insn_match(tokens[1]);
>>>           } else if (g_strcmp0(tokens[0], "afilter") =3D=3D 0) {
>>>               parse_vaddr_match(tokens[1]);
>>> +        } else if (g_strcmp0(tokens[0], "rfile") =3D=3D 0) {
>>> +            rfile_name =3D g_strdup(tokens[1]);
>>> +        } else if (g_strcmp0(tokens[0], "reg") =3D=3D 0) {
>>> +            reg_name =3D g_strdup(tokens[1]);
>> And then instead of having the rfile/reg distinction support a
>> command
>> line like:
>>    qemu-aarch64 -plugin
>> contrib/plugins/libexeclog.so,reg=3Dsp,reg=3Dx1,reg=3Dsve:p1
>> so if the user specifies a reg of the form TAG:REG we can pass that
>> as
>> the option tag string. It also avoids exposing all the details of gdb to
>> plugins while still allowing the utility function to search by rname
>> internally (even if only a substring match?),
>
> That implicitly assumes TAG does not contain a colon. I'm avoiding to
> make such an implicit assumption because it is a reference for plugin
> writers who may create out-of-tree plugins. We should retrain
> ourselves to tell the plugin writers not to make such an assumption
> that may not hold in the future version of QEMU.
>
> I consider a substring match harmful for a similar reason. There is no
> guarantee that a future version of QEMU will not introduce a new
> register that match with the existing substring and break interface
> stability.
>
> It is not necessary that identifiers are consistent with ones GDB use.
> What matters here is that the identifiers are documented, stable and
> immune from conflicts.

We've a couple of cases of GDB having to issue new XML interface names
to handle cases where the previous definition missed important bits.
Hence my unease at exposing them to the plugin interface.

The plugin interface shouldn't (yet?) be regarded as a stable interface
(c.f. above).

>
>>=20
>>>           } else {
>>>               fprintf(stderr, "option parsing failed: %s\n", opt);
>>>               return -1;
>>>           }
>>>       }
>>>   +    if ((!rfile_name) !=3D (!reg_name)) {
>>> +        fputs("file and reg need to be set at the same time\n", stderr=
);
>>> +        return -1;
>>> +    }
>>> +
>>>       /* Register translation block and exit callbacks */
>>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C083188D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:38:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQim-0000Fx-JP; Thu, 18 Jan 2024 06:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQQik-0000Ed-4F
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:38:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQQih-000235-VY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:38:05 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so61475105e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705577882; x=1706182682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjgG5JfIuIuBtA+7Nc9QdPWRzOWJve3W+fE0BjVvE5M=;
 b=dymmo+nj0jKhCUAkyEyUnhLwjsG0bFCE3KBJ4b6SyPPZN8kWclkPPK/x6G2+eqRhuJ
 34AZQH1q03NYYzEPflbgaU2d38sftUjigDFenfQPkRO634MBu5xSR6Qht4QrDSDpcXnv
 6ZCccZuPALqDl8yqR6WrguRjY2whFyA0iOUR87zW3RFFkWAg351JCw0O8A+0+fqCrXVI
 AWof3K+VCrM4CgNKVqCwP+yk5fjwsoiEvqEiBdshi9Lmsv9tFMd254oU0gpK92+DYVDy
 R9Vf7nHF7JkwjCcIuzxRLn1MQEg4Ajph4bTfrqz5rWkFgWWJD1QnF/EzeeJP75+FQwPx
 1UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705577882; x=1706182682;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KjgG5JfIuIuBtA+7Nc9QdPWRzOWJve3W+fE0BjVvE5M=;
 b=TMAR0axxkx/b19RBny/zCEYPGPuRc5M1jCON3DMeLtH0nDAwQMW/6YNooux3Z4Qu2Z
 r8SwPG0kH4SrzJPkSacCZMcfwvN0iseCUwtRRAcbY5qh0Kj0HnIbaY7t45u7AFWNMALH
 FV8LTaNXgp5fjpyaOru4W10sfvnnlwoz1jMOf8RtV5eU6aphEu38W/Qh3NoTVg/txiBm
 Jsvo5IA7ND6lDXSZBAGrF92TCDbrS2q+5EpzAlcujPMC5RsGX5s2ICYS5MwuhhHinISA
 ugNzOkCpKdB7sRdqaDLmIMsQsvbYSoSxtZSpwDYfdBX0LbvIC/YTlfn+Fjp+5hLLGquR
 X7sw==
X-Gm-Message-State: AOJu0YzRjqvZm/appH/BMIm7I/VAcASluM6KoYvZsGRCCfS2ukmjYCrq
 XUwlShWS51tWb/B1VrrLAv7PouCMGFxUIghgyV9iDxTMWYtveI3f0l/28R1VlwQ=
X-Google-Smtp-Source: AGHT+IF5TbSayLJr9NP1r1mnOMgwi9LLFHrlYym9OhlEp6jCp+f3Pu5mOrKzkkzAe77sQf6/qt8fyw==
X-Received: by 2002:a05:600c:54f0:b0:40e:8bad:8c7c with SMTP id
 jb16-20020a05600c54f000b0040e8bad8c7cmr455864wmb.103.1705577882104; 
 Thu, 18 Jan 2024 03:38:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040e3733a32bsm29148302wmb.41.2024.01.18.03.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 03:38:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6963F5F8B4;
 Thu, 18 Jan 2024 11:38:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PULL 17/22] plugins: add an API to read registers
In-Reply-To: <4b2156ed-688d-4617-b52d-200413f01156@daynix.com> (Akihiko
 Odaki's message of "Wed, 17 Jan 2024 18:09:21 +0900")
References: <20240116104809.250076-1-alex.bennee@linaro.org>
 <20240116104809.250076-18-alex.bennee@linaro.org>
 <4b2156ed-688d-4617-b52d-200413f01156@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 18 Jan 2024 11:38:01 +0000
Message-ID: <87cytyhnxi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 2024/01/16 19:48, Alex Benn=C3=A9e wrote:
>> We can only request a list of registers once the vCPU has been
>> initialised so the user needs to use either call the get function on
>> vCPU initialisation or during the translation phase.
>> We don't expose the reg number to the plugin instead hiding it
>> behind
>> an opaque handle. This allows for a bit of future proofing should the
>> internals need to be changed while also being hashed against the
>> CPUClass so we can handle different register sets per-vCPU in
>> hetrogenous situations.
>> Having an internal state within the plugins also allows us to expand
>> the interface in future (for example providing callbacks on register
>> change if the translator can track changes).
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index 4daab6efd29..2c1930e7e45 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -11,6 +11,7 @@
>>   #ifndef QEMU_QEMU_PLUGIN_H
>>   #define QEMU_QEMU_PLUGIN_H
>>   +#include <glib.h>
>>   #include <inttypes.h>
>>   #include <stdbool.h>
>>   #include <stddef.h>
>> @@ -227,8 +228,8 @@ struct qemu_plugin_insn;
>>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>>    *
>> - * Note: currently unused, plugins cannot read or change system
>> - * register state.
>> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot cha=
nge
>> + * system register state.
>>    */
>>   enum qemu_plugin_cb_flags {
>>       QEMU_PLUGIN_CB_NO_REGS,
>> @@ -708,4 +709,50 @@ uint64_t qemu_plugin_end_code(void);
>>   QEMU_PLUGIN_API
>>   uint64_t qemu_plugin_entry_code(void);
>>   +/** struct qemu_plugin_register - Opaque handle for register
>> access */
>> +struct qemu_plugin_register;
>> +
>> +/**
>> + * typedef qemu_plugin_reg_descriptor - register descriptions
>> + *
>> + * @handle: opaque handle for retrieving value with qemu_plugin_read_re=
gister
>> + * @name: register name
>> + * @feature: optional feature descriptor, can be NULL
>> + */
>> +typedef struct {
>> +    struct qemu_plugin_register *handle;
>> +    const char *name;
>> +    const char *feature;
>> +} qemu_plugin_reg_descriptor;
>> +
>> +/**
>> + * qemu_plugin_get_registers() - return register list for vCPU
>> + * @vcpu_index: vcpu to query
>> + *
>> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
>> + * frees the array (but not the const strings).
>> + *
>> + * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
>> + * after the vCPU is initialised.
>> + */
>> +GArray *qemu_plugin_get_registers(unsigned int vcpu_index);
>> +
>> +/**
>> + * qemu_plugin_read_register() - read register
>> + *
>> + * @vcpu: vcpu index
>> + * @handle: a @qemu_plugin_reg_handle handle
>> + * @buf: A GByteArray for the data owned by the plugin
>> + *
>> + * This function is only available in a context that register read acce=
ss is
>> + * explicitly requested.
>> + *
>> + * Returns the size of the read register. The content of @buf is in tar=
get byte
>> + * order. On failure returns -1
>> + */
>> +int qemu_plugin_read_register(unsigned int vcpu,
>> +                              struct qemu_plugin_register *handle,
>> +                              GByteArray *buf);
>> +
>> +
>>   #endif /* QEMU_QEMU_PLUGIN_H */
>> diff --git a/plugins/api.c b/plugins/api.c
>> index ac39cdea0b3..8d5cca53295 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -8,6 +8,7 @@
>>    *
>>    *  qemu_plugin_tb
>>    *  qemu_plugin_insn
>> + *  qemu_plugin_register
>>    *
>>    * Which can then be passed back into the API to do additional things.
>>    * As such all the public functions in here are exported in
>> @@ -35,10 +36,12 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>>   #include "qemu/plugin.h"
>>   #include "qemu/log.h"
>>   #include "tcg/tcg.h"
>>   #include "exec/exec-all.h"
>> +#include "exec/gdbstub.h"
>>   #include "exec/ram_addr.h"
>>   #include "disas/disas.h"
>>   #include "plugin.h"
>> @@ -435,3 +438,111 @@ uint64_t qemu_plugin_entry_code(void)
>>   #endif
>>       return entry;
>>   }
>> +
>> +/*
>> + * Register handles
>> + *
>> + * The plugin infrastructure keeps hold of these internal data
>> + * structures which are presented to plugins as opaque handles. They
>> + * are global to the system and therefor additions to the hash table
>> + * must be protected by the @reg_handle_lock.
>
> The BQL should be used instead. This lock only serializes the plugin
> access, but the whole gdbstub code needs to be serialized to ensure
> the correct behaving of e.g., gdb_get_register_list().

Why does gdb_get_register_list need to take the BQL? It only works
through per-cpu structures. The reg_handle_lock only protects the hash
table itself.

>
>> + *
>> + * In order to future proof for up-coming heterogeneous work we want
>> + * different entries for each CPU type while sharing them in the
>> + * common case of multiple cores of the same type.
>
> I don't think such an effort should be done in the plugin code, but it
> should be done in the common gdbstub code.

Sure - we can always move it later.

> GDB assumes all threads have the same set of registers, so gdbstub
> will need to take care of them by running distinct GDB servers for
> each processor type, for example. There is a good chance that gdbstub
> will duplicate similar logic.

Which logic?

>
>> + */
>> +
>> +static QemuMutex reg_handle_lock;
>> +
>> +struct qemu_plugin_register {
>> +    const char *name;
>> +    int gdb_reg_num;
>> +};
>> +
>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>> +
>> +/* Generate a stable key - would xxhash be overkill? */
>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>> +{
>> +    uintptr_t key =3D (uintptr_t) cs->cc;
>> +    key ^=3D gdb_regnum;
>> +    return GUINT_TO_POINTER(key);
>> +}
>
> This is, theoretically, prone to collisions and unsafe.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


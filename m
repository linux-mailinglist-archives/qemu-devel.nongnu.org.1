Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81F835EC0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:54:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqzz-0000J5-SK; Mon, 22 Jan 2024 04:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRqzy-0000IU-3k
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:53:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRqzw-0004A8-0j
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:53:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ea5654271so18973475e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705917222; x=1706522022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThGwpu9lN1p5xHZLe22/HUmHYCnKVollP83E7lHBrp4=;
 b=M8RyToaddMU++NVW2BJL4d/hnPK447JvZgkmILkWGIvM+pVxebQvjYrruXH+evmqrw
 d7Aw1fiQYiQyroyh43LklalgdSGlJet8GRxJHv3TmUHAkwdlX/cUz1UY+LDWUBcmM7VC
 KEfa0IIci6BrHXsxM9zSjtt5653d/PCxLAXyvJ/R/uHQ0RUKxWyRUySOGlTWa21dSS00
 DJdAfepfkb3ZstSX9WUfxvJyyglNdwBAtPLk5k6KPSTCnS7WNfC5FE1w3WkNjnzPBOa0
 3IRjk7LSJL24w3kt9xMxFG8OpzLczGpERucLJ0ZxY8GQ/EK4CqEHgAwTJwc6Uek3DKVH
 VAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705917222; x=1706522022;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThGwpu9lN1p5xHZLe22/HUmHYCnKVollP83E7lHBrp4=;
 b=YiReB9eH3qbLyP1GH/ldslA849sKQodJYz3gPlr8YCBPjP3tjzSzlS1ryuk6a+19tN
 k497ThwlvV3oNt0D9nD28UZdqozTyO5ZjelbDt5UiYcDGrhAs7W6tDpXwFlX7gDvZ8Cd
 J/WypE7WfE5mmaXycHKu8OIOPlpkwR1FUuPGB8j6DqotksFowJjmBDoSOCj9n5nhLEXR
 8zK81R4L1BnKYylmFnpulmGEhLNx1Q4e6BPPqY3GatCPEryneK8Pwdfcr53y9zaQDBoi
 Ydn9XeZgoSEkemlfYKc4quRuynx1lpcTF+an7b5azdMRbXbsoVmb8ShGSZ8abFcMEXGL
 ESpg==
X-Gm-Message-State: AOJu0Yw3UsLvMae76gpO/HocHG4aCOy2BAPPj6GQTaC6ylrc3Gp5TcVI
 CYjwMZG1CDmxM0Kf9mq2ZVwBf8XU3CqsEGszRK35Ndwzudj5c4zdeHLm4LYK+WQ=
X-Google-Smtp-Source: AGHT+IEddBwcQfl52Udmp5Ei+HMRNw73gZwy8QV8LYvm72BCsOkJBjfhgkC5nhUe5BZqGDylCe1TWA==
X-Received: by 2002:a05:600c:3781:b0:40e:6803:bcb6 with SMTP id
 o1-20020a05600c378100b0040e6803bcb6mr1990219wmr.170.1705917222343; 
 Mon, 22 Jan 2024 01:53:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040e3bdff98asm42020439wmn.23.2024.01.22.01.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:53:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9301B5F7AE;
 Mon, 22 Jan 2024 09:53:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PULL 17/22] plugins: add an API to read registers
In-Reply-To: <b872f23b-a992-489d-856c-9321576a4d29@daynix.com> (Akihiko
 Odaki's message of "Sun, 21 Jan 2024 23:36:58 +0900")
References: <20240116104809.250076-1-alex.bennee@linaro.org>
 <20240116104809.250076-18-alex.bennee@linaro.org>
 <4b2156ed-688d-4617-b52d-200413f01156@daynix.com>
 <87cytyhnxi.fsf@draig.linaro.org>
 <b872f23b-a992-489d-856c-9321576a4d29@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 22 Jan 2024 09:53:41 +0000
Message-ID: <87le8hofru.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> On 2024/01/18 20:38, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/01/16 19:48, Alex Benn=C3=A9e wrote:
>>>> We can only request a list of registers once the vCPU has been
>>>> initialised so the user needs to use either call the get function on
>>>> vCPU initialisation or during the translation phase.
>>>> We don't expose the reg number to the plugin instead hiding it
>>>> behind
>>>> an opaque handle. This allows for a bit of future proofing should the
>>>> internals need to be changed while also being hashed against the
>>>> CPUClass so we can handle different register sets per-vCPU in
>>>> hetrogenous situations.
>>>> Having an internal state within the plugins also allows us to expand
>>>> the interface in future (for example providing callbacks on register
>>>> change if the translator can track changes).
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>>> index 4daab6efd29..2c1930e7e45 100644
>>>> --- a/include/qemu/qemu-plugin.h
>>>> +++ b/include/qemu/qemu-plugin.h
>>>> @@ -11,6 +11,7 @@
>>>>    #ifndef QEMU_QEMU_PLUGIN_H
>>>>    #define QEMU_QEMU_PLUGIN_H
>>>>    +#include <glib.h>
>>>>    #include <inttypes.h>
>>>>    #include <stdbool.h>
>>>>    #include <stddef.h>
>>>> @@ -227,8 +228,8 @@ struct qemu_plugin_insn;
>>>>     * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>>>>     * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>>>>     *
>>>> - * Note: currently unused, plugins cannot read or change system
>>>> - * register state.
>>>> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot c=
hange
>>>> + * system register state.
>>>>     */
>>>>    enum qemu_plugin_cb_flags {
>>>>        QEMU_PLUGIN_CB_NO_REGS,
>>>> @@ -708,4 +709,50 @@ uint64_t qemu_plugin_end_code(void);
>>>>    QEMU_PLUGIN_API
>>>>    uint64_t qemu_plugin_entry_code(void);
>>>>    +/** struct qemu_plugin_register - Opaque handle for register
>>>> access */
>>>> +struct qemu_plugin_register;
>>>> +
>>>> +/**
>>>> + * typedef qemu_plugin_reg_descriptor - register descriptions
>>>> + *
>>>> + * @handle: opaque handle for retrieving value with qemu_plugin_read_=
register
>>>> + * @name: register name
>>>> + * @feature: optional feature descriptor, can be NULL
>>>> + */
>>>> +typedef struct {
>>>> +    struct qemu_plugin_register *handle;
>>>> +    const char *name;
>>>> +    const char *feature;
>>>> +} qemu_plugin_reg_descriptor;
>>>> +
>>>> +/**
>>>> + * qemu_plugin_get_registers() - return register list for vCPU
>>>> + * @vcpu_index: vcpu to query
>>>> + *
>>>> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
>>>> + * frees the array (but not the const strings).
>>>> + *
>>>> + * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
>>>> + * after the vCPU is initialised.
>>>> + */
>>>> +GArray *qemu_plugin_get_registers(unsigned int vcpu_index);
>>>> +
>>>> +/**
>>>> + * qemu_plugin_read_register() - read register
>>>> + *
>>>> + * @vcpu: vcpu index
>>>> + * @handle: a @qemu_plugin_reg_handle handle
>>>> + * @buf: A GByteArray for the data owned by the plugin
>>>> + *
>>>> + * This function is only available in a context that register read ac=
cess is
>>>> + * explicitly requested.
>>>> + *
>>>> + * Returns the size of the read register. The content of @buf is in t=
arget byte
>>>> + * order. On failure returns -1
>>>> + */
>>>> +int qemu_plugin_read_register(unsigned int vcpu,
>>>> +                              struct qemu_plugin_register *handle,
>>>> +                              GByteArray *buf);
>>>> +
>>>> +
>>>>    #endif /* QEMU_QEMU_PLUGIN_H */
>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>> index ac39cdea0b3..8d5cca53295 100644
>>>> --- a/plugins/api.c
>>>> +++ b/plugins/api.c
>>>> @@ -8,6 +8,7 @@
>>>>     *
>>>>     *  qemu_plugin_tb
>>>>     *  qemu_plugin_insn
>>>> + *  qemu_plugin_register
>>>>     *
>>>>     * Which can then be passed back into the API to do additional thin=
gs.
>>>>     * As such all the public functions in here are exported in
>>>> @@ -35,10 +36,12 @@
>>>>     */
>>>>      #include "qemu/osdep.h"
>>>> +#include "qemu/main-loop.h"
>>>>    #include "qemu/plugin.h"
>>>>    #include "qemu/log.h"
>>>>    #include "tcg/tcg.h"
>>>>    #include "exec/exec-all.h"
>>>> +#include "exec/gdbstub.h"
>>>>    #include "exec/ram_addr.h"
>>>>    #include "disas/disas.h"
>>>>    #include "plugin.h"
>>>> @@ -435,3 +438,111 @@ uint64_t qemu_plugin_entry_code(void)
>>>>    #endif
>>>>        return entry;
>>>>    }
>>>> +
>>>> +/*
>>>> + * Register handles
>>>> + *
>>>> + * The plugin infrastructure keeps hold of these internal data
>>>> + * structures which are presented to plugins as opaque handles. They
>>>> + * are global to the system and therefor additions to the hash table
>>>> + * must be protected by the @reg_handle_lock.
>>>
>>> The BQL should be used instead. This lock only serializes the plugin
>>> access, but the whole gdbstub code needs to be serialized to ensure
>>> the correct behaving of e.g., gdb_get_register_list().
>> Why does gdb_get_register_list need to take the BQL? It only works
>> through per-cpu structures. The reg_handle_lock only protects the hash
>> table itself.
>>=20
>>>
>>>> + *
>>>> + * In order to future proof for up-coming heterogeneous work we want
>>>> + * different entries for each CPU type while sharing them in the
>>>> + * common case of multiple cores of the same type.
>>>
>>> I don't think such an effort should be done in the plugin code, but it
>>> should be done in the common gdbstub code.
>> Sure - we can always move it later.
>>=20
>>> GDB assumes all threads have the same set of registers, so gdbstub
>>> will need to take care of them by running distinct GDB servers for
>>> each processor type, for example. There is a good chance that gdbstub
>>> will duplicate similar logic.
>> Which logic?
> reg_handles, a GHashTable, is used to detect the duplicate definitions
> of a register in processors with same type, but such a logic is
> probably better off to be implemented in gdbstub; gdbstub should have
> one definition of register set for each type of processors in a
> system, and gdbstub can use it to start a distinct GDB server for the
> type. This way, gdbstub can ensure it exposes a homogeneous view for
> each GDB server as GDB requires.
>
> If gdbstub already has such a logic, the plugin infrastructure can
> just query gdbstub for a common, shared register set used for a
> processor type; it will no longer have to check for duplicate
> definitions with a hash table.

I think we can move this after the merge to do further clean-up. There
are other register details plugins might want to track itself. For
example the translator has knowledge of some registers that it knows
when they are updated (due to using translator static TCGv defs). We
wouldn't want to expose that via gdbstub.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


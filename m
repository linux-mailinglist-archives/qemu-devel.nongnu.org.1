Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5F8301ED
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1vO-0005BA-MN; Wed, 17 Jan 2024 04:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ1vL-0005Al-RB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:09:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ1vJ-0005M7-D7
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:09:27 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso90241715ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 01:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705482564; x=1706087364;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cayWeOSYd+awB8nQaHoeEfGa+ph4PGDB9QPCqtzT6Wc=;
 b=jMUW6AiUdcdY+iG0A7lDiVhoTC3CLBqmfhhQ6Bn8AKOpwahzqqfD1FMAsd/QoQHUio
 BIQBkMdniDnKEcfhREtDxAcRmapZhVPE8KDn84d4vCVyuD+WiYggVHqfKh/3cfFq6tDu
 KLCvBO3an/28dcbDRKDa0xjOvNyJy8ah9sbVUev7Dzo6hRJN/iOMYQnsQzTDj3qgjuLG
 PhQCGCf2cmZ5G/XzmTX9JtlZkhrNV+raY5Z94M2CNtCwMGJYdrcQ7xgs8bXinNRWpKbA
 fP8uWxyDvv4rkbag+9oHl1GoIB2e//EsGMbjGSQShfvG+R3KSCw/q6oIremplNUATPwI
 JClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705482564; x=1706087364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cayWeOSYd+awB8nQaHoeEfGa+ph4PGDB9QPCqtzT6Wc=;
 b=MtJFPC4hVXHAe+qn/FxzisWKu5BVSAnfqEkqvORopiz+35inRx1+B9H+KzdXoj+osP
 1aHHpNencl+MtAv+3vctAJEYLekg4cwlGsj9E3RGHlEv9DIVqqeETqiRr2ub3CKrVAGI
 /Lr6g/7anfHqGs5sxP3xs+ygzLFSkLEARNM8Z6XLhlM/pe7yRTNa+j817eiBs69cJsjI
 j+6SxceWJnLKwABLK8+03m1MgLMzjkAVexBhWLNX7dEVWa/Ac9PZQKKMhB38Ue+D23K5
 p0qtsv55sN/5yhmhTq/uNy/srfnRI8nhGZsCgpaxRW7HKDDx5IUKefxubXVSwBXtTfqp
 YxOA==
X-Gm-Message-State: AOJu0Yz3Djwi4PVv6peEkgArfUPLBGlP6rnOkBoLIaXa9O+AMa+RGawm
 UxEf5dUM73I5n57HAatL80jip8d0ePdD4Q==
X-Google-Smtp-Source: AGHT+IG+4heYlsAby8YrzEiXjM/t5EzwwCG+ZLTqpZKcNSrNbsouiyeBQAvsDM6HE//rEUJGUhCo1w==
X-Received: by 2002:a17:902:e844:b0:1d4:d0e8:f9c8 with SMTP id
 t4-20020a170902e84400b001d4d0e8f9c8mr11163438plg.37.1705482563871; 
 Wed, 17 Jan 2024 01:09:23 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 kn7-20020a170903078700b001d6f66ddef3sm249029plb.51.2024.01.17.01.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 01:09:23 -0800 (PST)
Message-ID: <4b2156ed-688d-4617-b52d-200413f01156@daynix.com>
Date: Wed, 17 Jan 2024 18:09:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/22] plugins: add an API to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
 <20240116104809.250076-18-alex.bennee@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240116104809.250076-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/16 19:48, Alex Bennée wrote:
> We can only request a list of registers once the vCPU has been
> initialised so the user needs to use either call the get function on
> vCPU initialisation or during the translation phase.
> 
> We don't expose the reg number to the plugin instead hiding it behind
> an opaque handle. This allows for a bit of future proofing should the
> internals need to be changed while also being hashed against the
> CPUClass so we can handle different register sets per-vCPU in
> hetrogenous situations.
> 
> Having an internal state within the plugins also allows us to expand
> the interface in future (for example providing callbacks on register
> change if the translator can track changes).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 4daab6efd29..2c1930e7e45 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -11,6 +11,7 @@
>   #ifndef QEMU_QEMU_PLUGIN_H
>   #define QEMU_QEMU_PLUGIN_H
>   
> +#include <glib.h>
>   #include <inttypes.h>
>   #include <stdbool.h>
>   #include <stddef.h>
> @@ -227,8 +228,8 @@ struct qemu_plugin_insn;
>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>    *
> - * Note: currently unused, plugins cannot read or change system
> - * register state.
> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
> + * system register state.
>    */
>   enum qemu_plugin_cb_flags {
>       QEMU_PLUGIN_CB_NO_REGS,
> @@ -708,4 +709,50 @@ uint64_t qemu_plugin_end_code(void);
>   QEMU_PLUGIN_API
>   uint64_t qemu_plugin_entry_code(void);
>   
> +/** struct qemu_plugin_register - Opaque handle for register access */
> +struct qemu_plugin_register;
> +
> +/**
> + * typedef qemu_plugin_reg_descriptor - register descriptions
> + *
> + * @handle: opaque handle for retrieving value with qemu_plugin_read_register
> + * @name: register name
> + * @feature: optional feature descriptor, can be NULL
> + */
> +typedef struct {
> +    struct qemu_plugin_register *handle;
> +    const char *name;
> +    const char *feature;
> +} qemu_plugin_reg_descriptor;
> +
> +/**
> + * qemu_plugin_get_registers() - return register list for vCPU
> + * @vcpu_index: vcpu to query
> + *
> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
> + * frees the array (but not the const strings).
> + *
> + * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
> + * after the vCPU is initialised.
> + */
> +GArray *qemu_plugin_get_registers(unsigned int vcpu_index);
> +
> +/**
> + * qemu_plugin_read_register() - read register
> + *
> + * @vcpu: vcpu index
> + * @handle: a @qemu_plugin_reg_handle handle
> + * @buf: A GByteArray for the data owned by the plugin
> + *
> + * This function is only available in a context that register read access is
> + * explicitly requested.
> + *
> + * Returns the size of the read register. The content of @buf is in target byte
> + * order. On failure returns -1
> + */
> +int qemu_plugin_read_register(unsigned int vcpu,
> +                              struct qemu_plugin_register *handle,
> +                              GByteArray *buf);
> +
> +
>   #endif /* QEMU_QEMU_PLUGIN_H */
> diff --git a/plugins/api.c b/plugins/api.c
> index ac39cdea0b3..8d5cca53295 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -8,6 +8,7 @@
>    *
>    *  qemu_plugin_tb
>    *  qemu_plugin_insn
> + *  qemu_plugin_register
>    *
>    * Which can then be passed back into the API to do additional things.
>    * As such all the public functions in here are exported in
> @@ -35,10 +36,12 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>   #include "qemu/plugin.h"
>   #include "qemu/log.h"
>   #include "tcg/tcg.h"
>   #include "exec/exec-all.h"
> +#include "exec/gdbstub.h"
>   #include "exec/ram_addr.h"
>   #include "disas/disas.h"
>   #include "plugin.h"
> @@ -435,3 +438,111 @@ uint64_t qemu_plugin_entry_code(void)
>   #endif
>       return entry;
>   }
> +
> +/*
> + * Register handles
> + *
> + * The plugin infrastructure keeps hold of these internal data
> + * structures which are presented to plugins as opaque handles. They
> + * are global to the system and therefor additions to the hash table
> + * must be protected by the @reg_handle_lock.

The BQL should be used instead. This lock only serializes the plugin 
access, but the whole gdbstub code needs to be serialized to ensure the 
correct behaving of e.g., gdb_get_register_list().

> + *
> + * In order to future proof for up-coming heterogeneous work we want
> + * different entries for each CPU type while sharing them in the
> + * common case of multiple cores of the same type.

I don't think such an effort should be done in the plugin code, but it 
should be done in the common gdbstub code.

GDB assumes all threads have the same set of registers, so gdbstub will 
need to take care of them by running distinct GDB servers for each 
processor type, for example. There is a good chance that gdbstub will 
duplicate similar logic.

> + */
> +
> +static QemuMutex reg_handle_lock;
> +
> +struct qemu_plugin_register {
> +    const char *name;
> +    int gdb_reg_num;
> +};
> +
> +static GHashTable *reg_handles; /* hash table of PluginReg */
> +
> +/* Generate a stable key - would xxhash be overkill? */
> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
> +{
> +    uintptr_t key = (uintptr_t) cs->cc;
> +    key ^= gdb_regnum;
> +    return GUINT_TO_POINTER(key);
> +}

This is, theoretically, prone to collisions and unsafe.


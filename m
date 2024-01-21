Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20668835627
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 15:38:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRYwh-0001nM-UM; Sun, 21 Jan 2024 09:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rRYwd-0001kp-Gf
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 09:37:07 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rRYwa-0000yR-5W
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 09:37:06 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6dbdbddc180so313124b3a.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705847822; x=1706452622;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x5bovMyB+xlKv2Vyli+jBAUdsWO8rW3ItMprWjw87zo=;
 b=DZ+hJfmKQ8/59HBjE2ZsaNzbnBfa08hT5Q5YAvAJ2sbS9X0d0mu8RKoQSImCk3cKBU
 9xStl7Wc2KPf7wK0t/hwDuL1eE5yRDFr1be5GenUIjApBsoj6CH0285mV/2gwoG4G+Y6
 6ki163oNiTAfBXfbel60ohIY8CgOzdHp2v0luH3NeB+HbfXFjtLvMrN7L3iisM5MrOVG
 pJmZae9onAgLKiCV/cC63YJPoXApaJC/SQXlYqeMk8uvdbcKMAtyN11o/pvSAgKwxY2G
 KHU8hdQcKsX9v6gBPrYxexAIlRnpwTj0wNDYmouVobZT7q6sxP/vkv5OQc7FsSWyfcPN
 VkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705847822; x=1706452622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x5bovMyB+xlKv2Vyli+jBAUdsWO8rW3ItMprWjw87zo=;
 b=LI0GWf4DAjkTBy2jQudNnzdzA213mEoJq/3SQpbQZV5mOGsCm0UElhuGhafqnWoT/Z
 14ycilrFARd61QBXjtYhHTiObgWFWxvZiPMsi4Q6UwN/GBlrYdP45BL+3COXMPz2UVIy
 lb5UjoVNyJAtzb+SnO/PmA/tOlmw6LCwuy9C2ctJpj6aWSdbm+XVE4pBpBTQ6r2DMQEc
 ny6n7rXS5IwULJR0pvHDyVK5P+S7pCQY5QXTmPZy7usQPW5HCVxU67opEFnTVc8OWvtf
 IwPYRkxK6AhHNtp4luLJTmssvE5//9injo8Xb9vL+WhbPpgQAfEwsRTcqZ7aULxJvMQ9
 4mqQ==
X-Gm-Message-State: AOJu0YyM6F0k15BLzDSanvtqXKDLm3a6BLb8sQ0o7fJlaExRQuFk/J78
 po4UdJHYG3pp+UI3LighRSzAOa3Ia3ykLWZNSYUAubVpisGrYBewQyy9ScghTbc=
X-Google-Smtp-Source: AGHT+IEmVLsVYdXjnFVH/XXPYjzZbTAU9WdkV3ei+OCBL+swGDTx/3/f3N+FvnhAfgGXfAMc/ZVrdg==
X-Received: by 2002:a05:6a20:8e0a:b0:19b:155c:7e5c with SMTP id
 y10-20020a056a208e0a00b0019b155c7e5cmr3810828pzj.39.1705847822163; 
 Sun, 21 Jan 2024 06:37:02 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 u30-20020a63471e000000b0059b2316be86sm6608989pga.46.2024.01.21.06.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jan 2024 06:37:01 -0800 (PST)
Message-ID: <b872f23b-a992-489d-856c-9321576a4d29@daynix.com>
Date: Sun, 21 Jan 2024 23:36:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/22] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
 <20240116104809.250076-18-alex.bennee@linaro.org>
 <4b2156ed-688d-4617-b52d-200413f01156@daynix.com>
 <87cytyhnxi.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cytyhnxi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

On 2024/01/18 20:38, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/01/16 19:48, Alex Bennée wrote:
>>> We can only request a list of registers once the vCPU has been
>>> initialised so the user needs to use either call the get function on
>>> vCPU initialisation or during the translation phase.
>>> We don't expose the reg number to the plugin instead hiding it
>>> behind
>>> an opaque handle. This allows for a bit of future proofing should the
>>> internals need to be changed while also being hashed against the
>>> CPUClass so we can handle different register sets per-vCPU in
>>> hetrogenous situations.
>>> Having an internal state within the plugins also allows us to expand
>>> the interface in future (for example providing callbacks on register
>>> change if the translator can track changes).
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>> index 4daab6efd29..2c1930e7e45 100644
>>> --- a/include/qemu/qemu-plugin.h
>>> +++ b/include/qemu/qemu-plugin.h
>>> @@ -11,6 +11,7 @@
>>>    #ifndef QEMU_QEMU_PLUGIN_H
>>>    #define QEMU_QEMU_PLUGIN_H
>>>    +#include <glib.h>
>>>    #include <inttypes.h>
>>>    #include <stdbool.h>
>>>    #include <stddef.h>
>>> @@ -227,8 +228,8 @@ struct qemu_plugin_insn;
>>>     * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>>>     * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>>>     *
>>> - * Note: currently unused, plugins cannot read or change system
>>> - * register state.
>>> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
>>> + * system register state.
>>>     */
>>>    enum qemu_plugin_cb_flags {
>>>        QEMU_PLUGIN_CB_NO_REGS,
>>> @@ -708,4 +709,50 @@ uint64_t qemu_plugin_end_code(void);
>>>    QEMU_PLUGIN_API
>>>    uint64_t qemu_plugin_entry_code(void);
>>>    +/** struct qemu_plugin_register - Opaque handle for register
>>> access */
>>> +struct qemu_plugin_register;
>>> +
>>> +/**
>>> + * typedef qemu_plugin_reg_descriptor - register descriptions
>>> + *
>>> + * @handle: opaque handle for retrieving value with qemu_plugin_read_register
>>> + * @name: register name
>>> + * @feature: optional feature descriptor, can be NULL
>>> + */
>>> +typedef struct {
>>> +    struct qemu_plugin_register *handle;
>>> +    const char *name;
>>> +    const char *feature;
>>> +} qemu_plugin_reg_descriptor;
>>> +
>>> +/**
>>> + * qemu_plugin_get_registers() - return register list for vCPU
>>> + * @vcpu_index: vcpu to query
>>> + *
>>> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
>>> + * frees the array (but not the const strings).
>>> + *
>>> + * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
>>> + * after the vCPU is initialised.
>>> + */
>>> +GArray *qemu_plugin_get_registers(unsigned int vcpu_index);
>>> +
>>> +/**
>>> + * qemu_plugin_read_register() - read register
>>> + *
>>> + * @vcpu: vcpu index
>>> + * @handle: a @qemu_plugin_reg_handle handle
>>> + * @buf: A GByteArray for the data owned by the plugin
>>> + *
>>> + * This function is only available in a context that register read access is
>>> + * explicitly requested.
>>> + *
>>> + * Returns the size of the read register. The content of @buf is in target byte
>>> + * order. On failure returns -1
>>> + */
>>> +int qemu_plugin_read_register(unsigned int vcpu,
>>> +                              struct qemu_plugin_register *handle,
>>> +                              GByteArray *buf);
>>> +
>>> +
>>>    #endif /* QEMU_QEMU_PLUGIN_H */
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index ac39cdea0b3..8d5cca53295 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -8,6 +8,7 @@
>>>     *
>>>     *  qemu_plugin_tb
>>>     *  qemu_plugin_insn
>>> + *  qemu_plugin_register
>>>     *
>>>     * Which can then be passed back into the API to do additional things.
>>>     * As such all the public functions in here are exported in
>>> @@ -35,10 +36,12 @@
>>>     */
>>>      #include "qemu/osdep.h"
>>> +#include "qemu/main-loop.h"
>>>    #include "qemu/plugin.h"
>>>    #include "qemu/log.h"
>>>    #include "tcg/tcg.h"
>>>    #include "exec/exec-all.h"
>>> +#include "exec/gdbstub.h"
>>>    #include "exec/ram_addr.h"
>>>    #include "disas/disas.h"
>>>    #include "plugin.h"
>>> @@ -435,3 +438,111 @@ uint64_t qemu_plugin_entry_code(void)
>>>    #endif
>>>        return entry;
>>>    }
>>> +
>>> +/*
>>> + * Register handles
>>> + *
>>> + * The plugin infrastructure keeps hold of these internal data
>>> + * structures which are presented to plugins as opaque handles. They
>>> + * are global to the system and therefor additions to the hash table
>>> + * must be protected by the @reg_handle_lock.
>>
>> The BQL should be used instead. This lock only serializes the plugin
>> access, but the whole gdbstub code needs to be serialized to ensure
>> the correct behaving of e.g., gdb_get_register_list().
> 
> Why does gdb_get_register_list need to take the BQL? It only works
> through per-cpu structures. The reg_handle_lock only protects the hash
> table itself.
> 
>>
>>> + *
>>> + * In order to future proof for up-coming heterogeneous work we want
>>> + * different entries for each CPU type while sharing them in the
>>> + * common case of multiple cores of the same type.
>>
>> I don't think such an effort should be done in the plugin code, but it
>> should be done in the common gdbstub code.
> 
> Sure - we can always move it later.
> 
>> GDB assumes all threads have the same set of registers, so gdbstub
>> will need to take care of them by running distinct GDB servers for
>> each processor type, for example. There is a good chance that gdbstub
>> will duplicate similar logic.
> 
> Which logic?
reg_handles, a GHashTable, is used to detect the duplicate definitions 
of a register in processors with same type, but such a logic is probably 
better off to be implemented in gdbstub; gdbstub should have one 
definition of register set for each type of processors in a system, and 
gdbstub can use it to start a distinct GDB server for the type. This 
way, gdbstub can ensure it exposes a homogeneous view for each GDB 
server as GDB requires.

If gdbstub already has such a logic, the plugin infrastructure can just 
query gdbstub for a common, shared register set used for a processor 
type; it will no longer have to check for duplicate definitions with a 
hash table.


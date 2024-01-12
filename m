Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79B82BC70
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 09:42:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOD68-00067X-3n; Fri, 12 Jan 2024 03:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOD65-000679-UL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:41:01 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOD63-0000Ly-RU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:41:01 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d45f182fa2so52967325ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705048858; x=1705653658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5lm+D5rlYE9I56izKwtMlCFPbjv13wSdaNwDyy8ZAjY=;
 b=QzyxIP57avfS+umBhj7LIDEbWzQtfd65d5Qgb9V985oChO6omkdtyOi94Ar7VOsueO
 S61dqQ/pvESTec+Oge5DEbSQLfaoCyjdH5aLun/OlANLyJf5BjfwdeiTU7csb8Zf+0Ti
 Nhf0hAXMyfYjMTCJFmiaZyGL8g1E/CboqjldTrTyalk0ZjTEvhvLzRxPirDN5fQ6VvlY
 PWVJa0V2pMOr9m7i2//oZvc189lt1bBAK69XoWTzDEa4pfjlZc4eIedujwSrI48fQquR
 uIcoSkr+hVcQsvIhw9IhgiiNSq5yzvpx8XNobdmHtNHXHb9REiShNYVsLL690/vrwZme
 Gdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705048858; x=1705653658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5lm+D5rlYE9I56izKwtMlCFPbjv13wSdaNwDyy8ZAjY=;
 b=a4IztMUPv/cNWjsWgtU3ycymMDJui51oSBEly07obV1Ov0d0n3ncw7BODBFnVpaw1e
 L5ZeOlEBLDBafXao295B1lDQA3QwBLzadjzm+xBdAgPV6iO+shiRXoCazdLkuihJwCuH
 cTxbdmMtuydL4dHNIEavaLavsfEWBwayOlyD5iSvt5fIgChvKdxK0XLWcnDi/gWgEaiE
 LtttSpoQwf81slEw8w3t9/fq3mWe2faf33a8YGlM/yHpiJpWV5tc7wg3l3Jv5meAqCBm
 PC6DT7GTZqRSB2S6/PE2DsfFSIqTj6rE2eoNCT60xM6eiV0jxc+Fdv2aqxZr+AWnHiXv
 znJw==
X-Gm-Message-State: AOJu0Yz1b9PKzTLEySM8W8ujZePDT3Mr4jWAtBDmBrZKybjwZZpBaH8E
 ZVD9cqMzAdq00eQIGALhnXikSf+W8IhI9A==
X-Google-Smtp-Source: AGHT+IHYRxT/z9ZgpMZ9vBDRJxZrrOYpzqieeMgYQ0+5o5v5VZShX5BK2EdUt/1HfsjUNnNAc7CT1w==
X-Received: by 2002:a17:903:1251:b0:1d4:7d37:d448 with SMTP id
 u17-20020a170903125100b001d47d37d448mr692071plh.44.1705048858017; 
 Fri, 12 Jan 2024 00:40:58 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:6327:94c1:b7f6:cf28?
 ([2001:8004:2728:2ad6:6327:94c1:b7f6:cf28])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a170902ab8900b001d09c5424d4sm2547067plr.297.2024.01.12.00.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 00:40:57 -0800 (PST)
Message-ID: <b495146f-c523-4a97-b703-12b226251af5@linaro.org>
Date: Fri, 12 Jan 2024 19:40:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] tests/plugin/inline: migrate to new per_vcpu API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-5-pierrick.bouvier@linaro.org>
 <09812aba-9595-410d-9b27-d33353f33b02@linaro.org>
 <b99b7e20-9802-42c9-bd34-2727cd508da5@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b99b7e20-9802-42c9-bd34-2727cd508da5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/12/24 14:51, Pierrick Bouvier wrote:
> On 1/12/24 02:10, Richard Henderson wrote:
>> On 1/12/24 01:23, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    tests/plugin/inline.c | 17 -----------------
>>>    1 file changed, 17 deletions(-)
>>
>> Was this supposed to be together with patch 6?
>>
> 
> My goal was to have a version that still uses original API.
> If you prefer this to be squashed, no problem to do it.

My confusion is that this patch does not "migrate" anything -- it only removes code.  Is 
the just that the description is inaccurate?  But it appears that the combination of 4+6 
would "migrate" to the new API.


r~

> 
>> r~
>>
>>>
>>> diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
>>> index 6114ebca545..ae59f7af7a7 100644
>>> --- a/tests/plugin/inline.c
>>> +++ b/tests/plugin/inline.c
>>> @@ -18,15 +18,12 @@
>>>    static uint64_t count_tb;
>>>    static uint64_t count_tb_per_vcpu[MAX_CPUS];
>>>    static uint64_t count_tb_inline_per_vcpu[MAX_CPUS];
>>> -static uint64_t count_tb_inline_racy;
>>>    static uint64_t count_insn;
>>>    static uint64_t count_insn_per_vcpu[MAX_CPUS];
>>>    static uint64_t count_insn_inline_per_vcpu[MAX_CPUS];
>>> -static uint64_t count_insn_inline_racy;
>>>    static uint64_t count_mem;
>>>    static uint64_t count_mem_per_vcpu[MAX_CPUS];
>>>    static uint64_t count_mem_inline_per_vcpu[MAX_CPUS];
>>> -static uint64_t count_mem_inline_racy;
>>>    static GMutex tb_lock;
>>>    static GMutex insn_lock;
>>>    static GMutex mem_lock;
>>> @@ -50,11 +47,9 @@ static void stats_insn(void)
>>>        printf("insn: %" PRIu64 "\n", expected);
>>>        printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>>        printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>>> -    printf("insn: %" PRIu64 " (inline racy)\n", count_insn_inline_racy);
>>>        g_assert(expected > 0);
>>>        g_assert(per_vcpu == expected);
>>>        g_assert(inl_per_vcpu == expected);
>>> -    g_assert(count_insn_inline_racy <= expected);
>>>    }
>>>    static void stats_tb(void)
>>> @@ -65,11 +60,9 @@ static void stats_tb(void)
>>>        printf("tb: %" PRIu64 "\n", expected);
>>>        printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>>        printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>>> -    printf("tb: %" PRIu64 " (inline racy)\n", count_tb_inline_racy);
>>>        g_assert(expected > 0);
>>>        g_assert(per_vcpu == expected);
>>>        g_assert(inl_per_vcpu == expected);
>>> -    g_assert(count_tb_inline_racy <= expected);
>>>    }
>>>    static void stats_mem(void)
>>> @@ -80,11 +73,9 @@ static void stats_mem(void)
>>>        printf("mem: %" PRIu64 "\n", expected);
>>>        printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>>        printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>>> -    printf("mem: %" PRIu64 " (inline racy)\n", count_mem_inline_racy);
>>>        g_assert(expected > 0);
>>>        g_assert(per_vcpu == expected);
>>>        g_assert(inl_per_vcpu == expected);
>>> -    g_assert(count_mem_inline_racy <= expected);
>>>    }
>>>    static void plugin_exit(qemu_plugin_id_t id, void *udata)
>>> @@ -142,8 +133,6 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct 
>>> qemu_plugin_tb *tb)
>>>    {
>>>        qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>>>                                             QEMU_PLUGIN_CB_NO_REGS, 0);
>>> -    qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
>>> -                                             &count_tb_inline_racy, 1);
>>>        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>            tb, QEMU_PLUGIN_INLINE_ADD_U64,
>>>            count_tb_inline_per_vcpu, sizeof(uint64_t), 1);
>>> @@ -152,18 +141,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct 
>>> qemu_plugin_tb *tb)
>>>            struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
>>>            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>>>                                                   QEMU_PLUGIN_CB_NO_REGS, 0);
>>> -        qemu_plugin_register_vcpu_insn_exec_inline(
>>> -            insn, QEMU_PLUGIN_INLINE_ADD_U64,
>>> -            &count_insn_inline_racy, 1);
>>>            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>                insn, QEMU_PLUGIN_INLINE_ADD_U64,
>>>                count_insn_inline_per_vcpu, sizeof(uint64_t), 1);
>>>            qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
>>>                                             QEMU_PLUGIN_CB_NO_REGS,
>>>                                             QEMU_PLUGIN_MEM_RW, 0);
>>> -        qemu_plugin_register_vcpu_mem_inline(insn, QEMU_PLUGIN_MEM_RW,
>>> -                                             QEMU_PLUGIN_INLINE_ADD_U64,
>>> -                                             &count_mem_inline_racy, 1);
>>>            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>>>                insn, QEMU_PLUGIN_MEM_RW,
>>>                QEMU_PLUGIN_INLINE_ADD_U64,
>>



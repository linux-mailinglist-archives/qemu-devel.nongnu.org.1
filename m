Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C282BA29
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 04:52:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO8Zv-0007rx-Rc; Thu, 11 Jan 2024 22:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rO8Zu-0007re-97
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 22:51:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rO8Zs-0003qL-HC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 22:51:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e62979feeso10579915e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 19:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705031487; x=1705636287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ECfs4y5PfJWiaMVoXw3Bztg1jrKO3VWWvDt5NMwJyJQ=;
 b=K5zvHqR8Pv0LxVw8Jk6h0udZaKAk8nt74gpcCwEAfhk0GmtWVQSPuNQwGQe3KMQ7wV
 iu39oMbFSPbpmdfU8zeCbJHe1l+nlmhgziOwd/7Wymh3xCzxNhMHlAHl/dpCSTx5RDj5
 xk+gMGHl6RP6XTCtrYCZJuZwsnnUIK9DB4xk8YbY/Q+cV8Up1H+76aYdWwdb+mjkCoZr
 +UaIu25NusNznTee+i75OY4yHSvUo1VdpFXVaxJqkyfeF6yVhaPRBLDhpPJQZbguPA14
 AcfEkFap4oyYm/HyN7saHy5OzhVZJIvC4HEUWrZUPVo43nZe5YKy1dwczJuETJq6vbeX
 ZiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705031487; x=1705636287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ECfs4y5PfJWiaMVoXw3Bztg1jrKO3VWWvDt5NMwJyJQ=;
 b=SwSfSPrkeISYnWSIs+1acP+Esgsr8RhVJBwk93JhzEeQjbhoGUSXR4VSoqA+EiAHe1
 onBbl2o/lv3LX2YAZV/friHuObwiP5wAHrTdx6IeoYdngL69CGKOBjEtKjYSRrYd6pES
 ud/7kP59y4GVFJMIz+93C8NBusVmEbv/nYGDulZ/JZRpXUv/GPB925A7k0TUvwDbBM40
 keCULl2WfzEjT+gFnwPsex/lLTZg82jVxHOhwF4D4hog8dxliimb/vZ18UiYqOEcbdoB
 abfcYzOw4iScQ3yxR+OzMlocgPlhf0nfKtJaloU0SpzqbdQtphApx6VWRdrpm1XJVxXA
 2Jyg==
X-Gm-Message-State: AOJu0YwfcnBCUKXxsiszPdXMa050RyREq8EkTUNpP6EmA/x76bmZ19eY
 oQO9mzeTvH3Rt3OrTyubIu8iQKuO6IWmPw==
X-Google-Smtp-Source: AGHT+IGEtiW7+kbLjU1Lci6wFN3XvuFpLigVFmSudY1WngpoIQY+1KL7H+fiHm1nXvGHdOm6+OhVJQ==
X-Received: by 2002:a05:600c:3ca3:b0:40e:4daf:b748 with SMTP id
 bg35-20020a05600c3ca300b0040e4dafb748mr413721wmb.115.1705031486995; 
 Thu, 11 Jan 2024 19:51:26 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040e398f8cafsm4085876wmo.31.2024.01.11.19.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 19:51:26 -0800 (PST)
Message-ID: <b99b7e20-9802-42c9-bd34-2727cd508da5@linaro.org>
Date: Fri, 12 Jan 2024 07:51:22 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] tests/plugin/inline: migrate to new per_vcpu API
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-5-pierrick.bouvier@linaro.org>
 <09812aba-9595-410d-9b27-d33353f33b02@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <09812aba-9595-410d-9b27-d33353f33b02@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/12/24 02:10, Richard Henderson wrote:
> On 1/12/24 01:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    tests/plugin/inline.c | 17 -----------------
>>    1 file changed, 17 deletions(-)
> 
> Was this supposed to be together with patch 6?
> 

My goal was to have a version that still uses original API.
If you prefer this to be squashed, no problem to do it.

> r~
> 
>>
>> diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
>> index 6114ebca545..ae59f7af7a7 100644
>> --- a/tests/plugin/inline.c
>> +++ b/tests/plugin/inline.c
>> @@ -18,15 +18,12 @@
>>    static uint64_t count_tb;
>>    static uint64_t count_tb_per_vcpu[MAX_CPUS];
>>    static uint64_t count_tb_inline_per_vcpu[MAX_CPUS];
>> -static uint64_t count_tb_inline_racy;
>>    static uint64_t count_insn;
>>    static uint64_t count_insn_per_vcpu[MAX_CPUS];
>>    static uint64_t count_insn_inline_per_vcpu[MAX_CPUS];
>> -static uint64_t count_insn_inline_racy;
>>    static uint64_t count_mem;
>>    static uint64_t count_mem_per_vcpu[MAX_CPUS];
>>    static uint64_t count_mem_inline_per_vcpu[MAX_CPUS];
>> -static uint64_t count_mem_inline_racy;
>>    static GMutex tb_lock;
>>    static GMutex insn_lock;
>>    static GMutex mem_lock;
>> @@ -50,11 +47,9 @@ static void stats_insn(void)
>>        printf("insn: %" PRIu64 "\n", expected);
>>        printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>        printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>> -    printf("insn: %" PRIu64 " (inline racy)\n", count_insn_inline_racy);
>>        g_assert(expected > 0);
>>        g_assert(per_vcpu == expected);
>>        g_assert(inl_per_vcpu == expected);
>> -    g_assert(count_insn_inline_racy <= expected);
>>    }
>>    
>>    static void stats_tb(void)
>> @@ -65,11 +60,9 @@ static void stats_tb(void)
>>        printf("tb: %" PRIu64 "\n", expected);
>>        printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>        printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>> -    printf("tb: %" PRIu64 " (inline racy)\n", count_tb_inline_racy);
>>        g_assert(expected > 0);
>>        g_assert(per_vcpu == expected);
>>        g_assert(inl_per_vcpu == expected);
>> -    g_assert(count_tb_inline_racy <= expected);
>>    }
>>    
>>    static void stats_mem(void)
>> @@ -80,11 +73,9 @@ static void stats_mem(void)
>>        printf("mem: %" PRIu64 "\n", expected);
>>        printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>        printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>> -    printf("mem: %" PRIu64 " (inline racy)\n", count_mem_inline_racy);
>>        g_assert(expected > 0);
>>        g_assert(per_vcpu == expected);
>>        g_assert(inl_per_vcpu == expected);
>> -    g_assert(count_mem_inline_racy <= expected);
>>    }
>>    
>>    static void plugin_exit(qemu_plugin_id_t id, void *udata)
>> @@ -142,8 +133,6 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>    {
>>        qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>>                                             QEMU_PLUGIN_CB_NO_REGS, 0);
>> -    qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
>> -                                             &count_tb_inline_racy, 1);
>>        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>            tb, QEMU_PLUGIN_INLINE_ADD_U64,
>>            count_tb_inline_per_vcpu, sizeof(uint64_t), 1);
>> @@ -152,18 +141,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>            struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
>>            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>>                                                   QEMU_PLUGIN_CB_NO_REGS, 0);
>> -        qemu_plugin_register_vcpu_insn_exec_inline(
>> -            insn, QEMU_PLUGIN_INLINE_ADD_U64,
>> -            &count_insn_inline_racy, 1);
>>            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>                insn, QEMU_PLUGIN_INLINE_ADD_U64,
>>                count_insn_inline_per_vcpu, sizeof(uint64_t), 1);
>>            qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
>>                                             QEMU_PLUGIN_CB_NO_REGS,
>>                                             QEMU_PLUGIN_MEM_RW, 0);
>> -        qemu_plugin_register_vcpu_mem_inline(insn, QEMU_PLUGIN_MEM_RW,
>> -                                             QEMU_PLUGIN_INLINE_ADD_U64,
>> -                                             &count_mem_inline_racy, 1);
>>            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>>                insn, QEMU_PLUGIN_MEM_RW,
>>                QEMU_PLUGIN_INLINE_ADD_U64,
> 


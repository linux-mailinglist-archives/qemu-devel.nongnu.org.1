Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24382B6FD
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:11:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3GU-0006lz-PB; Thu, 11 Jan 2024 17:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3GT-0006lq-12
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:11:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3GQ-0007nl-Ti
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:11:04 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d4a2526a7eso35257265ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705011061; x=1705615861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fkP0cgyZXK7DoKQ2DbT6IcCGw6Zbwrk4O/khduQPhZ0=;
 b=lYecVC86DiOaIJw4FbTQJSl7sFrpa3YXtOBHTrm0PgJz4DZb2MkqTcdewL+MgA/zzF
 2zPIWR/g6j1QkTizK0RUGnVpbuXX4r+livWc+N/K1b8EySS75RS1lnXwMj/bzvJpELyd
 MSYhdgqBnXQLI2TbEcHiLZ0qoGX4fM3UZgXlGygBQOOq2PZjOSleba8ycXVFmiC/Skui
 CV8qKCrq9KpnSvW922xXRWVTzIgOkaSOpho39aw/Gv73qCErPAvRm2e+RyFWWYo0+3HH
 1DmeHnA6GoPwScr039PPNg3iK7Su81Irl0XLQIyhETcC9bWiOdm1JzbHLBwMNQK9Um9c
 rvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705011061; x=1705615861;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkP0cgyZXK7DoKQ2DbT6IcCGw6Zbwrk4O/khduQPhZ0=;
 b=qTYCS6qBFgI0wTh+dgFzAZYTIVJVPhy5ChKy8BVYu51vpD26w9mG1SXW1WHEyIBW1U
 kR8OkWcS38UdqMR1efo7P4iogeMCYNE0k5nW9wVUwt6hcWtjLl2lLSsbcfU+bfbIoqvR
 Db9IwuepotbeXeTTlSi+VEqRhDeyVoNiCD6Ltpdj1qPDvBuoA/4FS0xwYRrDRZK+f1xl
 JrEHPKgqzdis8Zv0tlO44/0D4VO1TE/TXTCyQinWURnNV3Y7FYuA/aU4J2DjMOoeUeYZ
 6y+iXnAKIT/iklcKGVvLb0GpZE6yNFCITran+H+naFmpsC+elp+/R81MMa5oeJo1l8Lb
 0DqA==
X-Gm-Message-State: AOJu0Yy7mB1AYHk/DxufW6kkFI6dIszSZ+Co6U9Y4MR/sqBeuv98Bflz
 EJqYI5NBGvP1972qNKoG5GdfS+nYkuWG3A==
X-Google-Smtp-Source: AGHT+IEff0dhzUSEH4f3z0y1moV6tBbQ1ecn+nrpzPTWCJ5asHQhGvILDDG5y59aJ4Q6U5J4fJ3L2Q==
X-Received: by 2002:a17:902:c385:b0:1d4:a6c5:ca51 with SMTP id
 g5-20020a170902c38500b001d4a6c5ca51mr467442plg.72.1705011061241; 
 Thu, 11 Jan 2024 14:11:01 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a170902dac300b001d49a08495esm1632482plx.118.2024.01.11.14.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 14:11:00 -0800 (PST)
Message-ID: <09812aba-9595-410d-9b27-d33353f33b02@linaro.org>
Date: Fri, 12 Jan 2024 09:10:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] tests/plugin/inline: migrate to new per_vcpu API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/inline.c | 17 -----------------
>   1 file changed, 17 deletions(-)

Was this supposed to be together with patch 6?

r~

> 
> diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
> index 6114ebca545..ae59f7af7a7 100644
> --- a/tests/plugin/inline.c
> +++ b/tests/plugin/inline.c
> @@ -18,15 +18,12 @@
>   static uint64_t count_tb;
>   static uint64_t count_tb_per_vcpu[MAX_CPUS];
>   static uint64_t count_tb_inline_per_vcpu[MAX_CPUS];
> -static uint64_t count_tb_inline_racy;
>   static uint64_t count_insn;
>   static uint64_t count_insn_per_vcpu[MAX_CPUS];
>   static uint64_t count_insn_inline_per_vcpu[MAX_CPUS];
> -static uint64_t count_insn_inline_racy;
>   static uint64_t count_mem;
>   static uint64_t count_mem_per_vcpu[MAX_CPUS];
>   static uint64_t count_mem_inline_per_vcpu[MAX_CPUS];
> -static uint64_t count_mem_inline_racy;
>   static GMutex tb_lock;
>   static GMutex insn_lock;
>   static GMutex mem_lock;
> @@ -50,11 +47,9 @@ static void stats_insn(void)
>       printf("insn: %" PRIu64 "\n", expected);
>       printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
>       printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
> -    printf("insn: %" PRIu64 " (inline racy)\n", count_insn_inline_racy);
>       g_assert(expected > 0);
>       g_assert(per_vcpu == expected);
>       g_assert(inl_per_vcpu == expected);
> -    g_assert(count_insn_inline_racy <= expected);
>   }
>   
>   static void stats_tb(void)
> @@ -65,11 +60,9 @@ static void stats_tb(void)
>       printf("tb: %" PRIu64 "\n", expected);
>       printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
>       printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
> -    printf("tb: %" PRIu64 " (inline racy)\n", count_tb_inline_racy);
>       g_assert(expected > 0);
>       g_assert(per_vcpu == expected);
>       g_assert(inl_per_vcpu == expected);
> -    g_assert(count_tb_inline_racy <= expected);
>   }
>   
>   static void stats_mem(void)
> @@ -80,11 +73,9 @@ static void stats_mem(void)
>       printf("mem: %" PRIu64 "\n", expected);
>       printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
>       printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
> -    printf("mem: %" PRIu64 " (inline racy)\n", count_mem_inline_racy);
>       g_assert(expected > 0);
>       g_assert(per_vcpu == expected);
>       g_assert(inl_per_vcpu == expected);
> -    g_assert(count_mem_inline_racy <= expected);
>   }
>   
>   static void plugin_exit(qemu_plugin_id_t id, void *udata)
> @@ -142,8 +133,6 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>   {
>       qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>                                            QEMU_PLUGIN_CB_NO_REGS, 0);
> -    qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> -                                             &count_tb_inline_racy, 1);
>       qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>           tb, QEMU_PLUGIN_INLINE_ADD_U64,
>           count_tb_inline_per_vcpu, sizeof(uint64_t), 1);
> @@ -152,18 +141,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
>           qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>                                                  QEMU_PLUGIN_CB_NO_REGS, 0);
> -        qemu_plugin_register_vcpu_insn_exec_inline(
> -            insn, QEMU_PLUGIN_INLINE_ADD_U64,
> -            &count_insn_inline_racy, 1);
>           qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>               insn, QEMU_PLUGIN_INLINE_ADD_U64,
>               count_insn_inline_per_vcpu, sizeof(uint64_t), 1);
>           qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
>                                            QEMU_PLUGIN_CB_NO_REGS,
>                                            QEMU_PLUGIN_MEM_RW, 0);
> -        qemu_plugin_register_vcpu_mem_inline(insn, QEMU_PLUGIN_MEM_RW,
> -                                             QEMU_PLUGIN_INLINE_ADD_U64,
> -                                             &count_mem_inline_racy, 1);
>           qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>               insn, QEMU_PLUGIN_MEM_RW,
>               QEMU_PLUGIN_INLINE_ADD_U64,



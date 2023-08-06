Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9A7715A3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSem8-0003t0-C4; Sun, 06 Aug 2023 10:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSem6-0003s1-37
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:30:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSem4-0000iM-H6
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:30:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so2486468b3a.0
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691332227; x=1691937027;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJXBywa9QqZqHdjZi81UDJjrXbV3eRENJBvklU2i59s=;
 b=eE6DeOn+GhJsTvE/5lbbixqoM6OCdPt3h9VII4PxalzObOo3+vusoXicIAA9kesb0M
 c+e0DhrFZXCxWDBzJljlo+O8VN4elbudhN93/gfp8pSprOoYrc8ZOhHXjv4SOyDq1OD1
 e0V3k49RbwFy4A4+OEpP+IpCGgavtTmPCaf3EyJvsuRdOgfOyN2+SCQG/p5QG+vXh1Zq
 0xZbIBwwgkxVmn7cCtdKQLUTuidv85yl/MPhb2eZwHxAHQD2jOs3RVULTKN5rd3l5mhr
 C8OgbTCIJvMIKLlF74cw9yNyQBKC3zUEj776MMjMVegQFT7BoSu7+WekkkYWDlvRcrYr
 NP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691332227; x=1691937027;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJXBywa9QqZqHdjZi81UDJjrXbV3eRENJBvklU2i59s=;
 b=CDipB0voJw2+hNdllt2byCekeFgcqPRo6MfDJz06YSwPYshawJ1gYG4/YGy2FJ09hI
 mSXT+rgz3Z6hH0zOhUZDfAt9JrMlQ4qhYuKvgBt5VOnprQcSQ4dTv8SE+xqCn9BR3eXz
 40qM7m5tUYXQ3Yx95OPzysRrLnoOovBzvePQ2ZBU8gdv/A+37km8qvir7UWwiXU8fVqA
 0ZhXZBwmaTjzkOtVaUqpN27Lq8COnoqiGUMH+Nvd8Pt8bpz29tw5ZK0+DyAumdungkEL
 oLBl83rAG2NSyoyVkA2MADLbjniftLq5iImTT+n6Xp6EKKQsuWPHpGw3cBeVHh5h+Xr4
 D5SQ==
X-Gm-Message-State: AOJu0YyaE6SWQYbuPi/yb19tNvl1mp/4Sp47OCYXryUByraO/h+jyaR2
 zXyNBwAQKUet5NO52wfLLbMb3A==
X-Google-Smtp-Source: AGHT+IH33brjlk0k1ID9KuJCcnf2xrTs+FsE1An1N+FUngArVLY3tpmJS7CMcaTpjxcNG/tSke8Zkg==
X-Received: by 2002:a05:6a20:5513:b0:140:b178:9b36 with SMTP id
 ko19-20020a056a20551300b00140b1789b36mr2280927pzb.48.1691332226770; 
 Sun, 06 Aug 2023 07:30:26 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e72:57bd:c5e4:990c?
 ([2602:47:d490:6901:e72:57bd:c5e4:990c])
 by smtp.gmail.com with ESMTPSA id
 e16-20020aa78c50000000b0067ab572c72fsm4507915pfd.84.2023.08.06.07.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 07:30:26 -0700 (PDT)
Message-ID: <dd180646-6c55-bfa6-0660-55eb5fa85917@linaro.org>
Date: Sun, 6 Aug 2023 07:30:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/23] target/riscv: Use MMU_INDEX() helper
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230806121732.91853-1-deller@gmx.de>
 <20230806121732.91853-11-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230806121732.91853-11-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/6/23 05:17, Helge Deller wrote:
> Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
> should be used.  Additionally, in a follow-up patch this helper allows
> then to optimize the tcg code generation.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/riscv/cpu.h        | 4 ++--
>   target/riscv/cpu_helper.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6ea22e0eea..6aba1df64a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -88,7 +88,7 @@ typedef enum {
>       EXT_STATUS_DIRTY,
>   } RISCVExtStatus;
> 
> -#define MMU_USER_IDX 3
> +#define MMU_USER_IDX MMU_INDEX(3)
> 
>   #define MAX_RISCV_PMPS (16)
> 
> @@ -446,7 +446,7 @@ void riscv_cpu_list(void);
>   void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
> 
>   #define cpu_list riscv_cpu_list
> -#define cpu_mmu_index riscv_cpu_mmu_index
> +#define cpu_mmu_index(e,i)      MMU_INDEX(riscv_cpu_mmu_index(e,i))
> 
>   #ifndef CONFIG_USER_ONLY
>   void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 9f611d89bb..a8e6950217 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -107,7 +107,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>   #else
>       flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
> 
> -    flags |= cpu_mmu_index(env, 0);
> +    flags |= riscv_cpu_mmu_index(env, 0);
>       fs = get_field(env->mstatus, MSTATUS_FS);
>       vs = get_field(env->mstatus, MSTATUS_VS);

This is the sort of non-obvious changes that I hoped to avoid by restricting all changes 
to accel/tcg/cputlb.c.


r~



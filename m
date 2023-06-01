Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE502718F5D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 02:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Voc-0003fk-6n; Wed, 31 May 2023 20:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4VoY-0003fF-K6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 20:05:14 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4VoU-0007SP-Ke
 for qemu-devel@nongnu.org; Wed, 31 May 2023 20:05:14 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-33d0b7114a9so898185ab.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685577908; x=1688169908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q0uZyOTK2FK208DxUyzY//sh2q7Qg8eSkYa9gR5EElA=;
 b=HgDiGQNyot4RoO82dIHyzvvadTcjzPWOkEv74mmKN00SxIDO5nrCMmmBLzDXXqz/AA
 H4GXBNGAB33BeULDaZhyp+xky07l7a+EPq64BugE/bcHahCeopeaci1mO7tNxpiaELpz
 6MATjLHyC1i/LqQ4L7FSVffckxk3omhp70ODjADVO+n+L41pEpUF13enGOcepNhCXRxF
 Qb9muCC1YT2uvTjzsaFKtw+F7XCQryOeOWvlUWzsm6wLYdIHscerbpOTfENR2ac6x0Y0
 VsuVxVyutiLQhV5ASdcAHVieezRbaJi/FrxlScT3L7eAzAA9WVYUj5KFw2zsVx+crezu
 nJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685577908; x=1688169908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0uZyOTK2FK208DxUyzY//sh2q7Qg8eSkYa9gR5EElA=;
 b=e0qlnbVybWxSXFxa3e2NBExEHpz93y6rsI8sX+1lorOOjmePHBoXbQctR7I3UwlyR0
 yzTot0VNYbW1u0WfyzLm0gSakXNwxPEuExYzsQJc8SuSdnmmzqFgint1E/egURgXDpzo
 xkC2o8YRTg5pJBImaRiC68vLKWzILimOiwcR9qCvi2XEWPUhwQUJmpZDwnxyvXcq8U6R
 oFazdNkzH3X8rjTdHCFZL0ur2rrqRfNZRZMztGRhmarg1WlgRWaVEzKH7fQ5OV/sr26k
 83r29PxVYvQrEyZiI7M5eCwnnXu7yNStEFAWtM7PTtMYS5Wc0ZKLBTWqmVWfdJHiS7b8
 /Jhw==
X-Gm-Message-State: AC+VfDzkckjmd4+3aCdGWINAMNe15aVZmZPUSSqWpbIxvnBzJz/3yxrj
 WUGkqgN94TYtKcM/lYNLCDjW5A==
X-Google-Smtp-Source: ACHHUZ7jxu8Uoscv69YrNik/U0ZZzaMx43x+BX1Yu7zERZpemfluvmnaD8iBm85W/SNbDFZjP1fVjg==
X-Received: by 2002:a92:d7c2:0:b0:33b:ed95:26df with SMTP id
 g2-20020a92d7c2000000b0033bed9526dfmr3588401ilq.32.1685577907862; 
 Wed, 31 May 2023 17:05:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a63cc0b000000b0053f2037d639sm1861467pgf.81.2023.05.31.17.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 17:05:07 -0700 (PDT)
Message-ID: <fe705139-31e9-974b-4e45-2f0c653359da@linaro.org>
Date: Wed, 31 May 2023 17:05:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 03/10] accel: collecting TB execution count
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-4-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-4-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/30/23 01:35, Fei Wu wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
> enabled, then we instrument the start code of this TB
> to atomically count the number of times it is executed.
> We count both the number of "normal" executions and atomic
> executions of a TB.
> 
> The execution count of the TB is stored in its respective
> TBS.
> 
> All TBStatistics are created by default with the flags from
> default_tbstats_flag.
> 
> [Richard Henderson created the inline gen_tb_exec_count]
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
> [AJB: Fix author]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>   accel/tcg/cpu-exec.c          |  6 ++++++
>   accel/tcg/tb-stats.c          |  6 ++++++
>   accel/tcg/tcg-runtime.c       |  1 +
>   accel/tcg/translate-all.c     |  7 +++++--
>   accel/tcg/translator.c        | 25 +++++++++++++++++++++++++
>   include/exec/gen-icount.h     |  1 +
>   include/exec/tb-stats-flags.h |  5 +++++
>   include/exec/tb-stats.h       | 13 +++++++++++++
>   8 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 0e741960da..c0d8f26237 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -25,6 +25,7 @@
>   #include "trace.h"
>   #include "disas/disas.h"
>   #include "exec/exec-all.h"
> +#include "exec/tb-stats.h"
>   #include "tcg/tcg.h"
>   #include "qemu/atomic.h"
>   #include "qemu/rcu.h"
> @@ -562,7 +563,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
>               mmap_unlock();
>           }
>   
> +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +            tb->tb_stats->executions.atomic++;
> +        }
> +
>           cpu_exec_enter(cpu);
> +
>           /* execute the generated code */
>           trace_exec_tb(tb, pc);
>           cpu_tb_exec(cpu, tb, &tb_exit);
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index f988bd8a31..143a52ef5c 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -22,6 +22,7 @@ enum TBStatsStatus {
>   };
>   
>   static enum TBStatsStatus tcg_collect_tb_stats;
> +static uint32_t default_tbstats_flag;
>   
>   void init_tb_stats_htable(void)
>   {
> @@ -56,3 +57,8 @@ bool tb_stats_collection_paused(void)
>   {
>       return tcg_collect_tb_stats == TB_STATS_PAUSED;
>   }
> +
> +uint32_t get_default_tbstats_flag(void)
> +{
> +    return default_tbstats_flag;
> +}

What is the purpose of this function, instead of a global variable?
What is the meaning of 'default' in its name?

> @@ -295,6 +295,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
>       new_stats->pc = pc;
>       new_stats->cs_base = cs_base;
>       new_stats->flags = flags;
> +    new_stats->stats_enabled = get_default_tbstats_flag();

Is this merely to record how we have generated a given TB?
What is the purpose of this flag over the global variable?

> diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
> index 87ee3d902e..fa71eb6f0c 100644
> --- a/include/exec/tb-stats-flags.h
> +++ b/include/exec/tb-stats-flags.h
> @@ -11,6 +11,9 @@
>   #ifndef TB_STATS_FLAGS
>   #define TB_STATS_FLAGS
>   
> +#define TB_NOTHING    (1 << 0)
> +#define TB_EXEC_STATS (1 << 1)

Why is NOTHING a non-zero flag?

> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -31,6 +31,9 @@
>   #include "exec/tb-stats-flags.h"
>   #include "tcg/tcg.h"
>   
> +#define tb_stats_enabled(tb, JIT_STATS) \
> +    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))

Inline function, though again, why stats_enabled vs global variable?


r~


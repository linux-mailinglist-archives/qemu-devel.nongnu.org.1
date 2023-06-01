Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8E718FDD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:10:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Wnu-0000eI-8x; Wed, 31 May 2023 21:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Wns-0000e3-Bi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:08:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Wnq-0002fQ-CX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:08:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso296660b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685581712; x=1688173712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CRs/MhzLS6bPXfELllRvqOv9tIMMjfIQ63wGflIiwmY=;
 b=WmRHFXqBG0adCgE10bHqxcvsH+9yF7p/jJgt5tSQSioS413NWalXOppctdD+IO9S39
 d0TEPPVhUp0YlXljeNQuqrH5SukQE9YAU31j7X1O9W+z5Bagw5z0Hsx7p0S5zvhFXlWy
 EyRING4uSFYRji9iVwM+npdNmfsxFz+FObNJrsgDhgXUYu2tQX8OSl002Ccki9aKWvca
 jJ2BANLIMGDnppEKUqTP1IMuhsNxCxFO+UQKlBWTneactfmQ5b+qccGCkXwF/Z4I5MA1
 +tgcCZoS3o3IIcUuXit1EW2iWJBLKTJqJA78SL/f8LePS85l1M/NE7a1Y2Toz3AUjlDa
 dSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685581712; x=1688173712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRs/MhzLS6bPXfELllRvqOv9tIMMjfIQ63wGflIiwmY=;
 b=WVt8fPxXqQn4Wk7BxrU4HabaUJ76sw2/RhLFtvrpysEscIDoj+niGnQY4QYFjRI0bC
 /XR79sGrGfr9cnVN8xd5b0EGCg6sjbKPwxlg3QCFYbHv7CHiQGp9OUCe0wD3aUaZYkcr
 q8XK2FXZR1nOONNS1D3/hyfvi1o7xjy/MULVtbZKGjU+BmTWYq8vXUweUompPOQOQktS
 rnbQAb6Y/bMTiJjuseupZzrCT4xS9OGC7VnxC6ROvJuS66PEERs0wbrdlUh/aPqghNqe
 7OXaiDI0PNErN9N7ixSEl7jFMnX6ByE8ID6ZpNm2hgqZ54BAvr7IcqcqSFkcCp4ngYZU
 q6Fw==
X-Gm-Message-State: AC+VfDwL6T5TwfEzfrwAh00rs352fF065LdsDGRGuXyTEyIx4oTBQI+k
 DYZRCtrlKVWGJ2gQ0n0a7DQdFg==
X-Google-Smtp-Source: ACHHUZ6eCMC4yB8g+hR/VuxJQJ4mj6CYDiob4MqAS+hUy+mV3VUoJlMwE5IanTRw5HUJNt+IFExnrA==
X-Received: by 2002:a05:6a00:1f96:b0:64d:2a87:2596 with SMTP id
 bg22-20020a056a001f9600b0064d2a872596mr203891pfb.10.1685581711972; 
 Wed, 31 May 2023 18:08:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 e6-20020aa78246000000b0064f76992905sm3831745pfn.202.2023.05.31.18.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 18:08:31 -0700 (PDT)
Message-ID: <3cc014aa-96ef-9a5a-f567-2e55ce37b469@linaro.org>
Date: Wed, 31 May 2023 18:08:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-5-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-5-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
> +static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
> +{
> +    struct jit_profile_info *jpi = userp;
> +    TBStatistics *tbs = p;
> +
> +    jpi->translations += tbs->translations.total;
> +    jpi->ops += tbs->code.num_tcg_ops;
> +    if (stat_per_translation(tbs, code.num_tcg_ops) > jpi->ops_max) {
> +        jpi->ops_max = stat_per_translation(tbs, code.num_tcg_ops);
> +    }
> +    jpi->del_ops += tbs->code.deleted_ops;
> +    jpi->temps += tbs->code.temps;
> +    if (stat_per_translation(tbs, code.temps) > jpi->temps_max) {
> +        jpi->temps_max = stat_per_translation(tbs, code.temps);
> +    }
> +    jpi->host += tbs->code.out_len;
> +    jpi->guest += tbs->code.in_len;
> +    jpi->search_data += tbs->code.search_out_len;
> +
> +    jpi->interm_time += stat_per_translation(tbs, gen_times.ir);
> +    jpi->opt_time += stat_per_translation(tbs, gen_times.ir_opt);
> +    jpi->la_time += stat_per_translation(tbs, gen_times.la);
> +    jpi->code_time += stat_per_translation(tbs, gen_times.code);
> +
> +    /*
> +     * The restore time covers how long we have spent restoring state
> +     * from a given TB (e.g. recovering from a fault). It is therefor
> +     * not related to the number of translations we have done.
> +     */
> +    jpi->restore_time += tbs->tb_restore_time;
> +    jpi->restore_count += tbs->tb_restore_count;
> +}

Why do sums of averages (stats_per_translation) instead of accumulating the complete total 
and dividing by jpi->translations?

> +void dump_jit_exec_time_info(uint64_t dev_time, GString *buf)
> +{
> +    static uint64_t last_cpu_exec_time;
> +    uint64_t cpu_exec_time;
> +    uint64_t delta;
> +
> +    cpu_exec_time = tcg_cpu_exec_time();
> +    delta = cpu_exec_time - last_cpu_exec_time;
> +
> +    g_string_append_printf(buf, "async time  %" PRId64 " (%0.3f)\n",
> +                           dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
> +    g_string_append_printf(buf, "qemu time   %" PRId64 " (%0.3f)\n",
> +                           delta, delta / (double)NANOSECONDS_PER_SECOND);
> +    last_cpu_exec_time = cpu_exec_time;
> +}
> +
> +/* dump JIT statisticis using TCGProfile and TBStats */

"statistics"

> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 3973591508..749ad182f2 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -70,10 +70,17 @@ void tcg_cpus_destroy(CPUState *cpu)
>   int tcg_cpus_exec(CPUState *cpu)
>   {
>       int ret;
> +    uint64_t ti;
> +
>       assert(tcg_enabled());
> +    ti = profile_getclock();
> +
>       cpu_exec_start(cpu);
>       ret = cpu_exec(cpu);
>       cpu_exec_end(cpu);
> +
> +    qatomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);

You can't qatomic_add a 64-bit value on a 32-bit host.
Nor is tcg_ctx a good place to put this.

If you want to accumulate per-cpu data, put it on the cpu where there's no chance of 
racing with anyone.

Finally, I suspect that this isn't even where you want to accumulate time for execution as 
separate from translation.  You'd to that in cpu_exec_enter/cpu_exec_exit.

> @@ -296,6 +315,8 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
>       new_stats->cs_base = cs_base;
>       new_stats->flags = flags;
>       new_stats->stats_enabled = get_default_tbstats_flag();
> +    new_stats->tbs = g_ptr_array_sized_new(4);

Why default to 4?  Is that just a guess, or are we really recomputing tbs that frequently? 
  Is there a good reason not to use g_ptr_array_new()?

> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 80ffbfb455..a60a92091b 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -19,7 +19,7 @@
>   #include "exec/plugin-gen.h"
>   #include "exec/replay-core.h"
>   
> -static void gen_tb_exec_count(TranslationBlock *tb)
> +static inline void gen_tb_exec_count(TranslationBlock *tb)

Why?

>   {
>       if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>           TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
> @@ -147,6 +147,11 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       tb->size = db->pc_next - db->pc_first;
>       tb->icount = db->num_insns;
>   
> +    /* Save number of guest instructions for TB_JIT_STATS */
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        tb->tb_stats->code.num_guest_inst += db->num_insns;
> +    }

Why do this here, as opposed to the block in tb_gen_code?

> +#define stat_per_translation(stat, name) \
> +    (stat->translations.total ? stat->name / stat->translations.total : 0)

Not a fan of this macro, and as per above, the reason for doing the division here is 
questionable.

> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 9a91cb1248..ad0da18a5f 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -989,4 +989,10 @@ static inline int64_t cpu_get_host_ticks(void)
>   }
>   #endif
>   
> +static inline int64_t profile_getclock(void)
> +{
> +    return get_clock();
> +}

Why?  You use get_clock directly most places.

> +/* Timestamps during translation  */
> +typedef struct TCGTime {
> +    uint64_t start;
> +    uint64_t ir_done;
> +    uint64_t opt_done;
> +    uint64_t la_done;
> +    uint64_t code_done;
> +} TCGTime;

int64_t would match the result of get_clock().

> +
> +/*
> + * The TCGProfile structure holds data for the lifetime of the translator.
> + */
> +typedef struct TCGProfile {
> +    /* exec time of this vcpu */
> +    int64_t cpu_exec_time;

TCGContext is not per-cpu, and therefore TCGProfile does not correspond either.

> @@ -608,6 +630,7 @@ struct TCGContext {
>   
>       /* Exit to translator on overflow. */
>       sigjmp_buf jmp_trans;
> +    TranslationBlock *current_tb;

TCGContext.gen_tb already exists.

> -int64_t tcg_cpu_exec_time(void);
> +uint64_t tcg_cpu_exec_time(void);

Why?  (Also, probably wants removing, per above.)

> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -728,9 +728,18 @@ static bool main_loop_should_exit(int *status)
>   int qemu_main_loop(void)
>   {
>       int status = EXIT_SUCCESS;
> +#ifdef CONFIG_TCG
> +    uint64_t ti;
> +#endif
>   
>       while (!main_loop_should_exit(&status)) {
> +#ifdef CONFIG_TCG
> +        ti = profile_getclock();
> +#endif
>           main_loop_wait(false);
> +#ifdef CONFIG_TCG
> +        dev_time += profile_getclock() - ti;
> +#endif
>       }

What is this intending to collect?  Because I don't think it measures anything.  Certainly 
nothing related to TCG, CPUs or even devices.

> +    /* ? won't this end up op_opt - op = del_op_count ? */
> +    if (tb_stats_enabled(s->gen_tb, TB_JIT_STATS)) {
> +        s->gen_tb->tb_stats->code.deleted_ops++;
> +    }

Not quite.  We can emit new ops as well.  But how useful this is on its own is debatable.

> +/* avoid copy/paste errors */
> +#define PROF_ADD(to, from, field)                       \
> +    do {                                                \
> +        (to)->field += qatomic_read(&((from)->field));  \
> +    } while (0)

It is only used twice.
In addition, you can't use qatomic_read of a 64-bit variable on a 32-bit host.
You really really need to build e.g. i386.

> @@ -5879,6 +5923,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>           }
>       }
>   
> +
>   #ifdef CONFIG_DEBUG_TCG

Stray.


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C530718FF3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:24:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4X2L-0003ks-4o; Wed, 31 May 2023 21:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4X2K-0003kk-1j
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:23:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4X2I-000501-3i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:23:31 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2562cc85d3dso130640a91.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685582608; x=1688174608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IsaMCJxShzN1pZDBdTm+Oy8ygITeqmipqPvGQ9jQo4s=;
 b=DzxegsnpztyeO3peYJWQOMeUXEvjUWDjtHrG14fklgj2eWa9YKlKWdj0ZM8qVrIrBR
 LaPuoXMC2Fvltb/8hMGmH37fpnlK+T6jBkYwKWn+bDWaX/Gv7Do4r+rle1qzJb8NgzO2
 ZP9tZ83cPZ9WUIgNfOk365o8gw2YUwcFTuUpfRuYdyE5yKQInYGf6wnkVXldDJBKQrY6
 0p9lEQ1Vv3PxcaxUeJVQumE+yeHDk4BkfMUtXPnZ+oUws+6tcN0avv0E2uHWQJ9D4C0r
 KbKzkvb5VjDt0Rj+iXoRlZPu05TBa6OxhWiIfzNd9vEIsTKn3tsisVBydibclgW2/Xmd
 CM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685582608; x=1688174608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IsaMCJxShzN1pZDBdTm+Oy8ygITeqmipqPvGQ9jQo4s=;
 b=NcK6b6lOTnAvDu4FQ3/Aggn18KWDL3SuUuWKpmPKBJj8wEueVoZxfsTZnt7fnkTjOp
 cJE3AtRD7SiNloiJ6H2stNT09URe5P4TabU0gz8B6p81i7F3Lu8WCwuRVe4u3v2HUNAf
 8xiYYwmo0208wA21r6ltcaPs1Wubj4GEfErl5Qmx8RbuAlNUp0MisN4iNP6sccIhlEGw
 sn+ZQxbfcDuwH7Wh/aUmS2WDTx0x++Rm+tSjJ9hz5+viM4HbYiB+EXjwe3KVyZX9/nCu
 EA+tvdZUHJvYqQlSjW/K7ao3vZoNaBOefqj4wVWrZM1I2rpOdJEe+33GRCPqKdL1yPTD
 uCgA==
X-Gm-Message-State: AC+VfDzeZWW2gDpqIn39YbhfR+gmCNDD2mkzdHbPvA4YqcOvaXLxpk/9
 rf+AxmsrRNPCQlysAnpYQBUrcw==
X-Google-Smtp-Source: ACHHUZ7TPcZgTrcSsO56BdtJPdhKrevG4NgEvUD/1XbKSFSoCskzSCw7wtpQ3cA7+1g+ubPkEDpvpw==
X-Received: by 2002:a17:90b:17ca:b0:256:69ac:eb1 with SMTP id
 me10-20020a17090b17ca00b0025669ac0eb1mr7760282pjb.1.1685582608390; 
 Wed, 31 May 2023 18:23:28 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 em20-20020a17090b015400b002535a0f2028sm136596pjb.51.2023.05.31.18.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 18:23:27 -0700 (PDT)
Message-ID: <f37aae7f-7b90-af71-a188-bac4e7bf851f@linaro.org>
Date: Wed, 31 May 2023 18:23:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 06/10] monitor: adding tb_stats hmp command
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-7-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-7-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
> Adding tb_stats [start|pause|stop|filter] command to hmp.
> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
> 
> tb_stats filter allow to only collect statistics for the TB
> in the last_search list.
> 
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
> [AJB: fix authorship]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---


I still don't see what pause does.

> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 68ac7d3f73..805e1fc74d 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -16,18 +16,20 @@
>   #include "qemu/timer.h"
>   
>   #include "exec/tb-stats.h"
> +#include "exec/tb-flush.h"
>   #include "tb-context.h"
>   
>   /* TBStatistic collection controls */
>   enum TBStatsStatus {
>       TB_STATS_DISABLED = 0,
>       TB_STATS_RUNNING,
> -    TB_STATS_PAUSED,
> -    TB_STATS_STOPPED
> +    TB_STATS_PAUSED
>   };

Why?

>   
>   static enum TBStatsStatus tcg_collect_tb_stats;
>   static uint32_t default_tbstats_flag;
> +/* only accessed in safe work */
> +static GList *last_search;
>   
>   uint64_t dev_time;
>   
> @@ -170,6 +172,101 @@ void dump_jit_profile_info(TCGProfile *s, GString *buf)
>       g_free(jpi);
>   }
>   
> +static void free_tbstats(void *p, uint32_t hash, void *userp)
> +{
> +    g_free(p);
> +}
> +
> +static void clean_tbstats(void)
> +{
> +    /* remove all tb_stats */
> +    qht_iter(&tb_ctx.tb_stats, free_tbstats, NULL);
> +    qht_destroy(&tb_ctx.tb_stats);
> +}
> +
> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
> +{
> +    struct TbstatsCommand *cmdinfo = icmd.host_ptr;
> +    int cmd = cmdinfo->cmd;
> +    uint32_t level = cmdinfo->level;
> +
> +    switch (cmd) {
> +    case START:
> +        if (tb_stats_collection_enabled()) {
> +            qemu_printf("TB information already being recorded");
> +            return;
> +        } else if (tb_stats_collection_paused()) {
> +            set_tbstats_flags(level);
> +        } else {
> +            qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE,
> +                     QHT_MODE_AUTO_RESIZE);
> +        }
> +
> +        set_default_tbstats_flag(level);
> +        enable_collect_tb_stats();
> +        tb_flush(cpu);
> +        break;
> +    case PAUSE:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +
> +        /*
> +         * Continue to create TBStatistic structures but stop collecting
> +         * statistics
> +         */
> +        pause_collect_tb_stats();
> +        set_default_tbstats_flag(TB_NOTHING);
> +        set_tbstats_flags(TB_PAUSED);
> +        tb_flush(cpu);
> +        break;
> +    case STOP:
> +        if (tb_stats_collection_disabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +
> +        /* Dissalloc all TBStatistics structures and stop creating new ones */
> +        disable_collect_tb_stats();
> +        clean_tbstats();
> +        tb_flush(cpu);
> +        break;
> +    case FILTER:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +        if (!last_search) {
> +            qemu_printf(
> +                    "no search on record! execute info tbs before filtering!");
> +            return;
> +        }
> +
> +        set_default_tbstats_flag(TB_NOTHING);
> +
> +        /*
> +         * Set all tbstats as paused, then return only the ones from last_search
> +         */
> +        pause_collect_tb_stats();
> +        set_tbstats_flags(TB_PAUSED);
> +
> +        for (GList *iter = last_search; iter; iter = g_list_next(iter)) {
> +            TBStatistics *tbs = iter->data;
> +            tbs->stats_enabled = level;
> +        }
> +
> +        tb_flush(cpu);
> +
> +        break;
> +    default: /* INVALID */
> +        g_assert_not_reached();
> +        break;
> +    }
> +
> +    g_free(cmdinfo);
> +}

Why isn't all of this in monitor.c?
It's not used or usable from user-only mode.

> +void set_tbstats_flags(uint32_t flag)
> +{
> +    /* iterate over tbstats setting their flag as TB_NOTHING */
> +    qht_iter(&tb_ctx.tb_stats, reset_tbstats_flag, &flag);
> +}

Again, I question why a global variable is not more appropriate.


r~


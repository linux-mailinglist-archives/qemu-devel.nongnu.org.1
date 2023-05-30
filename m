Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42B715467
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 06:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3qdt-0006wf-VA; Tue, 30 May 2023 00:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3qds-0006wP-81
 for qemu-devel@nongnu.org; Tue, 30 May 2023 00:07:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3qdq-0007L4-NB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 00:07:27 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-256712d65ceso1183623a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685419645; x=1688011645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WKYb9meDWuptqTXlvfg1nnIdJzekWzdO5Q9XPnGu+Ak=;
 b=qN/XZPQ/ZaF4qVSDj8nSPm313MPdcfCu84z01y6KnvJRnZ3LBjz+LCjP9XucW4+loP
 X9Q8e9Avtteq2Q67C0v2yH35hx9tDDHGd855uYcpewQBOFN33unL30OpTCurs4StUUQL
 9IBUhoyCQxFjZjlU470DS8Ld1/zum+O2biFKsO4frAXuC/S+wWKvE2UKXFXL5LAgQlK7
 v+4heXkXnLFM/fCjmPl9p0gW4vDcL3EfzyLBReDiMsczGzAe7TbgTWx0lQov9KvoPTzV
 Fg1s8RXIciu4GJP03tUWd7fuEOf6s4/fwCDDRy8ixVD0z+5qmYKBwCknCHWtt4p6FT/f
 y6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685419645; x=1688011645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WKYb9meDWuptqTXlvfg1nnIdJzekWzdO5Q9XPnGu+Ak=;
 b=bmSD1Scl6A3nGU0lptk9WpWqJDEoJUUBzutTmCddzdo+1noSOw76HwjOJCBb2A4P/S
 I9YgY7ZzEYWntSERO829AnbnbEeTEJ1uijJwiWNImruxaIvOkr3Wiole6/C9C6waB65S
 8qeB8lfiBiiXjwh+kPtdscaiGv7Aam7juj8blk8QFGR4qZ+7K15mnWrz56wblSPZgNly
 IvlEJwn9FesmjbZg9JkeNuMzfKLXtYgs8nOwYUr0HGVCMeOvn8bCb8UT7ScOIGB9UoJ7
 Q9fmKPmSkk6Ia6aqD6zzWVRM2ayLQa7t2ZaQPr3mExXG6NxG8W+QLsXbsVVT2AtFLiED
 asPw==
X-Gm-Message-State: AC+VfDwx466ckEWKSFHjj4q1YasThu0JLY8VA2nOkZssjfaKfiUIt9/S
 LoGY2fgmbCXRmBbbSelSE6ZCTg==
X-Google-Smtp-Source: ACHHUZ678ypVnP2GEIkhNKfBZzcpJmMuMHIRa863OSA+HaeNkmq8Unxl0vLJSKsSZOap2b4RNCRSjA==
X-Received: by 2002:a17:902:a98c:b0:1ae:4ee3:e3e6 with SMTP id
 bh12-20020a170902a98c00b001ae4ee3e3e6mr1138355plb.32.1685419645002; 
 Mon, 29 May 2023 21:07:25 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9923:e5b8:e7d9:7a28?
 ([2602:ae:1598:4c01:9923:e5b8:e7d9:7a28])
 by smtp.gmail.com with ESMTPSA id
 jg11-20020a17090326cb00b001a9b29b6759sm7289150plb.183.2023.05.29.21.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 21:07:24 -0700 (PDT)
Message-ID: <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
Date: Mon, 29 May 2023 21:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230529114947.2123652-5-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/29/23 04:49, Fei Wu wrote:
> +/*
> + * The TCGProfile structure holds data for analysing the quality of
> + * the code generation. The data is split between stuff that is valid
> + * for the lifetime of a single translation and things that are valid
> + * for the lifetime of the translator. As the former is reset for each
> + * new translation so it should be copied elsewhere if you want to
> + * keep it.
> + *
> + * The structure is safe to access within the context of translation
> + * but accessing the data from elsewhere should be done with safe
> + * work.
> + */
> +typedef struct TCGProfile {
> +
> +    struct {
> +        int nb_guest_insns;
> +        int nb_spills;
> +        int nb_ops_pre_opt;
> +
> +        int del_op_count;
> +        int temp_count;
> +    } translation;
> +
> +    int64_t cpu_exec_time;
> +    int64_t op_count; /* total insn count */
> +    int64_t code_in_len;
> +    int64_t code_out_len;
> +    int64_t search_out_len;
> +
> +    /* Timestamps during translation  */
> +    uint64_t gen_start_time;
> +    uint64_t gen_ir_done_time;
> +    uint64_t gen_opt_done_time;
> +    uint64_t gen_la_done_time;
> +    uint64_t gen_code_done_time;
> +
> +    /* Lifetime count of TCGOps per TCGContext */
> +    uint64_t table_op_count[NB_OPS];
> +} TCGProfile;
> +

Why have you added this back?

The whole point of removing CONFIG_PROFILE to begin was to have all new code.  Not to 
remove it then reintroduce it unchanged.

In tcg_gen_code, you have access to the TranslationBlock as s->gen_tb.  There is zero 
point to accumulating into TCGProfile, when you could be accumulating into TCGStatistics 
directly.


r~


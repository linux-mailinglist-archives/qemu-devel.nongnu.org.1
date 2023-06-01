Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA871900E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4X9h-0005z4-08; Wed, 31 May 2023 21:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4X9X-0005uc-Ee
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:31:00 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4X9V-0006Ic-V9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:30:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-256e1d87a46so56907a91.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 18:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685583054; x=1688175054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gh8cLvB4laNADLDptzEGhIj8L2pydxqSli4zSJPvbDI=;
 b=SpkRKpJadrj6t9CEf0hy6Z9mnYl8qXkHfNMdbxgvox8X1+bJx2Y/w+WavqcWkCR8sR
 BdUduJRVFwqVIWHRQtu+dBDQAlcyoTv5mM1XQE4EsCJixTFmHI9yt8rFugtS3xnY4n2k
 1f+NTbMMDckq/npqonRUWQ0fXT6p9XmX4g1tyuF7K8bzLKfy0Pkw9/w6vFB5DxpRPYPb
 A9DmL1pRR1VUrO3JyxfayO9WJ+YBm6j9QQ3bKpf0xfrtv7YTQKBT4c7/fqHdGaqLJTy3
 om5Q1HUvlwHQ/I0FuFKbPFqQVee+S0frqsxvWtY4Jk2mzrAkur7gCenK02x6Cxv/kSCZ
 kJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685583054; x=1688175054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gh8cLvB4laNADLDptzEGhIj8L2pydxqSli4zSJPvbDI=;
 b=apxjh7rr6ulVMx3WQKGm83KRLn0nxDbg9AkHBt2G1yIbMnj7K7ydqe4zaAsG0NPV28
 Iht/qqhT5ozNCfpV06rRLO5Tq2qQM2PMj5jfv34MXNUoVwQOla9NuU3qEqVlejcNbNEP
 CMTu89hcIPF2kb99azgFW3KXQ6LMm510chvSdWGu+mrHP8NTNqdTHddg1FDEtQO0AMl4
 AJyWBmBWC+NprTR/vbY4Q78MVICZ/Blstz2ZggTvJ93gIKxasupm2Z0E0cifFvwbEFfT
 BL6Kys7BlSylG5CHCoIOzm5YIG30jbYQi/HZ0GM//pik+3mrI7VqIsu0nJt0tP5toYUi
 WNzw==
X-Gm-Message-State: AC+VfDzkKNzzCgVzJU/1ghxIuLsMJZuVxly6n9HragoBX0dURosjDy1z
 Qu3zFBBn9gTIt9PlMd4L97N92eVFYWHkjVwx6Gw=
X-Google-Smtp-Source: ACHHUZ7Y/6ZBBfAAbFMSxor1rOuRLp7H8EyFJCFIW9Z6xhzdSidUZAKVkjuChfa4xB2Htd0/sKeVVA==
X-Received: by 2002:a17:903:1d2:b0:1af:b7cd:5961 with SMTP id
 e18-20020a17090301d200b001afb7cd5961mr5718572plh.1.1685583054181; 
 Wed, 31 May 2023 18:30:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a170902758d00b001b02713a301sm2030875pll.181.2023.05.31.18.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 18:30:53 -0700 (PDT)
Message-ID: <cd066ad3-d6b1-4c23-e0b5-42b45d222c8b@linaro.org>
Date: Wed, 31 May 2023 18:30:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 07/10] tb-stats: reset the tracked TBs on a tb_flush
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-8-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-8-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 805e1fc74d..139f049ffc 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -267,6 +267,25 @@ void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
>       g_free(cmdinfo);
>   }
>   
> +/*
> + * We have to reset the tbs array on a tb_flush as those
> + * TranslationBlocks no longer exist and we no loner know if the
> + * current mapping is still valid.
> + */

The "and we no longer..." part is irrelevant: that's what phys_pc checks.
But the TranslationBlocks no longer exist, so that is sufficient.


r~


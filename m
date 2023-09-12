Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1A79D8DB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8Ly-0006YT-2r; Tue, 12 Sep 2023 14:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8La-0006MC-Vy
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:42:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8LX-0002qS-H7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:42:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso41237415ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694544166; x=1695148966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8o0NZWOLnNKN5dJ2mSwfRJOYZJv8zacKJ/K/79RCPM=;
 b=deN4KaCCGniKPntuRKuAlzfQyUamTrebMhHgQ1qA8y8lACCS8cgjirMuvtnSmoUYrf
 9PwcKkswyUtGw7NyHClh8oX5BPRzBPNSXtBf4sJOLkVJE5hOPGmodTkqtRMWywblSCzS
 d5HhbKLk4mFM+BWGZTABd+c0JNYlGeq72+pyLagMAAfuo5/+WgfFxRmYw+f0SI3BKVYa
 A77g9+75GFfaANMIbikuEknwHt6pzwotXfFEEWlgMnALG4F+1nx1eG3OmD8BAOtkqj/z
 T9ABDG7qt2XP/KWHF47yitQYubHZ1Ba50CeIqhA1CgW0Abo8bMjk2pXq0ICq+/UOTYpw
 kf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694544166; x=1695148966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8o0NZWOLnNKN5dJ2mSwfRJOYZJv8zacKJ/K/79RCPM=;
 b=b2+dts1V8mYP+2QTEakWz/bMeHIkO8gSw3MXKID1oiHnEJmSH4J3RCByJ8B8MyymrL
 +ncyIlAshkLHwZfHwO4Ru2PBCB2ZEHRX+KqnGHIZ1qLDIkODzt/HfYvg8MglFRBcJgn2
 AUpdeWpz36Tb1roVCzDRwjCeZ/ATfF2VejmCiatEmOldd5B3ASaGgCrohSk40S2rjuHJ
 6+BN2W12+GfLnCmaVanDn9lEvUznjWiWzy8pT9pE9s3OYYGmZCceqCCHi87QfV8Al+KC
 mHT/mjZAqWLnqaW/30juXxTRTS8fS6FKRQ5UfT5ePquYCXho5gHYK5lEWfwI79gYimAy
 llkQ==
X-Gm-Message-State: AOJu0YyVL2yu+P7m3SSOysBDIkcagnqBpQMbUljsxKOsBBaSrL8/tnqp
 y5pSVfVRU6BWgA/n5cCUw6nxZI7YsDgS0W1Wubk=
X-Google-Smtp-Source: AGHT+IHle09d0z2KgoyBCKNeT3JTeU/BP7ArdxFFe83YPbdeOtO3s2V7TyicZWATl4FRzVSJ95xcng==
X-Received: by 2002:a17:902:b494:b0:1c0:9ae1:6f8d with SMTP id
 y20-20020a170902b49400b001c09ae16f8dmr556985plr.32.1694544165775; 
 Tue, 12 Sep 2023 11:42:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a170902788900b001b89466a5f4sm8782849pll.105.2023.09.12.11.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 11:42:45 -0700 (PDT)
Message-ID: <f5bb1f4f-ccab-5245-8f99-2daefd6aecf0@linaro.org>
Date: Tue, 12 Sep 2023 11:42:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 03/11] accel/tcg: Modify tlb_*() to use CPUState
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20230912153428.17816-1-anjo@rev.ng>
 <20230912153428.17816-4-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912153428.17816-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/12/23 08:34, Anton Johansson wrote:
> Changes tlb_*() functions to take CPUState instead of CPUArchState, as
> they don't require the full CPUArchState. This makes it easier to
> decouple target-(in)dependent code.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/exec/cpu_ldst.h |   8 +-
>   accel/tcg/cputlb.c      | 218 +++++++++++++++++++---------------------
>   2 files changed, 107 insertions(+), 119 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index da10ba1433..8d168f76ce 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -361,19 +361,19 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
>   }
>   
>   /* Find the TLB index corresponding to the mmu_idx + address pair.  */
> -static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
> +static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
>                                     vaddr addr)
>   {
> -    uintptr_t size_mask = env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
> +    uintptr_t size_mask = cpu_tlb(cpu)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;

No, I think this is a bad idea, because it bakes an extra memory indirection into very 
fundamental routines.

If we change anything here, we should pass in CPUTLB.


r~


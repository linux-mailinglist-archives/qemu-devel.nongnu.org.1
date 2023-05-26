Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020CA711B1B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LGU-0004pX-NJ; Thu, 25 May 2023 20:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LGS-0004mu-8u
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:25:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LGJ-0002IL-TY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:25:04 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-52cb78647ecso106682a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060694; x=1687652694;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=netFlBqz3evho3k/p6ygxuBBOanB2mBOD8yyL96fSUQ=;
 b=XLV705KP/aSowUd29JARw9igO8De5HSYMdnMtu9bR3orZgnCW/KkAIx5gIfusY4ggv
 y0SIubmSPxj9pUutEANzcXpWk0cCnuWEYNRHbpCcPKZ4qPoHB0/3j44Ju0YLPcDjPHO7
 kAUUyJcaMaQeskxPh4/U7lNNNiXrParyOYPizMW3NZU2DnRY0WzEYWNOR87NogqYIgPv
 2lPb+dUDrJsrO4Z1gqyORjlwG8B8WnpdZ8vupykhQ8HJWmcAUWWbf+LpZc0kQ41LExRQ
 FIgqU8OAu8fUJwuwCU01cBEFgxAsRGlhIAJJcq4RjxqAwh2oqOMcY0rhLaq0yV5moaTs
 R00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060694; x=1687652694;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=netFlBqz3evho3k/p6ygxuBBOanB2mBOD8yyL96fSUQ=;
 b=IVPek+4y/eMrqCQEWtZLtYQHsDqgxFPqM28l2TdTj+flFylAcXQm7wXkf6RBkUEBNi
 3bFaqjvu6+H25A7LxbpDceKW5NXCtSKP72D+LprftZdKPgXqoaS8vnCw9LULZ6MluLiZ
 Nnlul1SyhNcrr1CVJ/ch8LD2y0ObvCggQBI3qlrfM2fFBnR5RIb5IDfn/85HyjkYu4S8
 oWGNdrzmUmDWzqjUT7BEmwk2xXZW28rcHxibEsSxFZTfe9bLCDs6jpofooy4LsVnVWdV
 LeBSvkdY3g4VvNeJE9JmWY5/EKFgSaPmLpQjdUPrZEsrIgFOToWxWmis29DuLRNqodsH
 thBg==
X-Gm-Message-State: AC+VfDzVnF+OQpK20al1eKqNuLlIBK7vGFNtrc8YlD9hNHp8U95RvOjJ
 6WPy+0yyWYP8KZEEcsvTPJqPXGaXwZFKRDKNUWw=
X-Google-Smtp-Source: ACHHUZ7Ub8agWf5nUtpJKqRtHbRcPBJs6owahQ+qTnSdgZISv0u3hwHmnNF0BZy2HDuGjcep48DVvw==
X-Received: by 2002:a17:902:cecd:b0:1af:a2a4:837f with SMTP id
 d13-20020a170902cecd00b001afa2a4837fmr644665plg.26.1685060694293; 
 Thu, 25 May 2023 17:24:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a170902a41400b001ab39cd885esm1941270plq.212.2023.05.25.17.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 17:24:53 -0700 (PDT)
Message-ID: <a18c646e-f2cf-b4f8-4f23-cb73e44ea38e@linaro.org>
Date: Thu, 25 May 2023 17:24:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/2] accel/tcg: Improvements to atomic128.h
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20230524183258.1194571-1-richard.henderson@linaro.org>
In-Reply-To: <20230524183258.1194571-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/24/23 11:32, Richard Henderson wrote:
> Changes for v3:
>    * Most of the v2 patch set merged, except x86_64 atomic128-ldst.h,
>      which failed testing with clang-11 with debian 11.
> 
>    * New patch to change __int128_t detection.
> 
>    * This in turn enabled CONFIG_ATOMIC128, which was not ideal.
>      This clang bug/mis-feature of using a cmpxchg sequence for
>      implementing __atomic_load_n was already noted for aarch64,
>      so I should have expected it would also be true for x86_64.
>      Given that I am adding inline assembly for CPUINFO_ATOMIC_VMOVDQA
>      anyway, this isn't a big deal, but I did need to adjust the ifdefs.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>    meson: Split test for __int128_t type from __int128_t arithmetic
>    qemu/atomic128: Add x86_64 atomic128-ldst.h
> 
>   meson.build                               | 15 +++--
>   host/include/x86_64/host/atomic128-ldst.h | 68 +++++++++++++++++++++++
>   include/qemu/int128.h                     |  4 +-
>   3 files changed, 80 insertions(+), 7 deletions(-)
>   create mode 100644 host/include/x86_64/host/atomic128-ldst.h
> 

Superseded by
Message-Id: <20230526002334.1760495-1-richard.henderson@linaro.org>

r~


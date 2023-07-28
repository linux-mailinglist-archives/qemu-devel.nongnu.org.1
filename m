Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E741C767771
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 23:11:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPUNm-0000MX-Np; Fri, 28 Jul 2023 16:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPUNg-0000I2-4a
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:48:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPUNe-0002hc-DT
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:48:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b8ad356fe4so16249335ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690577289; x=1691182089;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=swhx+UmXMRuG2WPlabEX72KIYZxIKCZEqEKX8ygfJpo=;
 b=a2RRitqr34aqatTdsHb07UTbuGjaRqqabwzyzbLVW8S6kQ727PhcIJ7v/6VzyWZGX8
 6ir7+Ft8btS3nxGZdBrMO+cGQgHxeswYO2uDVPDBSd3DC2aHQoRWWirNb+rIvH/rLht4
 BV3UlhNz+fstO8Oa51lGBOYfZf67zxsDb2MdYTZnmdM+tBQMXgychq61YIw/0sBuDsKb
 /k5DzUhmnx1zQqfq6IiQ+YfZbBNBJJCyR8ZRDHQUzip2iK9b5YqDvDvgPe5zeVqFHNuK
 7tsjbR4ZhjyTUdRFLkJ1ks6TPAPPvwXnG0Lvre3aK/jskDrwvWj6jnmdjSvCA434VTAi
 3NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690577289; x=1691182089;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=swhx+UmXMRuG2WPlabEX72KIYZxIKCZEqEKX8ygfJpo=;
 b=NRnZxO74c/IbK/WVDFdpucX7jiSrW3lF//j3IzxnNCENgXIgBUQ/NVVsGCwl7Vijvu
 ezrqf3nmauQMoY5UeJbJB8xlhRopO6mYVcI6oTq8+kVkAGpkjfDQyTqw62rldnGd3feL
 ajGQq6IBu0OgzyS8iyFRkUEty20Y8mRFHJjW+ae9T3Z6tQDI3I/xwv14RvyTKzmCxgvp
 O6Kchl5MQsb3BJzx9qGSEyjR5yo1+hfN20TJOMYKPmlPiDkT1uOAMDUoK4HWBsEVQQBo
 mNVN9hEBn5sD5pZHB8bVbkPnhG3tMZy4uRs69sKF0ZHWexKi2N080ZK4Ded5yUbUo4fK
 waQg==
X-Gm-Message-State: ABy/qLZRpz7fLrvGu/tOCSvsgcb+pW/2cdNPpNMebCcagiL08aJCmc/X
 NQTnXOfgdD54Hgx7myfuOd8q3/cntchm9K8nJSw=
X-Google-Smtp-Source: APBJJlE8kglMgpDMaM0+wyOepjOleYHqwAqNsUCNU3fqvkHO3nOd8YQrTrqaWHmAvqBwVSu8VVvaVg==
X-Received: by 2002:a17:902:ec8c:b0:1b0:3df7:5992 with SMTP id
 x12-20020a170902ec8c00b001b03df75992mr2659913plg.32.1690577288961; 
 Fri, 28 Jul 2023 13:48:08 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm3999932plb.105.2023.07.28.13.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 13:48:08 -0700 (PDT)
Message-ID: <7a2be24a-14b7-7177-d5c1-d4439c8299fb@linaro.org>
Date: Fri, 28 Jul 2023 13:48:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/ppc: Disable goto_tb with architectural singlestep
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20230728173520.486025-1-richard.henderson@linaro.org>
In-Reply-To: <20230728173520.486025-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Cc qemu-stable.

On 7/28/23 10:35, Richard Henderson wrote:
> The change to use translator_use_goto_tb went too far, as the
> CF_SINGLE_STEP flag managed by the translator only handles
> gdb single stepping and not the architectural single stepping
> modeled in DisasContext.singlestep_enabled.
> 
> Fixes: 6e9cc373ec5 ("target/ppc: Use translator_use_goto_tb")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1795
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e6a0709066..74796ec7ba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4175,6 +4175,9 @@ static void pmu_count_insns(DisasContext *ctx)
>   
>   static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
>   {
> +    if (unlikely(ctx->singlestep_enabled)) {
> +        return false;
> +    }
>       return translator_use_goto_tb(&ctx->base, dest);
>   }
>   




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99C7122CA
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TFn-0007Zg-AP; Fri, 26 May 2023 04:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TFl-0007X7-Fn
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:56:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TFj-0006cT-QG
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:56:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so5250585e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685091410; x=1687683410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ed8Cxsa31pMQcDbFpjF1pg0ENVoRbQ64DrDmD6gaxgs=;
 b=gqECt8epi6RnGZktyh8ZwK+3X1/Qd07e6D1bMxupUJJf8ARlkdafYOx+Zmlz4qLd7D
 dDveoO3xMBfyFcdjdKj6q2hslFNThbGqCHEH8PjBtm776+tWB1182wPJwy+w6nNFYRn6
 2gEq5SPzcLJ/BKktJQO8vQ82wcLWUhqgzn27QQmMGHw9hPoeia7ezxLUd8wDUqW/tlc+
 pNHxjzkRcoawvWc1wuQ6widuERF0TE8OLjIs9c0t7yL17uK9gyWsCvCbiJQC7kfhYtqA
 hI+3Plf7eDExY5gN5PqqE+ZfYh8loe/4hmp6JwPbORvWJezcWjLjiqnqnrDzceP3E4WQ
 c18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685091410; x=1687683410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ed8Cxsa31pMQcDbFpjF1pg0ENVoRbQ64DrDmD6gaxgs=;
 b=SXECJlsTkoCTqepuWCgGm9zM+zDwnwqzjGdDGphgNbnbQgnSsjPvZoYc6bCq0RgZPn
 JQxhJ67P1Tntwg/hlF1/On1LBLAraEI95Bka0Rzdhxj/9ta11Ea2yfSDTmoJqDG0u6Bw
 g1UlWayRs9hz39gKSxTUOoSEexkh6LZOBibLjFFIqd4AO21CuwVdSo9tNGWtvHo+ByBQ
 FfbvmyI+eymgDIokXvHgG1kVTkXN6Qks3JUCVodE+hfqK5XP9SXSuA5H+ApVRtc5/k+Y
 ASnKeOxvIBrmHSPHdV6QedIDpCQ8q3WAybzb6xUHPGFMFJ++UE90UyKkEQw+0dKfOut1
 DUIA==
X-Gm-Message-State: AC+VfDyW2rAxoJgKH7hbadZDMjGSSsVxuYE4COJe1NoGJUVCbRRbrH5Z
 SW72lltM2YGXzdrx86k2Nk2H3w==
X-Google-Smtp-Source: ACHHUZ63cpjsu79Xn663wnSH6mWpwylQfANri0wrmW5jN7KA065KbV8dJGrk/Ujs5nC4GcCjwzGUhA==
X-Received: by 2002:adf:e3c4:0:b0:309:3698:8011 with SMTP id
 k4-20020adfe3c4000000b0030936988011mr846225wrm.57.1685091409719; 
 Fri, 26 May 2023 01:56:49 -0700 (PDT)
Received: from [192.168.69.115] (vit94-h02-176-184-29-207.dsl.sta.abo.bbox.fr.
 [176.184.29.207]) by smtp.gmail.com with ESMTPSA id
 q18-20020adffed2000000b003047dc162f7sm4352748wrs.67.2023.05.26.01.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 01:56:49 -0700 (PDT)
Message-ID: <dbb368d0-839c-ad09-01de-09b1a62416af@linaro.org>
Date: Fri, 26 May 2023 10:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/20] target/arm: Add commentary for
 CPUARMState.exclusive_high
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525232558.1758967-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi,

On 26/5/23 01:25, Richard Henderson wrote:
> Document the meaning of exclusive_high in a big-endian context,
> and why we can't change it now.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d469a2637b..4e16eab82e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -677,8 +677,15 @@ typedef struct CPUArchState {
>           uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
>           uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
>       } vfp;
> +
>       uint64_t exclusive_addr;
>       uint64_t exclusive_val;
> +    /*
> +     * Contains the 'val' for the second 64-bit register of LDXP, which comes
> +     * from the higher address, not the high part of a complete 128-bit value.
> +     * This is perhaps confusingly named, but the name is now baked into the
> +     * migration format.
> +     */
>       uint64_t exclusive_high;

Can't we rename the field if we add the old name to check_fields_match()
in scripts/vmstate-static-checker.py?

Juan, could we store this renamed information directly in the code in
VMState? Maybe adding some VMSTATE_KEY_ALIAS(_old_key, _new_key) macro
and have the migration/ code magically deal with that :)

I.e. here:

   VMSTATE_KEY_ALIAS("exclusive_val", high_addr),


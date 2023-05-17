Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C02706502
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEEl-000198-Ay; Wed, 17 May 2023 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pzEEi-00017c-Nu
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:18:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pzEEg-0008Qd-Qw
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:18:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f450815d0bso5916575e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684318701; x=1686910701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QnKiXCDNqdpBDBAkrGIooRJzByMniTbjD9mJuM0C080=;
 b=MVkTsVgxHWP38dNG/7dpNHwGeg0CB3atodPfg0hBCCT3esedEMGbmGZxV7h4lKOLp6
 6PBTX7lBM0AMtXHlxfe3hfa7FOg0jjgYqxEGlcBShcTlVsaBJsmsUsYnIKi9bvKex4lE
 QiKuB6CYn59W237whwAppbCn6KXvdN9huMYYBGnhGlkrjVvrDxm8zr1dhI++P0Lel3Lw
 YoAm9hiuy7Wh8y/WAdXh++8MOE10+XZMl98uMAJ+H3SvcVw6LXzWIVnNQ13w+Hu5KcoA
 lsCApeqZcuT4vaKCUdIypB2+/3ohNLSZ78LLsxV2oEp7S5TbNCnkZIXyViJ2M7EpeeKs
 vtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684318701; x=1686910701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnKiXCDNqdpBDBAkrGIooRJzByMniTbjD9mJuM0C080=;
 b=QDVy/biwheY2xofjYpofIyqsTUgEkta0TClHogmBZgExvwPi1MVvq9ZQHAnCmRq8c0
 4KDp50P/i7+blzJmuZeGOi0bmKXL3xaHfdkej+6b2nvDvi6QLMBL8rEj/TK5SD5Yuk50
 k/aKvBDhdK6UdRSDeqD2SrPl3LJo5fwEv8hg6gGHjy5Se/7TOSeylQ3lSjE3xz9dMuVe
 nfHxOmdCCkO8C7oGVANsBCAEu/fGZDLDnEVcOfQP56uXqb+mZx6fXfSSHgerNHHbiMgb
 O4CDVy/izKsJwvGXGBE+L0RaYqXzWUcSFhSepW+4i+GgZT8ig1c5aqyAHwcSEdSYwRoD
 emdg==
X-Gm-Message-State: AC+VfDzjY34oigVnDTJRmlLr1er5e3TqxtiRYXEYpdgk5a5hB+3GVE/h
 7z2tRquZxg60OYk1XrlNCgJdGw==
X-Google-Smtp-Source: ACHHUZ4zCFtcjtyouDy8cgJcXAx6+frmoOPgtc09S4OHICoXGO84QAOmFjLBY2fOVs8DUOiPtMS4UQ==
X-Received: by 2002:a5d:68c5:0:b0:309:839:be3e with SMTP id
 p5-20020a5d68c5000000b003090839be3emr282275wrw.33.1684318700862; 
 Wed, 17 May 2023 03:18:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.202.229])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a5d4ad2000000b003012030a0c6sm2422683wrs.18.2023.05.17.03.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 03:18:20 -0700 (PDT)
Message-ID: <add7a0f7-92b4-c0ce-f237-366672df053b@linaro.org>
Date: Wed, 17 May 2023 12:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] include/exec: Make ld*_p and st*_p functions
 available for generic code, too
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
References: <20230517074222.766683-1-thuth@redhat.com>
 <20230517074222.766683-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230517074222.766683-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

Hi Thomas,

On 17/5/23 09:42, Thomas Huth wrote:
> This will allow to move more code into the target independent source set.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/exec/cpu-all.h | 25 ----------------
>   include/exec/tswap.h   | 66 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+), 25 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index ad824fee52..0daa4c06e5 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -55,31 +55,6 @@
>   #define bswaptls(s) bswap64s(s)
>   #endif
>   
> -/* Target-endianness CPU memory access functions. These fit into the
> - * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
> - */
> -#if TARGET_BIG_ENDIAN
> -#define lduw_p(p) lduw_be_p(p)
> -#define ldsw_p(p) ldsw_be_p(p)
> -#define ldl_p(p) ldl_be_p(p)
> -#define ldq_p(p) ldq_be_p(p)
> -#define stw_p(p, v) stw_be_p(p, v)
> -#define stl_p(p, v) stl_be_p(p, v)
> -#define stq_p(p, v) stq_be_p(p, v)
> -#define ldn_p(p, sz) ldn_be_p(p, sz)
> -#define stn_p(p, sz, v) stn_be_p(p, sz, v)
> -#else
> -#define lduw_p(p) lduw_le_p(p)
> -#define ldsw_p(p) ldsw_le_p(p)
> -#define ldl_p(p) ldl_le_p(p)
> -#define ldq_p(p) ldq_le_p(p)
> -#define stw_p(p, v) stw_le_p(p, v)
> -#define stl_p(p, v) stl_le_p(p, v)
> -#define stq_p(p, v) stq_le_p(p, v)
> -#define ldn_p(p, sz) ldn_le_p(p, sz)
> -#define stn_p(p, sz, v) stn_le_p(p, sz, v)
> -#endif
> -
>   /* MMU memory access macros */
>   
>   #if defined(CONFIG_USER_ONLY)
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index 68944a880b..2774820bbe 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -69,4 +69,70 @@ static inline void tswap64s(uint64_t *s)
>       }
>   }
>   
> +/*
> + * Target-endianness CPU memory access functions. These fit into the
> + * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
> + */
> +
> +static inline int lduw_p(const void *ptr)
> +{
> +    return (uint16_t)tswap16(lduw_he_p(ptr));
> +}
> +
> +static inline int ldsw_p(const void *ptr)
> +{
> +    return (int16_t)tswap16(lduw_he_p(ptr));
> +}
> +
> +static inline int ldl_p(const void *ptr)
> +{
> +    return tswap32(ldl_he_p(ptr));
> +}
> +
> +static inline uint64_t ldq_p(const void *ptr)
> +{
> +    return tswap64(ldq_he_p(ptr));
> +}

Hmm I am a bit confused, I was working on removing the tswapXX API
from softmmu [*] (restricting it locally to gdbstub). Now I realize
commit 24be3369ad ("include/exec: Provide the tswap() functions for 
target independent code, too") exposes it furthermore. I thought the
ld/st API was clearer and enough for all our uses, but maybe I am
wrong and we need this API.

[*] 
https://lore.kernel.org/qemu-devel/20221213125218.39868-1-philmd@linaro.org/


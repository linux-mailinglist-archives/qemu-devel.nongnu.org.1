Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D303A774C51
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTs6-0005zA-69; Tue, 08 Aug 2023 17:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTs4-0005yt-Bx
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:04:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTs1-0004rA-Do
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:04:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc1c1c68e2so39517975ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528636; x=1692133436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rh9p7AIOGyU6ObaL+YC3Fbhp2PRzDhw5cjORSwCVzQY=;
 b=FkId8wBQwm/JklwM2K8FK38v3sxGNULoqWTpv5xZyNKSB23gIh6VRzJyBZKQyA3upA
 umZAnxgLfTaOLLTqdh50upzyfqHKcm5PmzAoJjO5hbZlLoNHopzcK9KrM1olkZWTmi5m
 8vjyCUEgbX6CikEHsNLxQ/Bf9Acea9XKYEipSOW5T8RNZIJuDR5AlABjl8l7EaChu5n/
 C5fKpJPDlvNOayVOFuAWjsSB6WFcvN7Rf9NlRNF0ZfWHWwhv5IkgZMGYlZ+ZCAbysw+T
 6X0nzlkDTe54qkdz88d2dgehstj0ONm80hFXpv9yItFPwPFCkYiM35mUC8gS/NwPJeO9
 dWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528636; x=1692133436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rh9p7AIOGyU6ObaL+YC3Fbhp2PRzDhw5cjORSwCVzQY=;
 b=aYymjF3DwdE+37ywYStJ4+4fDNWJimdvQXzVmXnT2oQRQf9F61Y8mWt/vBQ1rNwPNE
 TnARpYQ++I2DTA5k5kDjcbGaC2vLTROnGB4Ed5/pdKmqC0Z6HIYFFpARrFzpgrRA7K8q
 c7++FRYQqVO6wwr7yUXR4AhgZKmU7qnXC0FSRLH7b5ZMbMYsUAnScF8LTJpj3xL5LkKr
 2Q1OERx+DAzUeDHIUeFEQaD6xC2N0R6VKsQN0o/O7wv7Vfi49JqxjAidTgL3w/wlNgVJ
 eO3SFBIYeteqtx08+Tn9q/A3ibvOwAqbUrMPSamqAA+XJMrX2E4mLQ2Is+HigK4sFdZ/
 bCHw==
X-Gm-Message-State: AOJu0YyPFLRIthksAyIH6wi0Ye6ErzmNv506NHK1FFkqtSuK4dBI11vJ
 wF/kQL2/BtRd+k7YoWftYGWCZQ==
X-Google-Smtp-Source: AGHT+IEYY5XEb7dKRnooq6oh08W3CZCCo0yiju11c2DsYO6zv5282uExSKcl28+1hQRfgJ6e6wwVmg==
X-Received: by 2002:a17:903:32c5:b0:1bc:4f04:17f9 with SMTP id
 i5-20020a17090332c500b001bc4f0417f9mr1018309plr.9.1691528636386; 
 Tue, 08 Aug 2023 14:03:56 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a17090264d700b001bb24cb9a40sm9635705pli.39.2023.08.08.14.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:03:55 -0700 (PDT)
Message-ID: <d9caacde-d8ab-2fdc-372a-20988f22267c@linaro.org>
Date: Tue, 8 Aug 2023 14:03:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/33] Update the definitions of __put_user and __get_user
 macros
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-4-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-4-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Warner Losh <imp@bsdimp.com>
> 
> Use __builtin_choose_expr to avoid type promotion from ?:
> in __put_user_e and __get_user_e macros.
> Copied from linux-user/qemu.h, originally by Blue Swirl.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/qemu.h   | 81 ++++++++++++++++++++---------------------------
>   bsd-user/signal.c |  5 +--
>   2 files changed, 35 insertions(+), 51 deletions(-)
> 
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index dfdfa8dd67..c41ebfe937 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -307,50 +307,37 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
>   #define PRAGMA_REENABLE_PACKED_WARNING
>   #endif
>   
> -#define __put_user(x, hptr)\
> -({\
> -    int size = sizeof(*hptr);\
> -    switch (size) {\
> -    case 1:\
> -        *(uint8_t *)(hptr) = (uint8_t)(typeof(*hptr))(x);\
> -        break;\
> -    case 2:\
> -        *(uint16_t *)(hptr) = tswap16((typeof(*hptr))(x));\
> -        break;\
> -    case 4:\
> -        *(uint32_t *)(hptr) = tswap32((typeof(*hptr))(x));\
> -        break;\
> -    case 8:\
> -        *(uint64_t *)(hptr) = tswap64((typeof(*hptr))(x));\
> -        break;\
> -    default:\
> -        abort();\
> -    } \
> -    0;\
> -})
> +#define __put_user_e(x, hptr, e)                                            \
> +    do {                                                                    \
> +        PRAGMA_DISABLE_PACKED_WARNING;                                      \
> +        (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                 \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_##e##_p,            \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 4, stl_##e##_p,            \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 8, stq_##e##_p, abort))))  \
> +            ((hptr), (x)), (void)0);                                        \
> +        PRAGMA_REENABLE_PACKED_WARNING;                                     \
> +    } while (0)
> +
> +#define __get_user_e(x, hptr, e)                                            \
> +    do {                                                                    \
> +        PRAGMA_DISABLE_PACKED_WARNING;                                      \
> +        ((x) = (typeof(*hptr))(                                             \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                 \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 2, lduw_##e##_p,           \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 4, ldl_##e##_p,            \
> +        __builtin_choose_expr(sizeof(*(hptr)) == 8, ldq_##e##_p, abort))))  \
> +            (hptr)), (void)0);                                              \
> +        PRAGMA_REENABLE_PACKED_WARNING;                                     \
> +    } while (0)

Hmm.  I guess this works.  The typeof cast in __get_user_e being required when sizeof(x) > 
sizeof(*hptr) in order to get the correct extension.

Is it clearer with _Generic?

     (x) = _Generic(*(hptr),
                    int8_t: *(int8_t *)(hptr),
                    uint8_t: *(uint8_t *)(hptr),
                    int16_t: (int16_t)lduw_##e##_p(hptr),
                    uint16_t: lduw_##e##_p(hptr),
                    int32_t: (int32_t)ldl_##e##_p(hptr),
                    uint32_t: (uint32_t)ldl_##e##_p(hptr),
                    int64_t: (int64_t)ldq_##e##_p(hptr),
                    uint64_t: ldq_##e##_p(hptr));

In particular I believe the error message will be much prettier.

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


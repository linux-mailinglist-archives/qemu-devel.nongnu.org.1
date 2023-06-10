Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0172ACA9
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 17:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q80iE-0001xP-Vi; Sat, 10 Jun 2023 11:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80iC-0001x0-Oh
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:41:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80i9-0001UU-21
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:41:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6513e7e5d44so2379852b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686411663; x=1689003663;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ojci1C7RY8jxWM1L3BSW4KeeSZ5Fmxb9fLKEz98rQ5o=;
 b=nWpKLWU/nmj+uK3N0gLtIlYKeysrGrHT/NHoV2l0hXUb+I8aVZKkhoLkg0h6Ec6aea
 X7WvJ9XfezaO6WGLXoI10Jl/MRVDNMRyx2fLk9IlrSZ+Qm8i5v46EaHf/w4W1SHNfMS+
 SNVr8/juE2a+TIPiavatZHGJ7VUxrLUjhwM7W0xjC7dQRYz/y4vKIVOr28SJ6y0VLdxX
 JcJ/GWtidLPSGqcd/zz8yJNBqUBPMzDDTx51dpe8lsmUroPXGE3+dAYH/y62NpSiv0uD
 lOYtH3IoG5N0NEz9TpofUQwIcPEShYk9fhXXxk/8T1SLRvtFfDPBWTEdcaVB874BhmDV
 4oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686411663; x=1689003663;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ojci1C7RY8jxWM1L3BSW4KeeSZ5Fmxb9fLKEz98rQ5o=;
 b=AqLcCbT2XzyQYFSD2i4LsbAB5RgOU33HFjgfZa0Ui2L/yuX406flbxHl+VwLenwzW+
 /mPjedIaYm1b946StjNhHVTZmI6Shyw1u1+t2Ov8frEh0AtAH7OHp7Zc2GkypwVuh+CU
 LnzvSFgSyJ+wb7MZmoaoUr79Ts01WEOfYWe53n0eH1U803EOSdh77qKMu/e70oIlnW0K
 LIQShf6Ma6lvJXr6LnbTJyL0T0pQPuYM+k9rG7Fje7SGXtH78OvUgZYmWiAZ4ZWXtUyA
 pRS2TOsfcamhsajQmgItWvHHl9Z+YQfzD8OLT4Lnz66lhXjPViaTrpMwLM2c+8U1P0pp
 vH7g==
X-Gm-Message-State: AC+VfDzmbGu0KLCCiYt98NO5xsplC8SP+y2XC05r7ASp0lznTiiTj8A9
 5gVaWbtzrH4x9pkGuO041paCHg==
X-Google-Smtp-Source: ACHHUZ7Uf+ysR4PvUgv7ruhgittDTZ0DRS7lrZ/WM5LMHcwL5PEnk4ADa76G2GkVrV5MhrSOoPnrdQ==
X-Received: by 2002:a05:6a00:845:b0:64d:5b4b:8429 with SMTP id
 q5-20020a056a00084500b0064d5b4b8429mr5864853pfk.18.1686411663295; 
 Sat, 10 Jun 2023 08:41:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 s2-20020aa78282000000b0065017055caasm4287451pfm.210.2023.06.10.08.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 08:41:02 -0700 (PDT)
Message-ID: <fd91ad16-9dac-7c96-5348-8ea9edd9ee31@linaro.org>
Date: Sat, 10 Jun 2023 08:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] target/tricore: Add shuffle insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
 <20230610105547.159148-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610105547.159148-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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

On 6/10/23 03:55, Bastian Koppelmann wrote:
> +/*
> + * table from
> + * https://graphics.stanford.edu/~seander/bithacks.html#BitReverseTable
> + */
> +static const unsigned char BitReverseTable256[256] = {
> +#   define R2(n) n, n + 2 * 64, n + 1 * 64, n + 3 * 64
> +#   define R4(n) R2(n), R2(n + 2 * 16), R2(n + 1 * 16), R2(n + 3 * 16)
> +#   define R6(n) R4(n), R4(n + 2 * 4 ), R4(n + 1 * 4 ), R4(n + 3 * 4 )
> +    R6(0), R6(2), R6(1), R6(3)
> +};

This is revbit8() from qemu/host-utils.h.

> +uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
> +{
> +    uint8_t buf[4];
> +    uint8_t resbuf[4];
> +    uint32_t byte_select;
> +    uint32_t res = 0;
> +
> +    stl_le_p(buf, arg0);

While storing to a buffer works, it's just as easy to use shifts.

> +    byte_select = arg1 & 0x3;
> +    resbuf[0] = buf[byte_select];

   resb = extract32(arg0, byte_select * 8, 8);
   res |= resb << 0;

> +    resbuf[1] = buf[byte_select];

   res |= resb << 8;

etc.

> +    if (arg1 & 0x100) {
> +        resbuf[3] = BitReverseTable256[resbuf[3]];
> +    }

The bit-reversal is controlled by one bit for all bytes.  It can be done for all bytes in 
parallel.  Use the shifts from bitrev8, applied to the entire uint32_t result.


r~


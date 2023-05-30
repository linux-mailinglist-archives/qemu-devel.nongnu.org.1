Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DA7169FD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42RV-0008H2-25; Tue, 30 May 2023 12:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42RO-00086f-Eh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:43:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42RL-0002rJ-Rs
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:43:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso3231730b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685464998; x=1688056998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oYKKJcIwvA4BWnLLgBDLEIzM820+dq4uOyDbON7XXKU=;
 b=i5SRWzHPQKGUyuk36MzU9rgQNREpMs8QyJMK7O7Z2jGauIzfdiSCrE288HJ5oTk/M5
 BU/BlDxKVUQ2SoT/qNsHeuY2t9s1DIg4AEU28CkRApqKYLBrRNAPzZ6f5fyszG5JzmDI
 w/gBMjnFsUCdRUS1zf26TBUO2LF2pauYhMMcX+7aug85UgCy0xp3ld8l3ReP5EENs+c1
 hh/U9mCwiQu046vtBsard9bARB1SCPfSw+GDMwCZuRFsBk5tPzZWloB+OHuUccsrozSw
 aETqYboCwuybknJH9qpGIZw2lW52sIVUXTNM3PrbRr9rys4YbzgHfUrMrG6Pp0gw+XJp
 +05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685464998; x=1688056998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYKKJcIwvA4BWnLLgBDLEIzM820+dq4uOyDbON7XXKU=;
 b=PQtj+/5AXLOxiNWgzWku6q5W6RXONz3dplQCN2EeWNhIq/4TmtbE27vby1udEUV/qg
 rLe32mQ14L4emsyGszbTek9hpMyN4kdw3jlF7JmHbM8acduJVmDNLYxyVEesW1mvk8It
 gI567T9gaw7mWEj17LPTvugQpbM+A1kDrzAr/M3Y8zOsE44zQ72J0kqXb6K3uhxrVOc2
 80uV1o4dVkiV6Hj2G4xvymmrxe8LGUiQXJVuXBNyxnOj9WzUBgSXmn+jeZZslnA9ow/b
 kZFR4g0Q6EJ0d6atPGqoIt6DwrcuOp6o2rEzoFsDIzhY6eeARFqy4dSCHsKGiQy1k4Ex
 GH0w==
X-Gm-Message-State: AC+VfDwcIDHguwyXJjzwUaHGpWJ8ziN7+tUEpbrUb/Z5e7V6dHkkpwyr
 +xCHWzNA2zW1jJK578TBjSkoww==
X-Google-Smtp-Source: ACHHUZ7E7Pb8GWV1W/6bTp75RRwGIThf/2AjJxRYRQtE26mQfePfQif3f5J8n5ZIl1YF+oxVC7mZEA==
X-Received: by 2002:a05:6a20:728b:b0:f0:50c4:4c43 with SMTP id
 o11-20020a056a20728b00b000f050c44c43mr3248409pzk.5.1685464998462; 
 Tue, 30 May 2023 09:43:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 z5-20020aa791c5000000b0064fabbc047dsm1874032pfa.55.2023.05.30.09.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 09:43:18 -0700 (PDT)
Message-ID: <666b4b6c-380e-142e-9348-823006b35312@linaro.org>
Date: Tue, 30 May 2023 09:43:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230530135204.2903761-1-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530135204.2903761-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 06:52, Ard Biesheuvel wrote:
> +#ifdef __x86_64__
> +    if (have_aes()) {
> +        __m128i *d = (__m128i *)rd;
> +
> +        *d = decrypt ? _mm_aesdeclast_si128(rk.vec ^ st.vec, (__m128i){})
> +                     : _mm_aesenclast_si128(rk.vec ^ st.vec, (__m128i){});

Do I correctly understand that the ARM xor is pre-shift

> +        return;
> +    }
> +#endif
> +
>       /* xor state vector with round key */
>       rk.l[0] ^= st.l[0];
>       rk.l[1] ^= st.l[1];

(like so)

whereas the x86 xor is post-shift

> void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
> {
>     int i;
>     Reg st = *v;
>     Reg rk = *s;
> 
>     for (i = 0; i < 8 << SHIFT; i++) {
>         d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
>     }

(like so, from target/i386/ops_sse.h)?

What might help: could we do the reverse -- emulate the x86 aesdeclast instruction with 
the aarch64 aesd instruction?


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64B74AF7C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjJG-0003AH-3X; Fri, 07 Jul 2023 07:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHjJ7-000380-7u
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:07:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHjIw-0000dz-4J
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:07:19 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so2762055e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688728031; x=1691320031;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0xN/Il7udj313sbDORLEDrsP7aZXskElEkNrr+slBU=;
 b=gAMWkPw2zztYgeGKs2zk9VBFWXOEntVYCCAeVSxx1WLdd6ZtpaLLCGJFjufTLhDu1H
 8wvWW+ruDdrsqZAjrwoVbAKWWVPoUDBWN1FdZzPYnH63wLnlyLgbECUci8m4g4HTRu1D
 t6IjBc6/NCYAx9XXJjIjHvp8nTLT3ZBDBCGYJ4prYaz2QrFVxS0kAaldDRmGBoSsmtjX
 l3hOBhaN20LRF18vCT6qyXye80w8rw3memlk71LaUduyxl3PiAJVP3QaVg0uo3SAwgfV
 4Yf0jsT1eFR0ieZUCg6ed8Mmu90mk177T1X5oKcqc7TsG92NwqSJ0Sej3Jrn126GUYHg
 IaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688728031; x=1691320031;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F0xN/Il7udj313sbDORLEDrsP7aZXskElEkNrr+slBU=;
 b=a1xKUGDT+pQ8J/fvfBMdWx+aEdC3VPXzPtX0cYzNPu7M2ecBUv1qy43SO+rsuqQdtJ
 Iy1SsIpRO75f9e7gKekhVtuTm9S7+Eiy9iRGnXNVDULR4Hdksq0XVwwwF2hINsSZM0nT
 DOZJyNbTxCFdb+g6X/2zuVGCb2E/gJDSk7AxsVpjuRnIPaeJHQxn4WhRcuP2EJ3uOn/M
 f+6Rw62BQKn67J5Tg4wpGxwWL8LVvriNLQ+v8PrGJVjXyB+Fed91Z3BpJnwdOy0ZMaoK
 m5JzE0iMNoHhwcp1wgcXaI+L1FXvAUPmhriYl4HSrXkKI5Hcl/uScbUtcOuT0A7Jg0Cw
 vYSQ==
X-Gm-Message-State: ABy/qLZDIitRExwWim57z+sHTEBNReOcS1shLNoI/HP0g/k61Gaj9oly
 Oeyoh+PUWMrL7WB8cqFsavrUAZUFW2ko/sBDfr8=
X-Google-Smtp-Source: APBJJlG26B4tRlOBpx2YT33r9MflYhjzb7LDlbUE3PCvExlwh3716Bj+hWOO27R3yZjca/2czALQ6Q==
X-Received: by 2002:a05:6512:3da8:b0:4fb:8b2a:a4af with SMTP id
 k40-20020a0565123da800b004fb8b2aa4afmr4893812lfv.2.1688728030921; 
 Fri, 07 Jul 2023 04:07:10 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.9])
 by smtp.gmail.com with ESMTPSA id
 l14-20020ac24a8e000000b004fb9536bc99sm639399lfp.169.2023.07.07.04.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 04:07:10 -0700 (PDT)
Message-ID: <c2d56703-3559-90eb-419c-49ae3cc065be@linaro.org>
Date: Fri, 7 Jul 2023 12:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 16/46] target/loongarch: Implement
 xvmadd/xvmsub/xvmaddw{ev/od}
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-17-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-17-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/30/23 08:58, Song Gao wrote:
> +#define XVMADD_Q(NAME, FN, idx1, idx2)                    \
> +static bool trans_## NAME(DisasContext *ctx, arg_vvv * a) \
> +{                                                         \
> +    TCGv_i64 rh, rl, arg1, arg2, th, tl;                  \
> +    int i;                                                \
> +                                                          \
> +    CHECK_VEC;                                            \
> +                                                          \
> +    rh = tcg_temp_new_i64();                              \
> +    rl = tcg_temp_new_i64();                              \
> +    arg1 = tcg_temp_new_i64();                            \
> +    arg2 = tcg_temp_new_i64();                            \
> +    th = tcg_temp_new_i64();                              \
> +    tl = tcg_temp_new_i64();                              \
> +                                                          \
> +    for (i = 0; i < 2; i++) {                             \
> +        get_vreg64(arg1, a->vj, idx1 + i * 2);            \
> +        get_vreg64(arg2, a->vk, idx2 + i * 2);            \
> +        get_vreg64(rh, a->vd, 1 + i * 2);                 \
> +        get_vreg64(rl, a->vd, 0 + i * 2);                 \
> +                                                          \
> +        tcg_gen_## FN ##_i64(tl, th, arg1, arg2);         \
> +        tcg_gen_add2_i64(rl, rh, rl, rh, tl, th);         \
> +                                                          \
> +        set_vreg64(rh, a->vd, 1 + i * 2);                 \
> +        set_vreg64(rl, a->vd, 0 + i * 2);                 \
> +    }                                                     \
> +                                                          \
> +    return true;                                          \
> +}

It's easier to debug if you make this a function, into which you pass parameters, like 
tcg_gen_muls2_i64.

> +    len = (simd_oprsz(v) ==  16) ? LSX_LEN : LASX_LEN;      \
> +    for (i = 0; i < len / BIT; i++) {                       \

More of this.


r~


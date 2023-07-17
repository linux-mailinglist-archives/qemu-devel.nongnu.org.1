Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5857756C42
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLT73-0003Me-CB; Mon, 17 Jul 2023 14:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLT70-0003Ln-Qx
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:38:22 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLT6y-0006dh-6y
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:38:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so37961185ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689619098; x=1692211098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJLenwCGiiqCitAlv7IBpGXaKZMyRroQkWBiF4/PBu4=;
 b=yJtxpqcDwYffYxd1DtbqQ6ygV2NnxEnSqPrWXQ1KXlZpKsE8WHrstapBl3EV7rIHur
 59HvwW9NRFwZWWFF9Xl4x9s6K75LvSGAov8OQ02vjd8UZUS7haclostWGnIhznUqyzAN
 5NCOnblMu7qjdlYoy/vG6+CLDQ83dCiuhfyPpMbLiSdyqMASW6ql96sL+q8xnVCF4mVY
 bgePAfsfP/pLLQ3ApqfeYAkFuWHn6w24aJ9q8CC3NPIlfQ5TajoVLfH/bij60CVx7Odf
 cpV6q7gVWhWnF2Ii9ngkTwBGChIXC2SFZM9NQxONm9FfErcur7Tj6JUW6AgpKr02DwWa
 MQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689619098; x=1692211098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJLenwCGiiqCitAlv7IBpGXaKZMyRroQkWBiF4/PBu4=;
 b=ESBalmdctpplrDlVPWrUqOJG7Evl9UFRI74kJtV11BFkUCP1/FYZHHjjEMaSALU2xa
 +fhfP5KRxGms0VouMur+97E3EP5EV1piY34xbB92MciLmL9Hr0RlBIiYDn5wHOtoi4lR
 vv3a5yBare5HVuN/WI7/3pMAOhZqyM19BHFr46tYDwOJTwAS5Vn6Dk1LZiXq66HggWJB
 jSQWwomVxvEKJ3KnDUUp+0wJuY+MO1S/gRHeGcyBIelQytscSUmhgQRYyg9j4c5SxzVP
 /1k6tnkI5YwFyrSSJybsooICzQa8FWWv3aEdWbizh64yXJlJYMAN7TSJExjNqEseVCug
 S1AA==
X-Gm-Message-State: ABy/qLZQOZy+4jgVxfW6UrFWe6OIRzEFjXmgQ620A49tjQ6XA15DFZYw
 Av2krJe1R5vvC6nQk/jw3032GQ==
X-Google-Smtp-Source: APBJJlF3o+bClR3DODC4/37ThuJA/7/UnDDPjl54YvN0Hr9kDflf7ebVoMNYKLg80s25SDFcqd00XQ==
X-Received: by 2002:a17:902:db05:b0:1b9:d38d:f08d with SMTP id
 m5-20020a170902db0500b001b9d38df08dmr14689801plx.18.1689619098106; 
 Mon, 17 Jul 2023 11:38:18 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.27.30])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a170902ce9000b001b85a56597bsm199051plg.185.2023.07.17.11.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 11:38:17 -0700 (PDT)
Message-ID: <171cb354-bbae-4e4a-e28f-bbbea481fb63@linaro.org>
Date: Mon, 17 Jul 2023 19:38:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/sparc: Handle FPRS correctly on big-endian hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230717103544.637453-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230717103544.637453-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/17/23 11:35, Peter Maydell wrote:
> In CPUSparcState we define the fprs field as uint64_t.  However we
> then refer to it in translate.c via a TCGv_i32 which we set up with
> tcg_global_mem_new_ptr().  This means that on a big-endian host when
> the guest does something to writo te the FPRS register this value
> ends up in the wrong half of the uint64_t, and the QEMU C code that
> refers to env->fprs sees the wrong value.  The effect of this is that
> guest code that enables the FPU crashes with spurious FPU Disabled
> exceptions.  In particular, this is why
>   tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
> times out on an s390 host.
> 
> There are multiple ways we could fix this; since there are actually
> only three bits in the FPRS register and the code in translate.c
> would be a bit painful to convert to dealing with a TCGv_i64, change
> the type of the CPU state struct field to match what translate.c is
> expecting.
> 
> (None of the other fields referenced by the r32[] array in
> sparc_tcg_init() have the wrong type.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>   * drop unnecessary change to gdbstub.c
>   * put the vmstate fields the correct way around
> 
> NB: I believe the vmstate changes to be correct, but sparc64
> seems unable to successfully do a savevm/loadvm even before
> this change due to some other bug (the guest kernel panics
> immediately after the loadvm).
> ---
>   target/sparc/cpu.h     | 2 +-
>   target/sparc/cpu.c     | 4 ++--
>   target/sparc/machine.c | 3 ++-
>   target/sparc/monitor.c | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


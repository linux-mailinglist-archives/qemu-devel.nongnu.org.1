Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13AA72F427
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9J5f-0003mK-5g; Wed, 14 Jun 2023 01:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9J5c-0003lU-UN
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:30:40 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9J5b-0004Cr-1z
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:30:40 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f6255ad8aeso7969228e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686720637; x=1689312637;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wPP6mWohKbwSJRTYfbmfdQ92HjL7m75udwbf2upx1hQ=;
 b=F5IJafTO/gJsFizLV9RLgT3GN0EFg37W5Whb6nYy+UAFh5CyGe+QPKnFXIrbDV/Yg3
 QZOHTiIv/Oe7XjuNJTf5T8Aiw/+tHFeNRewxyCdWv1ehg+Y/JUSFQAeubxDCfFW2Zh1t
 Wh+osVP2aSPfkrMrJkUANA0y9VdToV6ny1XORmyVVUiRLeRh2HiIgAGsPZ5BabteFreA
 rtwmE/cnw4/j4hqnL7xSafkQW613yiMrLd+K3DV5kGcIfsTc8B0DbwxEHM0Yq8fgSCJz
 CD4aoNrmnfTwQfGkxA9CVHutGM/NWWS8mvEiirUuPgs7ICzInliNiJ9oXsaZJQzUl/Nn
 HLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686720637; x=1689312637;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPP6mWohKbwSJRTYfbmfdQ92HjL7m75udwbf2upx1hQ=;
 b=MJGta7NZTsO2Ends2PhHhDSxNBlSdmHAtOETEf8ZA7Zz5iq23g0X3OUravuU753mVS
 HLX7kx+xF5yjuS5MYskrj1zM1yBzvQyJ/VN+GZltsCoDcGjqkunE/RsFQZuRBGAPlb0S
 9/epWRmYLMRO97MAjF9yzt3swZUmTtcaRdsdGM7d3AEjfo9fHWCDW/5RyikmDtHZr+UL
 OaQD5bvMzHohta9xivHFP2HDcmwd7ZfKJ6uSo73qxu0nPa6gALKmTszgNtCO3MBTAi5+
 C3WPegH/7wxw+d7WterBeh8ayvd6L+/de/4MyRuwhvLoiGub6y07kwPrd+kw4vFCL9hn
 i3Aw==
X-Gm-Message-State: AC+VfDzATqBHtXicuPVZSQBWnHmWrvF26HUSU1t4WdG6NLec9CJsVRqM
 mCP1gca5NWuIBb/DFUZDsNJhJQ==
X-Google-Smtp-Source: ACHHUZ70vZPyXT0wDpdURsKvO3jICHjLCqmA32zdRYXVCLI0Pffi0H9hqgB7H0wl6YmptytDmAqnpg==
X-Received: by 2002:a19:5602:0:b0:4f7:6427:c4e4 with SMTP id
 k2-20020a195602000000b004f76427c4e4mr835615lfb.29.1686720636971; 
 Tue, 13 Jun 2023 22:30:36 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a1c7510000000b003f7e6d7f71esm16283945wmc.36.2023.06.13.22.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:30:36 -0700 (PDT)
Message-ID: <98a4691a-db64-76e4-449f-4b4983cf166e@linaro.org>
Date: Wed, 14 Jun 2023 07:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/23] target/arm: Convert load/store-pair to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230611160032.274823-1-peter.maydell@linaro.org>
 <20230611160032.274823-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611160032.274823-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 18:00, Peter Maydell wrote:
> Convert the load/store register pair insns (LDP, STP,
> LDNP, STNP, LDPSW, STGP) to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Message-id:20230602155223.2040685-12-peter.maydell@linaro.org
> ---
> This was reviewed in v1, but the underlying code
> changed enough in the atomic-ops work that I've dropped
> the R-by tag.
> ---
>   target/arm/tcg/a64.decode      |  61 +++++
>   target/arm/tcg/translate-a64.c | 425 ++++++++++++++++-----------------
>   2 files changed, 271 insertions(+), 215 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +static bool trans_STP(DisasContext *s, arg_ldstpair *a)
> +{
> +    uint64_t offset = a->imm << a->sz;
> +    TCGv_i64 clean_addr, dirty_addr, tcg_rt, tcg_rt2;
> +    MemOp mop = finalize_memop(s, a->sz);
> +
> +    op_addr_ldstpair_pre(s, a, &clean_addr, &dirty_addr, offset, true, mop);
> +    tcg_rt = cpu_reg(s, a->rt);
> +    tcg_rt2 = cpu_reg(s, a->rt2);
> +    /*
> +     * We built mop above for the single logical access -- rebuild it
> +     * now for the paired operation.
> +     *
> +     * With LSE2, non-sign-extending pairs are treated atomically if
> +     * aligned, and if unaligned one of the pair will be completely
> +     * within a 16-byte block and that element will be atomic.
> +     * Otherwise each element is separately atomic.
> +     * In all cases, issue one operation with the correct atomicity.
> +     *
> +     * This treats sign-extending loads like zero-extending loads,
> +     * since that reuses the most code below.
> +     */

Could lose the bit about loads within the store function.


r~


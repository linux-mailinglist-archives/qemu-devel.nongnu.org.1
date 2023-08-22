Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D4784216
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRTL-0001ha-3E; Tue, 22 Aug 2023 09:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRTJ-0001gm-ER
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:31:01 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRTG-0004zj-73
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:31:01 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so6976091e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692711055; x=1693315855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VgL9IFkrJWpQ2CepvATAqVwHxpOeWG7yiJeo52yZv8E=;
 b=VPmYCWP5E0TDSq81M9GKXCfT5QRe3CYvelsIeMQJkI7OkPm6fBbd0rKDj3WEMoGeet
 ArzcAlZLyT7lC+gbPNPkx+UW5cl6r4igp1RK49tk9MnMmn3+3QpG/HN8VquIgG8JFvv/
 bjNKtPzwJ9MEKKEsTukQzkD3RymzOIOA/bVTQEXCMXsq02VtE7qBy+FH7u9QjiR4xuD1
 bebfyPtv+31cx388kBgCwB8RxBvmV65fswoP3LluoE16i7PrMlAOtCesxK6rGDRT2ZbL
 RnE8wr2ay7jfOxX7UFSg6kmteGf77NfOAZb/aCLfDmQU1W2rk5onUKG3+CpzXVsJMwUV
 fuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692711055; x=1693315855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VgL9IFkrJWpQ2CepvATAqVwHxpOeWG7yiJeo52yZv8E=;
 b=Vza3lfzkM/XL6lZuhpk8ptA4RabsAdnYgxPn5Te4sXLI4FVBTcmcKBb+kaoz0ZPArj
 zAtuHa3XB4+PoUBJ99nVbCO8k259t30oXFXyEpzR/PkvG/mDdERvZZH6XLdcg/enrs7+
 unSwzmetEPLv30OihmzGWXuSneEFEYWLWqSmFIlbks6ueeKMs+vEDDdv8+Y3bNUPjfyI
 8s9wYcdvzSNrkUiZq5CQ361Ed5XTkfrk6KCdkpf9YmUdyG2Jl6wmmY780YX+kTW0cHeW
 XjUcLRQPJe8L2CQYEUkkZdXpboqvk18eIhXOwK+7v3ho9MPkQRNaSPnDW4G9VUvFIDkH
 pavg==
X-Gm-Message-State: AOJu0YxPSA17hlYHJDZDFX7eM+mkrgyDT5h4cdROieQmifnCpvEijopM
 h0lGSbABkMkFbUVkzNATlaDOAFCI+Fbh/qEKeKfn/Q==
X-Google-Smtp-Source: AGHT+IELASPw4amLkagoKQl63CISR2G8GPJvbhkmh98Hg85akCKLXvqGKNrCFHq0fx5cPClYYvgPaw==
X-Received: by 2002:a05:6512:318f:b0:4f8:70d8:28f8 with SMTP id
 i15-20020a056512318f00b004f870d828f8mr8690074lfe.55.1692711054746; 
 Tue, 22 Aug 2023 06:30:54 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c0b4900b003fbd9e390e1sm19483576wmr.47.2023.08.22.06.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:30:54 -0700 (PDT)
Message-ID: <1ea2097b-fb72-29c4-622a-79f96f69c2c1@linaro.org>
Date: Tue, 22 Aug 2023 15:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 11/12] target/loongarch: Use generic hrev64_i32() in
 REVB.2H opcode
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz
 <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822125221.55046-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822125221.55046-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/8/23 14:52, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/insn_trans/trans_bit.c.inc | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
> index c04806dc21..9d564a0999 100644
> --- a/target/loongarch/insn_trans/trans_bit.c.inc
> +++ b/target/loongarch/insn_trans/trans_bit.c.inc
> @@ -111,19 +111,6 @@ static void gen_revb_2w(TCGv dest, TCGv src1)
>       tcg_gen_rotri_i64(dest, dest, 32);
>   }
>   
> -static void gen_revb_2h(TCGv dest, TCGv src1)
> -{
> -    TCGv mask = tcg_constant_tl(0x00FF00FF);
> -    TCGv t0 = tcg_temp_new();
> -    TCGv t1 = tcg_temp_new();
> -
> -    tcg_gen_shri_tl(t0, src1, 8);
> -    tcg_gen_and_tl(t0, t0, mask);
> -    tcg_gen_and_tl(t1, src1, mask);
> -    tcg_gen_shli_tl(t1, t1, 8);
> -    tcg_gen_or_tl(dest, t0, t1);
> -}
> -
>   static void gen_revh_2w(TCGv dest, TCGv src1)
>   {
>       TCGv_i64 t0 = tcg_temp_new_i64();
> @@ -161,7 +148,7 @@ TRANS(clo_d, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
>   TRANS(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
>   TRANS(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
>   TRANS(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
> -TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
> +TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, tcg_gen_hrev32_i64)

While this file uses a mix of _i64/_tl (so likely doesn't build
for 32-bit target), we should use tcg_gen_hrev32_tl() I suppose...

>   TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_hrev64_i64)
>   TRANS(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
>   TRANS(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF05737FCA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:07:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvfd-0001S6-LQ; Wed, 21 Jun 2023 07:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBvfb-0001Rb-CQ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:06:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBvfZ-0007KX-Mh
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:06:39 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso762380766b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687345596; x=1689937596;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FW57hrxDZQK/50WxyjJH06oKBVda/gT+vmWdGOuJLiU=;
 b=ZuQkd2OX9DDeAUUdfRAtwngnf1U6JJITw+yB2wm5CLhHJH7uE03lX4yLuYyM55DHT3
 n3LoqiAvCfom3JcUTCj3eFzz51cnv6ls/7htMv8j4oL95nKRyf+zpY5sXXs35ubPgTci
 7RWslktMHfKSa8C9fAtGUddo4z70n374nMG2YVDmh+GIS877ePq6CC//IjJXtY2Nmyxj
 vF66FYJUpuWudz4kXM16LNI+7LVf9R/mBpuRtnvpR+BvbFbbvwcBv9qBvFaauwYZzoGU
 vtr+bnN1fVhyHVs973za+LElX6zFfhry1scPBPpnGPDRNpwxFxI8Euh8RW1WqcdGviZ4
 v/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687345596; x=1689937596;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FW57hrxDZQK/50WxyjJH06oKBVda/gT+vmWdGOuJLiU=;
 b=kGknNWSef5Yg9G4D5Ovegn+Wbz1/l1H5HKCSBL7O2YDiz2YgBqVxiHHsTcxV0za2xj
 rAKDojBq7Jckb4+NLcvhFH7i1DkRLC5NAWDk9HFj9GONVokGvIlDYOs5FRNnTI9Tl0Ma
 UF3qMuFRL3eCDmuhdBAwmxsSjGVWNivCpYsqKsPlDFatSpEi0sq+iScjdxCmWPpjODQ6
 2ESunzTWNE01es4a6YevQq0/OrtWo6F+Rk+KzsmR9PiPg9oM2WQnxQaCUSVLPPa3sVyW
 DcFY0z+Wr9BFloR02HWAly6p+1tKTvTjAtlbsyX8LokfzpNYYT961wCeYxKoxnw9Yo0a
 f6EA==
X-Gm-Message-State: AC+VfDzSSJ/q3gkmlln/npXJizAbhKmsBz+AZr9vI8Itk4ImjYCNXGK+
 8cvytBWrQwQBvtlkg99kSuzYD99qxBciGrqloGKEarxz
X-Google-Smtp-Source: ACHHUZ7WcS55rp0DmnwitigxOmzyCqJSuwSooxobIlzifQLXvLSNhmbDtmriSdksDCAnUh0F8kp1fQ==
X-Received: by 2002:a17:907:62a6:b0:94e:bf3e:638 with SMTP id
 nd38-20020a17090762a600b0094ebf3e0638mr12839217ejc.11.1687345596120; 
 Wed, 21 Jun 2023 04:06:36 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a170906341800b0094f07545d40sm2883093ejb.220.2023.06.21.04.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 04:06:35 -0700 (PDT)
Message-ID: <227914fb-3251-648e-799f-495273cd311f@linaro.org>
Date: Wed, 21 Jun 2023 13:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 8/8] target/tricore: Fix ICR.IE offset in RESTORE insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
 <20230621101950.1645420-9-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621101950.1645420-9-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 12:19, Bastian Koppelmann wrote:
> from ISA v1.6.1 onwards the bit position of ICR.IE changed.
> ctx->icr_ie_offset contains the correct value for the ISA version used
> by the vCPU.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 71b6209af4..9cab0734dd 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -7956,7 +7956,8 @@ static void decode_sys_interrupts(DisasContext *ctx)
>       case OPC2_32_SYS_RESTORE:
>           if (has_feature(ctx, TRICORE_FEATURE_16)) {
>               if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
> -                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1], 8, 1);
> +                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1],
> +                        ctx->icr_ie_offset, 1);
>               } else {
>                   generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
>               }

Need to exit the tb, like for ENABLE.


r~


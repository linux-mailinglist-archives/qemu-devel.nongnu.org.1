Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C495578E33B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUay-0006xm-KB; Wed, 30 Aug 2023 19:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUau-0006wx-6U
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:27:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUao-0000Jf-CV
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:27:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68c3ec0578bso160845b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438040; x=1694042840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lDpPvgTXbcygSzB3DDxEYUoHON2SQt2qK169dtZog3w=;
 b=oXrDCSKBcCOpSP09iCkYF9AysOlW+pMTbPF/zjsyycSqnaTlVg5EvmxLhoImePUUG7
 P6pcq4HvpIVADKge3nU5Paeg5hBFhYbSNH2agQyr5jgAZR4Z/SntbfVxhtwjr/CjRRtt
 nETbDWR9TMLNBv6BTUWliT3j8Z4cIXFdfAhzFsDroMSHPnScv2CUQQhTZWliL4AzdYsx
 NfekZJnoG6WnZvM8fZ8rol23JR6e5itYQ1katOAWRviqoR2+uIA6l24JF8vh6x1L2jpm
 RqIZouPDYFXhdQ0pF3dg+l5jHzco1v0zBi770utlD1SXmKT9qfOJZUhE4Q4F3WZ/a8Ze
 tZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438040; x=1694042840;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDpPvgTXbcygSzB3DDxEYUoHON2SQt2qK169dtZog3w=;
 b=k4Q5Qtus6cN6i7BmZ3VGBSYxPPREcWm4U3dU/jQ1Ibdi8LGNgyR9Ovf/P0H23JLaSY
 16z2mqcHla4qTZaamIQJGRoL89lV4k3juLBkgcMhdC9ZYHaka+BiL+UsTbUBXxIpxOHk
 +uxI9cIa8g0Xs+siUpCJLyxK7jtcyFWOejBy3sTGc7I41VjZ5Vi1eySmSpzRjg38/LlL
 ks73sIpOtyMLzyLicmIO2STO/v+kuYYPcgLYauKQSLmEno1nhUMWOtqtgNYwU9b/cq2Q
 XYltjRaVoOhIdCu65pJx1apfl8Of5KtwDPBt9aSKmgfJum64nu92TrLLKqitwNiIKaWK
 R+qQ==
X-Gm-Message-State: AOJu0YzYOZgo+3cSVzmMYx7AXyhPrH4Ry35P75UAzBiufqdeCeyRZxIo
 +qb/6Ub9gbizUMsvwyJHOvqqI4z+8WYkcbef9nA=
X-Google-Smtp-Source: AGHT+IFgQ624+EL33rT+reBNknVXOqX9Gyxtr1JbXVPPraiOfLg5aioN7fDedSpByUsey5yezme5yg==
X-Received: by 2002:a05:6a20:1011:b0:14c:ca25:3b53 with SMTP id
 gs17-20020a056a20101100b0014cca253b53mr3402218pzc.27.1693438040645; 
 Wed, 30 Aug 2023 16:27:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a62bd18000000b00688965c5227sm108215pff.120.2023.08.30.16.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:27:19 -0700 (PDT)
Message-ID: <38e879cc-91aa-a391-6ed2-6541de9f2a26@linaro.org>
Date: Wed, 30 Aug 2023 16:27:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 34/48] target/loongarch: Implement xvclo xvclz
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-35-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-35-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVCLO.{B/H/W/D};
> - XVCLZ.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |  9 +++++++++
>   target/loongarch/insns.decode                |  9 +++++++++
>   target/loongarch/disas.c                     |  9 +++++++++
>   target/loongarch/vec_helper.c                | 13 ++-----------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  9 +++++++++
>   5 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
> index 67d829f9da..4497cd4a6d 100644
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -76,4 +76,13 @@
>   
>   #define R_SHIFT(a, b) (a >> b)
>   
> +#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
> +#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
> +#define DO_CLO_W(N)  (clz32(~N))
> +#define DO_CLO_D(N)  (clz64(~N))
> +#define DO_CLZ_B(N)  (clz32(N) - 24)
> +#define DO_CLZ_H(N)  (clz32(N) - 16)
> +#define DO_CLZ_W(N)  (clz32(N))
> +#define DO_CLZ_D(N)  (clz64(N))
> +

Aside from this movement,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7A736BE3
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:26:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaQN-0001Nc-Sc; Tue, 20 Jun 2023 08:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaQM-0001NT-AL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:25:30 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaQI-0005Tf-Tn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:25:29 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b45e6e1b73so57219031fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687263923; x=1689855923;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hUvAjl0B+G7IkEYAnOQaoOXTpDVXtO0HT4lWTYMYebo=;
 b=vjegNW8rHnqFBhqW4Gm8kELzRh6j2GmR1GiuRbmeDANaGnlFfvWuEh7fELa48UO0ML
 ruQwDVPqdvxlGvtb9ja4uez6OpvedOT7HgwEZ2cNruaQ7PUDLfQNl2kwCAMFUBwpmSB+
 262Q8Ynv/6RMimJyZW7SvghARQ2fWE1so8KNaSMbD/712/zCmUx8wqHWqpyBlLs05GA+
 Um15TCO9CWuRv5qkQ1knmzu3YENNrPCDXCnvl73heqB8388JGMhUTDH1x8Ce56uQM17l
 1xaYaI7bJABdCU/vIwrM9fKRmac/GsoEEvI0jM5dv4RKxkZaR/Rm/7v5rPuJBWq+hR1D
 yzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687263923; x=1689855923;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hUvAjl0B+G7IkEYAnOQaoOXTpDVXtO0HT4lWTYMYebo=;
 b=IFCEAnraS2j5npPh9K5YdRZqoZU1JHL60RkeG+7VtSRcIEf09jjxOOwRPXe3iMbq6T
 T6AFQuyopNJm3oe5pJCzbkJCLPGlxXnX6ItqFUeGL8sFI6Pp6yl2eqp2tpy+CoxLmFu/
 bIn8M/4NarmzuxZtC8s3wWYPcEx1eJACizrUcW+2h4nNPIGgXB7tqS1F+b5ep3ABe/hn
 9QXz5CbJuA6vcSwBxRlcWYiyzbesPXOU7YJMqgT6VyTjetl1DlEIITmwSi6GAAv1IACo
 tYx9maBjg9qRQs79s2t1HubmmZxlSeJQXWE3I7vZeqsbCJ4YgeTYAT1IaWBr8p8rcPq7
 0WcA==
X-Gm-Message-State: AC+VfDzdyds+9KEaEDkxN4SJ3mIAUNZ8hKTocHHST0thETRSFg3YO4HW
 aXD1q19cPnAKo/ksEkd/2p1IAmw2PiqMfx7lc5ICFSk1
X-Google-Smtp-Source: ACHHUZ65woA7OdqVW1gkv+LSxmX/oyVmLgXda4FzOsuNysMbhlMEUPSmZrExJda9D2h7ZpwbaEwDHw==
X-Received: by 2002:a2e:9bd9:0:b0:2af:29d2:2ffe with SMTP id
 w25-20020a2e9bd9000000b002af29d22ffemr7795146ljj.15.1687263922585; 
 Tue, 20 Jun 2023 05:25:22 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a170906725400b009878b0b5302sm1326218ejk.98.2023.06.20.05.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 05:25:22 -0700 (PDT)
Message-ID: <47d12e8b-493a-e58c-54a1-47bd919c7e20@linaro.org>
Date: Tue, 20 Jun 2023 14:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 04/46] target/loongarch: Implement xvadd/xvsub
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620093814.123650-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 11:37, Song Gao wrote:
> +static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
> +                     void (*func)(unsigned, uint32_t, uint32_t,
> +                                  uint32_t, uint32_t, uint32_t))
> +{
> +    uint32_t xd_ofs, xj_ofs, xk_ofs;
> +
> +    CHECK_ASXE;
> +
> +    xd_ofs = vec_full_offset(a->xd);
> +    xj_ofs = vec_full_offset(a->xj);
> +    xk_ofs = vec_full_offset(a->xk);
> +
> +    func(mop, xd_ofs, xj_ofs, xk_ofs, 32, ctx->vl / 8);
> +    return true;
> +}

Comparing gvec_xxx vs gvec_vvv for LSX,

>     func(mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);

gvec_vvv will write 16 bytes of output, followed by 16 bytes of zero to satisfy vl / 8.

I presume this is the intended behaviour of mixing LSX with LASX, that the high 128-bits 
that are not considered by the LSX instruction are zeroed on write?

Which means that your macros from patch 1,

> +#if HOST_BIG_ENDIAN
...
> +#define XB(x)  XB[31 - (x)]
> +#define XH(x)  XH[15 - (x)]

are incorrect.  We need big-endian within the Int128, but little-endian ordering of the 
two Int128. This can be done with

#define XB(x)  XB[(x) ^ 15]
#define XH(x)  XH[(x) ^ 7]

etc.

It would be nice to share more code with trans_lsx.c, if possible.


r~


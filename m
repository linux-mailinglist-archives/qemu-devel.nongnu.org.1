Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D67821B9
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXv9y-0008Ae-I3; Sun, 20 Aug 2023 23:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXv9p-00082p-RL
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:00:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXv9l-0001Tm-Lu
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:00:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso5804235ad.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692586840; x=1693191640;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MLFy2VcEiZyGdJbuMZZJPz5ki9C5rUQIPSKIggV4tKc=;
 b=VnahQ0dtzdPt5OU3+M9TxWbblEquE6Wqh2jQo5FyIpM2CHDcB0ombkmiJXF5yRirOE
 AoZFRuwL+htzKRVkpbzAE/pXS3057Ra2eNNv2I3/rzT1JF0cclq1SNwS3Nj2d/jYKIh9
 TaiXdWp9tZAGIy6q7IhP/9dVshO8RgNqlVeAek133dVX5qYKZWCCaZ3SD6Z8TE81wYdf
 9pr1sDFh4F7EXdy4u0C9biyY+hat25Nae6BOrDYmfwaqDWrbMZQ8FE2zc+mPTsdG/gf3
 WNdSXITY7/WxLsy3GlnyJx2+6ixSom9JsGVS3jrHnTyyDwdjTCD0mJ0ozHmcgLszYOlV
 gefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692586840; x=1693191640;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLFy2VcEiZyGdJbuMZZJPz5ki9C5rUQIPSKIggV4tKc=;
 b=QfiF0b0KtXkB5ZLaoVqtPnRVTedW3w14haK4cdh9sAT64Jz3FFJVH6OViTYLcYcBjM
 Ua4x4aNRkjXPO+Z5Q4mgicXoUU+cjAzeR+lhvRu5BhsK2PF9XxCKmRYSyuXiCB3Ezqax
 c++ilE9HqXboHVDfLTKuRCzv7ca+zOf7aiyFxungm96Ao1VYFNR5EJEszSr/5j/eKcXo
 yMhmaFtmDtvWQxc/JOZbOzniyG9P6xNXy/7Djva8c+5x60HgwZRuHGSTn5lbg4Di1AHy
 GmlwEE31CfLQXf3gJb5gdRulSi6Vub24BdjkN54jud7Fq019MKYhXaP23+wcH2CTE89F
 G68A==
X-Gm-Message-State: AOJu0Yx7qrNZOanVmI6+T4uPo/tf4eJjmmZMC4JnEK5lhK4RC/bEtPNh
 Ob4crySGwN5NrE2TTNrq2XZ5ded4G6AR16UOfzk=
X-Google-Smtp-Source: AGHT+IHev2BS8TVA5fucg11cUKSQzVajfy7B+gtgDFahSsIQ9EMG43XF66CEi1zkl8dEY9I5BNAEOw==
X-Received: by 2002:a17:902:f7d5:b0:1bc:2c79:c6a4 with SMTP id
 h21-20020a170902f7d500b001bc2c79c6a4mr2835340plw.56.1692586840009; 
 Sun, 20 Aug 2023 20:00:40 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:7da6:8db:fd7a:4d62?
 ([2602:47:d483:7301:7da6:8db:fd7a:4d62])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d50300b001bdc3768ca5sm5784722plg.254.2023.08.20.20.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 20:00:39 -0700 (PDT)
Message-ID: <d2115005-fe67-b934-c2dc-7f2b5f82fd2a@linaro.org>
Date: Sun, 20 Aug 2023 20:00:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Fix 64-bit SSRA
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20230821022025.397682-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230821022025.397682-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/20/23 19:20, Richard Henderson wrote:
> Typo applied byte-wise shift instead of double-word shift.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 631e565450c ("target/arm: Create gen_gvec_[us]sra")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1779

Bah.  #1737

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index b71ac2d0d5..39541ecdf0 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3053,7 +3053,7 @@ void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
>             .vece = MO_32 },
>           { .fni8 = gen_ssra64_i64,
>             .fniv = gen_ssra_vec,
> -          .fno = gen_helper_gvec_ssra_b,
> +          .fno = gen_helper_gvec_ssra_d,
>             .prefer_i64 = TCG_TARGET_REG_BITS == 64,
>             .opt_opc = vecop_list,
>             .load_dest = true,



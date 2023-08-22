Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A704C78466C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTll-00009J-T4; Tue, 22 Aug 2023 11:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTlk-00008t-75
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:58:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTli-0004hv-2w
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:58:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so30548215ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692719889; x=1693324689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m5yA9C6p63mRvyRVmh0V9kVMOn0ZV4uNQ/sMmflzaNA=;
 b=IaTmTV4b4tpTCNeCYEptZHCE+f2DAayx9CTzU+wupU+QUvnk5iC/5i4F80vu3hk1Oc
 04dXOXk0TEhuMxVKhyDpoZMIJ9mCVWk64ah2rElxLBrUDtdHRI1Ms7X788Pa5IkUtOEj
 h2KW89CvpNLHrX1LWR8b+bWh2Mzl4eMmNXhc4RKIVEaz8EfGcCOXzwzR6uyoLPykQcUY
 hwQKACVGaHSUwr1w4XG9u0M8E/rey6/6xAXL0hsdNr/WkcsVm4h0ZQ0lAZV0U0qphkgH
 8plIXe/fP0iy713A6Whf8XsDujkD+PHvP44CA9hNzK5MG2vcIJyNUiCE+3otYYz3DdKY
 2wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719889; x=1693324689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5yA9C6p63mRvyRVmh0V9kVMOn0ZV4uNQ/sMmflzaNA=;
 b=eKgaj4XUtvcQ/zdXbPV9QksUrz0tuC89Zhe9o83oIMYR4c+pBeuz2kWHCEGIrkWlaZ
 OTsA7LWdM1bD4nRsAX/vM7DTgXf/nL0dopeU8ii/PlwJ9mevZqDUG+Mla6VsaPsNOvzq
 pLT/3XLIGsx2/2GWWZ0LkMS1eio9juW+G3y1vitQd8IBUEpwFNwpHzi/G4iU5elAm9G1
 bZR+UcjCg7+PfD/neEpFp4ii7Mwc584Z38GMcWoZ4fMNXhAgFRLs1XOJHPSyT+BiU0Tk
 fi8nDqQaiHJIeRhSzPr4N5PBDk/jaLj0Rrp2lyV5fSaCN31K3jbGRFYIFa8YQKip5QLq
 Uycg==
X-Gm-Message-State: AOJu0YwpM6AGcopO8LlHg7IhlGS8fWMqZoNVWtzGPxya6GzWx5oIUh+d
 x+RPo7rDewHXaj743inL7vggFQ==
X-Google-Smtp-Source: AGHT+IGHh5eD15c435hJkaxcCG/9USuPulpPr1obdqmdCPiV/IS7T1KmPNoBJAuYD4b5uvrF43b2iw==
X-Received: by 2002:a17:902:d486:b0:1bf:25d7:6fc1 with SMTP id
 c6-20020a170902d48600b001bf25d76fc1mr9316089plg.35.1692719888704; 
 Tue, 22 Aug 2023 08:58:08 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170902e80100b001b51b3e84cesm9196589plg.166.2023.08.22.08.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:58:08 -0700 (PDT)
Message-ID: <c538a498-05e4-23ed-328e-7355436f6c7a@linaro.org>
Date: Tue, 22 Aug 2023 08:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] tcg/tcg-op: Document bswap16() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/tcg-op.c | 48 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 7aadb37756..f164ddc95e 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1021,6 +1021,13 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
>       }
>   }
>   
> +/*
> + * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
> + *
> + * Byte pattern:  bswap16_i32(xxab) -> ..ba             (TCG_BSWAP_OZ)
> + *                bswap16_i32(xxab) -> ssba             (TCG_BSWAP_OS)
> + *                bswap16_i32(xxab) -> xxba
> + */

Don't forget TCG_BSWAP_IZ, which means the input is already zero-extended.
Which makes

> +                                            /* arg = xxab */
> +        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = .xxa */

this

>           if (!(flags & TCG_BSWAP_IZ)) {
> -            tcg_gen_ext8u_i32(t0, t0);
> +            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
>           }
>   
>           if (flags & TCG_BSWAP_OS) {
> -            tcg_gen_shli_i32(t1, arg, 24);
> -            tcg_gen_sari_i32(t1, t1, 16);
> +            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
> +            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
>           } else if (flags & TCG_BSWAP_OZ) {
> -            tcg_gen_ext8u_i32(t1, arg);
> -            tcg_gen_shli_i32(t1, t1, 8);
> +            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
> +            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
>           } else {
> -            tcg_gen_shli_i32(t1, arg, 8);
> +            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */

and this slightly inaccurate.

>           }
>   
> -        tcg_gen_or_i32(ret, t0, t1);
> +        tcg_gen_or_i32(ret, t0, t1);        /* ret = ssba */

This one is just confusing, since each of the three cases above have different outputs.


r~




r~


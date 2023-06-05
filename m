Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53C7227AF
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ATW-0006Dv-OX; Mon, 05 Jun 2023 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATU-0006CI-96; Mon, 05 Jun 2023 09:42:20 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATS-00016Y-M9; Mon, 05 Jun 2023 09:42:20 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1a28e087cf1so4038470fac.3; 
 Mon, 05 Jun 2023 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972536; x=1688564536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tzjEK5Wu5oxUTmuFdpuridHkIqSmxqiyXi5m0kAdOls=;
 b=K2X+dTjYjMNHRsgg8OD8333uYqcDH3pZngLSvkD6lNov1gSXOq50YC5/HZKr6iEhWQ
 L2+B0kWtoY0sXQwNG01auAWMenMibTxWtg1jxNyDY/CCr3VZGjYejbBK3inrxyenPiGh
 CDClWbQxZFv1om2C5zNKY54EY4IkgqBl1ks/rOqvWcv4w/yp/svpADpj6Fk4WY/D3jYC
 6lQ8PLWunIlZ41H9M9YgnkxJS6lcADAs3CWP5bfsoP0ZT5HVL39aylnqtg9+t2QRgCZ0
 az3Jw6DTK8bp/SBkKrV1zMY/ewnO7UNBG/Gi7cxLL5HXRpWf/mFlWMrTPOjvPm6Y7XE+
 arDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972536; x=1688564536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tzjEK5Wu5oxUTmuFdpuridHkIqSmxqiyXi5m0kAdOls=;
 b=XrMIg4UNFjMB6oYmY88IBrG6EXp/xUqyArWnGSLkpoUoPzZmXxp7rZZG8IVku6PQh2
 JfnpT70v+q32W+8BZEgJbO/zu+qnUhkpE6hgyh3GMagNyCkCbCz/ai9jqbaCKnbB2wmL
 64aVLjED/Ccd49lVkS1pjkL1BW1E50QAG/bF79A957VYfGtNilImnKrypZu795sA8hjw
 4wT9UTGBH9J4TGWn48oW/MfJ0+WPLSzRP4+5p5hHUMd4OrRwRGspSxlaubdROs4nFgUa
 JH+NWfmQzTAWsifM6MxfjW6O6kzuHlK+RAmKbXSl4ZaewaMPbYOoD5Twqg3A74DNGt+N
 WWYA==
X-Gm-Message-State: AC+VfDxpfBPoKOIVpgTjeaq1JW6rS5/ePm+NZFn9tfHrj258J4cnV4vw
 siImxyYt6C/Pxh7sC07XksI=
X-Google-Smtp-Source: ACHHUZ45yvZ2OlZFP32Q5ZCv+ku2Lqe7ElSiYmEvfRYfz/naAJNWaWxGyEhbDhUWGpABz3/6XOWVXw==
X-Received: by 2002:a05:6870:6247:b0:1a3:b43:9c88 with SMTP id
 r7-20020a056870624700b001a30b439c88mr1227098oak.34.1685972536551; 
 Mon, 05 Jun 2023 06:42:16 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a056870384400b0019fadc057d0sm3553696oal.25.2023.06.05.06.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:42:16 -0700 (PDT)
Message-ID: <d623c125-b3ef-0d96-0027-9e5ece2672fa@gmail.com>
Date: Mon, 5 Jun 2023 10:42:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] target/ppc: Remove larx/stcx. memory barrier
 semantics
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230605025445.161932-1-npiggin@gmail.com>
 <20230605025445.161932-3-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230605025445.161932-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 6/4/23 23:54, Nicholas Piggin wrote:
> larx and stcx. are not defined to order any memory operations.
> Remove the barriers.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued. Thanks,


Daniel

>   target/ppc/translate.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 538f757dec..acb99d8691 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3592,7 +3592,6 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
>       tcg_gen_mov_tl(cpu_reserve, t0);
>       tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
>       tcg_gen_mov_tl(cpu_reserve_val, gpr);
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>   }
>   
>   #define LARX(name, memop)                  \
> @@ -3836,11 +3835,6 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
>   
>       gen_set_label(l1);
>   
> -    /*
> -     * Address mismatch implies failure.  But we still need to provide
> -     * the memory barrier semantics of the instruction.
> -     */
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>       tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
>   
>       gen_set_label(l2);
> @@ -3944,11 +3938,6 @@ static void gen_stqcx_(DisasContext *ctx)
>       tcg_gen_br(lab_over);
>       gen_set_label(lab_fail);
>   
> -    /*
> -     * Address mismatch implies failure.  But we still need to provide
> -     * the memory barrier semantics of the instruction.
> -     */
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>       tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
>   
>       gen_set_label(lab_over);

